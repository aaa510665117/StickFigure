//
//  UIColor+App.m
//  圆梦庄园
//
//  Created by C_HAO on 2016/10/17.
//  Copyright © 2016年 C_HAO. All rights reserved.
//

#import "UIColor+App.h"

@implementation UIColor (App)

+ (UIColor *)appNavigationColor
{
    return [UIColor colorWithRed:225/255.0 green:125/255.0 blue:45/255.0 alpha:1.0];
}

+ (UIColor *)appNavigationTextColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)appNavigationTintColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)appViewBackColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)appTabBarColor
{
    return [UIColor colorWithRed:66/255.0 green:165/255.0 blue:249/255.0 alpha:1.0];
}

+ (UIColor *)appDarklyColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
