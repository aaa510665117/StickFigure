//
//  UIColor+App.h
//  圆梦庄园
//
//  Created by C_HAO on 2016/10/17.
//  Copyright © 2016年 C_HAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (App)


+ (UIColor *)appNavigationColor;
+ (UIColor *)appNavigationTextColor;
+ (UIColor *)appNavigationTintColor;
+ (UIColor *)appViewBackColor;
+ (UIColor *)appTabBarColor;

+ (UIColor *)appDarklyColor;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
