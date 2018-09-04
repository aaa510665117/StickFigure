//
//  SEHttpAPI.h
//  SkyEmergency
//
//  Created by ZY on 15/9/17.
//  Copyright (c) 2015年 ZY. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ZYHttpAPI : AFHTTPSessionManager

+ (ZYHttpAPI *)sharedUpDownAPI;

/**
 *  请求地址
 */
+ (NSString *)baseURLStr;

/**
 *  普通Get请求Json数据
 *
 *  @param ApiName api名称
 *  @param params  入参
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)requestGetOrdinary:(NSString *)ApiName
            withParams:(NSDictionary *)params
           withSuccess:(void(^)(NSDictionary *success))success
           withFailure:(void(^)(NSDictionary *failure))failure;

/**
 *  普通POST请求Json数据
 *
 *  @param ApiName api名称
 *  @param params  入参
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)requestOrdinary:(NSString *)ApiName
            withParams:(NSDictionary *)params
           withSuccess:(void(^)(NSDictionary *success))success
           withFailure:(void(^)(NSDictionary *failure))failure;

/**
 *  POST上传单文件
 *
 *  @param apiurl   服务器地址
 *  @param file     文件
 *  @param param    传参
 *  @param name     字段名称
 *  @param fileName 服务器文件名称
 *  @param success  成功block
 *  @param failure  失败block
 */
- (NSURLSessionDataTask *)uploadFile:(NSString *)apiurl
          withFile:(NSObject *)file
          withParam:(NSMutableDictionary *)param
               name:(NSString *)name
           fileName:(NSString *)fileName
       successBlock:(void(^)(NSDictionary *success))success
       failureBlock:(void(^)(NSDictionary *failure))failure;

/**
 *  POST上传多文件
 *
 *  @param apiurl   服务器地址
 *  @param fileAry     多文件集合
 *  @param param    传参
 *  @param name     字段名称集合
 *  @param fileNameAry 服务器文件名称集合
 *  @param success  成功block
 *  @param failure  失败block
 */
- (NSURLSessionDataTask *)uploadMultipartFile:(NSString *)apiurl
                            withFile:(NSArray *)fileAry
                           withParam:(NSMutableDictionary *)param
                                name:(NSArray *)name
                            fileName:(NSArray *)fileNameAry
                        successBlock:(void(^)(NSDictionary *success))success
                        failureBlock:(void(^)(NSDictionary *failure))failure;

//Data-->JSON解析
+(NSDictionary *)ZYHttpJSON:(NSData *)dataStr;

//String-->JSON解析
+(NSDictionary *)ZYHttpStrToJSON:(NSString *)str;

/**
 *  取消请求
 */
-(void)canelRequestAll;

/**
 *  基本错误码分析
 *
 *  @param code         错误码
 *  @param requestAdd   请求地址
 */
+(void)analysisErrorCode:(NSDictionary *)code withRequestAdd:(NSString *)requestAdd;

@end
