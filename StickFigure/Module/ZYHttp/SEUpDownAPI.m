//
//  SEUpDownAPI.m
//  SkyEmergency
//
//  Created by ZY on 15/9/9.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "SEUpDownAPI.h"

@implementation SEUpDownAPI

+ (SEUpDownAPI *)sharedManager {
    static SEUpDownAPI *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[SEUpDownAPI alloc] init];
    });
    return _sharedManager;
}

+ (AFURLSessionManager *)af_manager{
    static AFURLSessionManager *_af_manager = nil;
    static dispatch_once_t af_onceToken;
    dispatch_once(&af_onceToken, ^{
        _af_manager= [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return _af_manager;
}

- (AFURLSessionManager *)af_manager{
    return [SEUpDownAPI af_manager];
}

+ (NSString *)baseURLStr
{
    //接口地址，上线修改为服务器获取
    NSString * baseURLStr;
    baseURLStr = [NSString stringWithFormat:@"%@//", DEFAULT_SEHTTP_ADDRESS];
    return baseURLStr;
}

-(SEDownLoadTask *)addDownloadPOSTForURL:(NSString *)apiName
                          isRefreshCache:(BOOL)isRefreshCache
                              parameters:(NSDictionary *)parameters
                            saveFileName:(NSString *(^)(void))saveFileName
                       completionHandler:(void (^)(NSData *fileData, NSURL *filePath, NSError *))completionHandler
{
    //缓存部分---硬盘缓存
//    if(isRefreshCache != YES)
//    {
//        //缓存部分---内存缓存  (由TMCache来做)
//        id cacheID = [[TMMemoryCache sharedCache] objectForKey:saveFileName()];
//        if(cacheID)
//        {
//            NSData * cacheData = (NSData *)cacheID;
//            NSURL * fileUrl = [NSURL fileURLWithPath:saveFileName()];
//            completionHandler(cacheData, fileUrl, nil);
//            return nil;
//        }
//
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSString * filePath = saveFileName();
//        if ([fileManager fileExistsAtPath:filePath])
//        {
//            NSData * data = [NSData dataWithContentsOfFile:filePath];
//            NSURL * fileUrl = [NSURL fileURLWithPath:saveFileName()];
//            completionHandler(data, fileUrl, nil);
//            [[TMMemoryCache sharedCache] setObject:data forKey:filePath];
//            return nil;
//        }
//    }
    //下载部分
    SEDownLoadTask *cTask = nil;
    cTask = [self addDownloadTaskPOSTWithUrl:apiName parameters:parameters saveFileName:saveFileName completionHandler:completionHandler];
    return cTask;
}

- (SEDownLoadTask *)addDownloadTaskPOSTWithUrl:(NSString *)apiName
                                    parameters:(NSDictionary *)parameters
                              saveFileName:(NSString *(^)(void))saveFileName
                         completionHandler:(void (^)(NSData *fileData, NSURL *filePath, NSError *error))completionHandler
{
    NSProgress *progress;

    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",[SEUpDownAPI baseURLStr],apiName];

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:parameters error:nil];

    NSURLSessionDownloadTask *downloadTask = [self.af_manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        NSString * fileOldPath = saveFileName();
        if(saveFileName() == nil)
        {
            return nil;
        }
        NSURL *fileUrl = [NSURL fileURLWithPath:fileOldPath];

        NSFileManager *fileManager = [NSFileManager defaultManager];

        if([fileManager fileExistsAtPath:fileOldPath]) //如果存在,删除旧的。不删除会导致fileurl缓存问题
        {
            [fileManager removeItemAtPath:fileOldPath error:nil];
        }

        return fileUrl;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {

        NSLog(@"\n===========response===========\n%@:\n%@", apiName, response);

        NSData *data = [NSData dataWithContentsOfFile:[[NSString stringWithFormat:@"%@",filePath] stringByReplacingOccurrencesOfString:@"file://" withString:@""]];

//        [[TMMemoryCache sharedCache] setObject:data forKey:saveFileName()];

        if (completionHandler) {
            completionHandler(data, filePath, nil);
        }
    }];
    
    SEDownLoadTask *cDownloadTask = [SEDownLoadTask downLoadTask:downloadTask progress:progress fileName:saveFileName()];
    [downloadTask resume];
    return cDownloadTask;
}

- (SEDownLoadTask *)addDownloadGETForURL:(NSString *)url
                          isRefreshCache:(BOOL)isRefreshCache
                            saveFileName:(NSString *(^)(void))saveFileName
                       completionHandler:(void (^)(NSData *fileData, NSURL * filePath, NSError *error))completionHandler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];

    if(isRefreshCache != YES)
    {
        //缓存部分---内存缓存  (由TMCache来做)
//        id cacheID = [[TMMemoryCache sharedCache] objectForKey:saveFileName()];
//        if(cacheID)
//        {
//            NSData * cacheData = (NSData *)cacheID;
//            NSURL * fileUrl = [NSURL fileURLWithPath:saveFileName()];
//            completionHandler(cacheData, fileUrl, nil);
//            return nil;
//        }
        //缓存部分---硬盘缓存
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString * filePath = saveFileName();
        if ([fileManager fileExistsAtPath:filePath])
        {
            NSData * data = [NSData dataWithContentsOfFile:filePath];
            NSURL * fileUrl = [NSURL fileURLWithPath:saveFileName()];
            completionHandler(data, fileUrl, nil);
//            [[TMMemoryCache sharedCache] setObject:data forKey:filePath];
            return nil;
        }
    }
    
    //下载部分
    SEDownLoadTask *cTask = nil;
    cTask = [self addDownloadTaskGETWithRequest:request saveFileName:saveFileName completionHandler:completionHandler];
    return cTask;
}

- (SEDownLoadTask *)addDownloadTaskGETWithRequest:(NSURLRequest *)request
                                  saveFileName:(NSString *(^)(void))saveFileName
                             completionHandler:(void (^)(NSData *fileData, NSURL *filePath, NSError *error))completionHandler
{
    NSProgress *progress;
    
    NSURLSessionDownloadTask *downloadTask = [self.af_manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSString * fileOldPath = saveFileName();
        if(saveFileName() == nil)
        {
            return nil;
        }
        NSURL *fileUrl = [NSURL fileURLWithPath:fileOldPath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if([fileManager fileExistsAtPath:fileOldPath]) //如果存在,删除旧的。不删除会导致fileurl缓存问题
        {
            [fileManager removeItemAtPath:fileOldPath error:nil];
        }
        
        return fileUrl;
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        NSData *data = [NSData dataWithContentsOfFile:[[NSString stringWithFormat:@"%@",filePath] stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
        
//        [[TMMemoryCache sharedCache] setObject:data forKey:saveFileName()];

        if (completionHandler) {
            completionHandler(data, filePath, error);
        }
        
    }];
    SEDownLoadTask *cDownloadTask = [SEDownLoadTask downLoadTask:downloadTask progress:progress fileName:saveFileName()];
    [downloadTask resume];
    return cDownloadTask;
}

//后期优化
//- (NSString *)cachedFileNameForKey:(NSString *)key {
//    const char *str = [key UTF8String];
//    if (str == NULL) {
//        str = "";
//    }
//    unsigned char r[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, (CC_LONG)strlen(str), r);
//    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
//                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
//                          r[11], r[12], r[13], r[14], r[15], [[key pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", [key pathExtension]]];
//    
//    return filename;
//}

//取消所有请求
-(void)canelRequestAll
{
    [self.af_manager.operationQueue cancelAllOperations];
}

@end

@implementation SEDownLoadTask

+ (SEDownLoadTask *)downLoadTask:(NSURLSessionDownloadTask *)task progress:(NSProgress *)progress fileName:(NSString *)fileName{

    SEDownLoadTask * downLoadTask = [[SEDownLoadTask alloc]init];
    downLoadTask.task = task;
    downLoadTask.progress = progress;

    return downLoadTask;
}

- (void)cancel{
    if (self.task) {
        [self.task cancel];
    }
}

@end
