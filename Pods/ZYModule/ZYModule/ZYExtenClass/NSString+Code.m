//
//  NSString+Code.m
//  AirHospital
//
//  Created by C_HAO on 15/8/27.
//  Copyright (c) 2015年 C_HAO. All rights reserved.
//

#import "NSString+Code.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Code)

+ (NSString *)isStringNull:(NSString *)str
{
    if(str == nil)
        return @"";
    return str;
}

+ (NSString *)isStringNull:(NSString *)str ToStr:(NSString *)toStr
{
    if(str == nil)
        return toStr;
    return str;
}

- (NSString *)urlEncodeUTF8String
{
    if (self) {
        return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSString *)urlEncodeUTF8String:(NSString *)stringText
{
    if (stringText == nil) {
        return nil;
    }
    NSString *urlStr = [stringText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return urlStr;
}

- (NSString *)urlDecodeUTF8String
{
    if (self) {
        return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSString *)urlDecodeUTF8String:(NSString *)stringText
{
    if (stringText == nil) {
        return nil;
    }
    
    NSString *urlStr = [stringText stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return urlStr;
}

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
@end
