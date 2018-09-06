//
//  MyViewController.m
//  MobileHospital
//
//  Created by ZY on 2018/7/3.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *keshiLab;
@property (weak, nonatomic) IBOutlet UILabel *softVerLab;

@end

@implementation MyViewController

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MySB" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"MyViewController"];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"my_noCheckTabBar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"my_checkTabBar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

        self.title = @"我的";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [NSString stringWithFormat:@"V%@",[infoDic objectForKey:@"CFBundleShortVersionString"]];
    _softVerLab.text = app_Version;
}

- (IBAction)clickSignOutBtn:(id)sender {
    //点击退出登录
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"是否注销该账号？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
