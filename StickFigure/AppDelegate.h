//
//  AppDelegate.h
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StickFigureViewController.h"
#import <UMCommon/UMCommon.h> 
#import <UMAnalytics/MobClick.h>        // 统计组件

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) StickFigureViewController * manViewConTroller;

+ (AppDelegate *)appDelegate;

@end

