//
//  AppDelegate.h
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//  测试

#import <UIKit/UIKit.h>
#import "StickFigureViewController.h"
#import <UMCommon/UMCommon.h> 
#import <UMAnalytics/MobClick.h>        // 统计组件
#import "CYLTabBarController.h"
#import "RootTabBarViewController.h"
#import <BmobSDK/Bmob.h>
#import "LoginManagerModel.h"
#import "UserProfile.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, strong) StickFigureViewController * manViewConTroller;
@property (nonatomic, strong) RootTabBarViewController *mainTabBarController;
@property (nonatomic, strong) UserProfile * userProfile;
@property (nonatomic, strong) LoginManagerModel * loginManager;                 //用户登陆

-(void)showLoginNav;

+ (AppDelegate *)appDelegate;

-(BOOL)isLogin;

@end

