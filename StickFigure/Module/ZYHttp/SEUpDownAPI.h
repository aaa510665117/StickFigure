//
//  SEUpDownAPI.h
//  SkyEmergency
//
//  Created by ZY on 15/9/9.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class SEDownLoadTask;

@interface SEUpDownAPI : NSObject <NSURLSessionDataDelegate>

+ (SEUpDownAPI *)sharedManager;

+ (AFURLSessionManager *)af_manager;

- (AFURLSessionManager *)af_manager;

/**
 *  POST请求文件
 *
 *  @param parameters        传递参数
 *  @param saveFileName      保存路径
 *  @param completionHandler 完成后处理
 *
 *  @return 返回Task管理
 */
- (SEDownLoadTask *)addDownloadPOSTForURL:(NSString *)apiName
                           isRefreshCache:(BOOL)isRefreshCache
                               parameters:(NSDictionary *)parameters
                             saveFileName:(NSString *(^)(void))saveFileName
                        completionHandler:(void (^)(NSData *fileData, NSURL * filePath, NSError *error))completionHandler;

/**
 *  GET请求文件
 *
 *  @param url               文件url
 *  @isRefreshCache          是否需要更新本地缓存  （服务器原文件是否发生变化）
 *  @param saveFileName      保存路径
 *  @param completionHandler 完成后处理
 *
 *  @return 返回Task管理
 */
- (SEDownLoadTask *)addDownloadGETForURL:(NSString *)url
                          isRefreshCache:(BOOL)isRefreshCache
                            saveFileName:(NSString *(^)(void))saveFileName
                       completionHandler:(void (^)(NSData *fileData, NSURL * filePath, NSError *error))completionHandler;

/**
 *  取消请求
 */
-(void)canelRequestAll;

@end

@interface SEDownLoadTask : NSObject

@property (strong, nonatomic) NSURLSessionDownloadTask *task;
@property (strong, nonatomic) NSProgress * progress;

+ (SEDownLoadTask *)downLoadTask:(NSURLSessionDownloadTask *)task progress:(NSProgress *)progress fileName:(NSString *)fileName;

/**
 *  取消下载请求
 */
- (void)cancel;

@end


//--------------------------------------demo--------------------------------------//
/*
// 判断路径是否存在，如果不存在则建立目录
NSFileManager *managerDir = [NSFileManager defaultManager];
BOOL isDirectory = NO;
if (NO == [managerDir fileExistsAtPath:USER_IMAGE_PATH isDirectory:&isDirectory])
{
    [managerDir createDirectoryAtPath:USER_IMAGE_PATH withIntermediateDirectories:YES attributes:nil error:nil];
}

SEUpDownAPI * seDonw = [SEUpDownAPI sharedManager];
NSString * url = @"http://117.34.72.251:80/yixin/1.0/get_circle_picture.php";
NSMutableDictionary * temp = [[NSMutableDictionary alloc]init];
[temp setValue:@"1" forKey:@"flag"];
[temp setValue:@"1" forKey:@"ct"];
[temp setValue:@"h8nAfquKsApF4iW1ntyzroJtIzjtYxNh" forKey:@"ss"];
[temp setValue:@"1881" forKey:@"title_id"];
[temp setValue:@"1" forKey:@"img_id"];

//__weak typeof(self) weakSelf = self;
SEDownLoadTask * seDownTask = [seDonw addDownloadPOSTForURL:url parameters:temp saveFileName:^NSString *{
    return @"/Image/1.jpg";
} completionHandler:^(NSData *fileData, NSError *error) {
    if (error)
    {
        DDLogInfo(@"ERROR:%@", error.description);
    }
    else
    {
        UIImage *image = [UIImage imageWithData: fileData];
        NSLog(@"123%@",image);
    }
}];
 [self showProgress:_textView withProgress:seDownTask.progress];
 
 -(void)showProgress:(UIView *)showView withProgress:(NSProgress *)progress
 {
 if(!showView)
 {
 return;
 }
 UIActivityIndicatorView * activeInd = [[UIActivityIndicatorView alloc]init];
 self.activeInd = activeInd;
 
 [showView addSubview:self.activeInd];
 
 [self.activeInd startAnimating];
 
 [self.activeInd mas_makeConstraints:^(MASConstraintMaker *make) {
 make.center.mas_equalTo(showView);
 make.size.mas_equalTo(CGSizeMake(20, 20));
 }];
 
 @weakify(self);
 [RACObserve(progress, fractionCompleted)
 //takeUntil:[RACSignal combineLatest:@[self.rac_prepareForReuseSignal, self.rac_willDeallocSignal]]
 subscribeNext:^(NSNumber * isDown) {
 @strongify(self);
 dispatch_async(dispatch_get_main_queue(), ^{
 [self updateCompleted:isDown.floatValue];
 });
 }];
 }
 
 - (void)updateCompleted:(float)isDown{
 //更新进度
 NSLog(@"%f",isDown);
 if (isDown == 1) {
 //已完成
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 [self.activeInd stopAnimating];
 [self.activeInd removeFromSuperview];
 });
 }
 }
*/
