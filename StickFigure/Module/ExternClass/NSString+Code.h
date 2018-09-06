//
//  NSString+Code.h
//
//  Created by C_HAO on 15/8/27.
//  Copyright (c) 2015年 C_HAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Code)

+ (NSString *)isStringNull:(NSString *)str;

- (NSString *)urlEncodeUTF8String;

- (NSString *)urlDecodeUTF8String;
/**
 *  启用URL编码
 *
 */
+ (NSString *)urlEncodeUTF8String:(NSString *)stringText;

/**
 *  URL解码编码
 *
 */
+ (NSString *)urlDecodeUTF8String:(NSString *)stringText;

/**
 *  MD5
 */
- (NSString *)MD5;

/**
 *  补充url编码函数(目前只对API参数过滤特殊符号使用，url编码统一使用urlEncodeUTF8String)
 *
 */
+ (NSString *)encodeURL:(NSString *)stringText;

/**
 *  获取 ABCD... 0123...
 *
 */
+ (NSString *)letterIndex:(int)index;
/**
 *  获取字母序号
 *
 */
+ (NSInteger)letterNumber:(NSString *)letter;

/**
 *  Unicode乱码
 *
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

@end
