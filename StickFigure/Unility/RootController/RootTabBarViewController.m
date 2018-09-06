//
//  RootViewController.m
//  MobileHospital
//
//  Created by ZY on 2016/10/11.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "RootNavigationViewController.h"
#import "StickFigureViewController.h"
#import "MyViewController.h"

@interface RootTabBarViewController () <CYLTabBarControllerDelegate>

@property(nonatomic, strong)StickFigureViewController *stickFigureViewController;

@property(nonatomic, strong)RootNavigationViewController *stickFigureNaviagtionController;

@property(nonatomic, strong)MyViewController *myViewController;

@property(nonatomic, strong)RootNavigationViewController *myNaviagtionController;

@end

@implementation RootTabBarViewController

- (StickFigureViewController *)stickFigureViewController
{
    if (!_stickFigureViewController) {
        _stickFigureViewController = [[StickFigureViewController alloc] init];
    }
    return _stickFigureViewController;
}

- (MyViewController *)myViewController
{
    if (!_myViewController) {
        _myViewController = [[MyViewController alloc] init];
    }
    return _myViewController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [CYLPlusButtonSubclass registerPlusButton];

        self.tabBar.tintColor = [UIColor appTabBarColor];
        self.tabBar.itemPositioning = UITabBarItemPositioningCentered;

        [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor appTabBarColor]} forState:UIControlStateSelected];
        
        
        
        self.stickFigureNaviagtionController = [[RootNavigationViewController alloc] initWithRootViewController:self.stickFigureViewController];
        
        self.myNaviagtionController = [[RootNavigationViewController alloc] initWithRootViewController:self.myViewController];
        
        UIEdgeInsets imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
        NSArray *tabBarItemTitle = @[@"简笔画",@"我的"];
        NSArray *tabBarItemImages = @[@"work_CheckTabBar",@"my_CheckTabBar"];
        NSMutableArray * tabbarItemInfo = [[NSMutableArray alloc]init];
        for (int i=0; i<2; i++) {
            
            NSDictionary *dict = @{
                                   CYLTabBarItemTitle : [tabBarItemTitle objectAtIndex:i],
                                   CYLTabBarItemImage : [NSString stringWithFormat:@"%@_nor",[tabBarItemImages objectAtIndex:i]],
                                   CYLTabBarItemSelectedImage : [NSString stringWithFormat:@"%@_sel",[tabBarItemImages objectAtIndex:i]],
                                   };
            [tabbarItemInfo addObject:dict];
        }
        //    [self setTabBarItemsAttributes:tabbarItemInfo];
        //    [self setViewControllers:@[self.stickFigureNaviagtionController, self.myNaviagtionController]];
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:@[self.stickFigureNaviagtionController, self.myNaviagtionController]
                                                                                   tabBarItemsAttributes:tabbarItemInfo
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment
                                                 ];
        self = (RootTabBarViewController *)tabBarController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
