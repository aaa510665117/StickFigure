//
//  NSString+Code.h
//  AirHospital
//
//  Created by C_HAO on 15/8/27.
//  Copyright (c) 2015年 C_HAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Code)

+ (NSString *)isStringNull:(NSString *)str;

+ (NSString *)isStringNull:(NSString *)str ToStr:(NSString *)toStr;

- (NSString *)urlEncodeUTF8String;

- (NSString *)urlDecodeUTF8String;


/**
 *  启用URL编码
 *
 *  @param stringText
 *
 *  @return
 */
+ (NSString *)urlEncodeUTF8String:(NSString *)stringText;



/**
 *  URL解码编码
 *
 *  @param stringText
 *
 *  @return
 */
+ (NSString *)urlDecodeUTF8String:(NSString *)stringText;

/**
 *  MD5
 *
 *  @return
 */
- (NSString *)MD5;

@end
