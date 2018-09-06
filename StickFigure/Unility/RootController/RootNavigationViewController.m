//
//  RootNavigationViewController.m
//  MobileHospital
//
//  Created by C_HAO on 2016/10/11.
//  Copyright © 2016年 C_HAO. All rights reserved.
//

#import "RootNavigationViewController.h"


@interface RootNavigationViewController () 

@end

@implementation RootNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [rootViewController navigationBarDefault];
    }
    return self;
}

- (instancetype)initWithRootConfigurationViewController:(UIViewController *)rootViewController
{
    self = [self initWithRootViewControllerNoWrapping:rootViewController];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.useSystemBackBarButtonItem = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
