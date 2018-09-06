//
//  RootViewController.m
//  MobileHospital
//
//  Created by C_HAO on 2016/11/8.
//  Copyright © 2016年 C_HAO. All rights reserved.
//

#import "RootViewController.h"
#import "RootNavigationViewController.h"
#import "UIViewController+RTRootNavigationController.h"

@interface RootViewController () 

@end

@implementation RootViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersHomeIndicatorAutoHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationBarDefault];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:(UIBarButtonItemStylePlain) target:target action:action];
    barButtonItem.imageInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    return barButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
