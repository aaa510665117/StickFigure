//
//  UIViewController+ColorState.m
//  圆梦庄园
//
//  Created by C_HAO on 2016/11/15.
//  Copyright © 2016年 C_HAO. All rights reserved.
//

#import "UIViewController+ColorState.h"

@implementation UIViewController (ColorState)

- (void)navigationBarTransparent
{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[ToolsFunction imageWithColor:[UIColor clearColor] size:CGSizeMake(CGRectGetWidth(self.navigationController.navigationBar.frame), CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[ToolsFunction imageWithColor:[UIColor clearColor] size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 1)]];
    self.navigationController.navigationBar.tintColor = [UIColor appNavigationTintColor];
}

- (void)navigationBarDefault
{
    [self.navigationController.navigationBar setShadowImage:[ToolsFunction imageWithColor:[UIColor clearColor] size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 1)]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor appNavigationTextColor] forKey:NSForegroundColorAttributeName]];
    [self.navigationController.navigationBar setBackgroundImage:[ToolsFunction imageWithColor:[UIColor appNavigationColor] size:CGSizeMake(CGRectGetWidth(self.navigationController.navigationBar.frame), CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor appNavigationTintColor];
}

- (void)navigationBarColor:(UIColor *)backColor withTitleColor:(UIColor *)titleColor withTintColor:(UIColor *)tintColor
{
    [self.navigationController.navigationBar setShadowImage:[ToolsFunction imageWithColor:[UIColor clearColor] size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 1)]];
    if (titleColor) {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:titleColor forKey:NSForegroundColorAttributeName]];
    }
    
    if (backColor) {
        [self.navigationController.navigationBar setBackgroundImage:[ToolsFunction imageWithColor:backColor size:CGSizeMake(CGRectGetWidth(self.navigationController.navigationBar.frame), CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (tintColor) {
        self.navigationController.navigationBar.tintColor = tintColor;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor appNavigationTintColor];
    }
}


@end
