//
//  NSString+Code.m
//
//  Created by C_HAO on 15/8/27.
//  Copyright (c) 2015年 C_HAO. All rights reserved.
//

#import "NSString+Code.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Code)

+ (NSString *)isStringNull:(NSString *)str
{
    if (str == nil) {
        return @"";
    }

    return str;
}

- (NSString *)urlEncodeUTF8String
{
    if (self) {
        return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }

    return nil;
}

+ (NSString *)urlEncodeUTF8String:(NSString *)stringText
{
    if (stringText == nil) {
        return nil;
    }

    return [stringText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)urlDecodeUTF8String
{
    if (self) {
        return [self stringByRemovingPercentEncoding];
    }

    return nil;
}

+ (NSString *)urlDecodeUTF8String:(NSString *)stringText
{
    if (stringText == nil) {
        return nil;
    }

    return [stringText stringByRemovingPercentEncoding];
}

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)encodeURL:(NSString *)stringText
{
    if (!stringText) {
        return @"";
    }

    NSArray *charSet = [NSArray arrayWithObjects:@"&", @"+", @",", @"/", @":", @";", @"=", @"?", @"@", @" ", @"\t", @"#", @"<", @">", @"\"", @"\n", nil];
    NSArray *codeSet = [NSArray arrayWithObjects:@"%26", @"%2B", @"%2C", @"%2F", @"%3A", @"%3B", @"%3D", @"%3F", @"%40", @"%20", @"%09", @"%23", @"%3C", @"%3E", @"%22", @"%0A", nil];

    NSMutableString *url = [NSMutableString stringWithString:stringText];
    assert([charSet count] == [codeSet count]);

    for (int i = 0; i < [charSet count]; i++) {
        NSRange range = NSMakeRange(0, [url length]);
        [url replaceOccurrencesOfString:[charSet objectAtIndex:i] withString:[codeSet objectAtIndex:i] options:NSCaseInsensitiveSearch range:range];
    }

    return [NSString stringWithString:url];
}

+ (NSString *)letterIndex:(int)index
{
    int ascii = 65 + index;

    return [NSString stringWithFormat:@"%c", ascii];
}

+ (NSInteger)letterNumber:(NSString *)letter
{
    NSInteger ascii = [letter characterAtIndex:0];

    return ascii - 65;
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    unicodeStr = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    unicodeStr = [unicodeStr stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    unicodeStr = [[@"\""stringByAppendingString:unicodeStr] stringByAppendingString:@"\""];
    NSData *tempData = [unicodeStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *unicode = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return [unicode stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


@end
