//
//  UIViewController+ColorState.h
//  圆梦庄园
//
//  Created by C_HAO on 2016/11/15.
//  Copyright © 2016年 C_HAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ColorState)

//状态栏透明
- (void)navigationBarTransparent;
//状态栏默认
- (void)navigationBarDefault;
//设置导航栏颜色
- (void)navigationBarColor:(UIColor *)backColor withTitleColor:(UIColor *)titleColor withTintColor:(UIColor *)tintColor;

@end
