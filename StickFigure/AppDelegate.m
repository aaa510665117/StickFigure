//
//  AppDelegate.m
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "AppDelegate.h"
#import "SignViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Override point for customization after application launch.
    
    //load App
    [self launchApp:launchOptions];
    
    //用户数据
    [self initTripartite];
    
    return YES;
}

-(void)initTripartite
{
    _userProfile = [[UserProfile alloc] initFromBmobObject:[BmobUser currentUser]];
    _loginManager = [[LoginManagerModel alloc]init];

    //Bmob
    [Bmob registerWithAppKey:BMOB_KEY];
    
    [UMConfigure initWithAppkey:Umeng_APPKey channel:@"App Store"];
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
}

- (void)launchApp:(NSDictionary *)launchOptions{
    [self showMainTabNav];
}

//主TabBar
-(void)showMainTabNav
{
    _mainTabBarController = [[RootTabBarViewController alloc] init];
    self.window.rootViewController = self.mainTabBarController;
    [self.window makeKeyAndVisible];
}

//登录与注册
-(void)showLoginNav
{
    SignViewController *startViewController = [[SignViewController alloc]init];
    UINavigationController * startNav = [[UINavigationController alloc]initWithRootViewController:startViewController];
    [[ToolsFunction getCurrentRootViewController].navigationController  presentViewController:startNav animated:YES completion:nil];
}

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

-(BOOL)isLogin
{
    BmobUser *bUser = [BmobUser currentUser];
    if(bUser){
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
@end
