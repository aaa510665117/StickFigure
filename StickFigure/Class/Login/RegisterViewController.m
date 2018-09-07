//
//  RegisterViewController.m
//  SkyEmergency
//
//  Created by ZY on 15/10/19.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *registerMobileText;       //手机号码输入框
@property (weak, nonatomic) IBOutlet UITextField *registerNameText;         //用户名输入框

@end

@implementation RegisterViewController

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StartSB" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
        self.title = @"注册";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//点击下一步按钮
- (IBAction)clickRegistNext:(id)sender {
    
    //点击注册按钮
    if(_registerMobileText.text.length != 11)
    {
        //手机号异常判断
        [ToolsFunction showPromptViewWithString:@"请输入11位手机号" background:nil timeDuration:1];
        return;
    }
    else if(_registerNameText.text.length == 0)
    {
        //密码异常判断
        [ToolsFunction showPromptViewWithString:@"请设置密码" background:nil timeDuration:1];
        return;
    }
    else
    {
        __weak typeof(self)vc = self;
        [[AppDelegate appDelegate].loginManager Register:_registerMobileText.text withPwd:_registerNameText.text Complete:^{
            [vc.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }];
    }
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
