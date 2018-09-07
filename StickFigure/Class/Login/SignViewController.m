//
//  SignViewController.m
//  MobileHospital
//
//  Created by ZY on 2018/7/3.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "SignViewController.h"
#import "AFViewShaker.h"
#import "RegisterViewController.h"

@interface SignViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobelTextView;
@property (weak, nonatomic) IBOutlet UITextField *validateTextView;

@property (weak, nonatomic) IBOutlet UIButton *clearPassBtn;                //清除密码Btn
@property (weak, nonatomic) IBOutlet UIButton *isSeePassBtn;                //密码可见Btn
@property (weak, nonatomic) IBOutlet UIButton *isAutoLoginBtn;              //自动登录Btn
@property (weak, nonatomic) IBOutlet UIButton *setNetBtn;                   //网络配置Btn
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;                    //登录按钮

@end

@implementation SignViewController

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StartSB" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"SignViewController"];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *canelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    canelButton.backgroundColor = [UIColor clearColor];
    canelButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    canelButton.frame = CGRectMake(0, 0, 48, 40);
    [canelButton setTitle:@"取消" forState:UIControlStateNormal];
    [canelButton addTarget:self action:@selector(clickCanelButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *canelButtonItem = [[UIBarButtonItem alloc]initWithCustomView:canelButton];
    self.navigationItem.leftBarButtonItem = canelButtonItem;
    
    _validateTextView.secureTextEntry = NO;
    _isSeePassBtn.selected = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    NSString * userAccountNumber = [defaults stringForKey:@"account"];
    if(![userAccountNumber isEqualToString:@""])
    {
        _mobelTextView.text = userAccountNumber;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}

- (void)clickCanelButton {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)clickSignBtn:(id)sender {
    //点击登录
    NSMutableArray *views = [NSMutableArray array];
    //登录
    if([_mobelTextView.text isEqualToString:@""]) {
        [views addObject:_mobelTextView];
    }
    if([_validateTextView.text isEqualToString:@""]){
        [views addObject:_validateTextView];
    }
    if (views.count) {
        AFViewShaker *shaker = [[AFViewShaker alloc] initWithViewsArray:views];
        [shaker shake];
    }else {
        __weak typeof(self) vc = self;
        [[AppDelegate appDelegate].loginManager loginVerify:_mobelTextView.text withPwd:_validateTextView.text Complete:^{
            [vc.navigationController dismissViewControllerAnimated:YES completion:^{
            }];            
        }];
    }
}

- (IBAction)clickClearPassBtn:(id)sender {
    //点击清除密码
    _validateTextView.text = @"";
}

- (IBAction)clickIsSeePassBtn:(id)sender {
    //点击密码是否可见
    _isSeePassBtn.selected = !_isSeePassBtn.selected;
    _validateTextView.secureTextEntry = !_validateTextView.secureTextEntry;
}

- (IBAction)clickRegistrBtn:(id)sender {
    //注册
    RegisterViewController * registerView = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerView animated:YES];
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
