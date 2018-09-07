//
//  LoginManagerModel.m
//  SmallCapitalBus
//
//  Created by ZY on 2018/4/16.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "LoginManagerModel.h"

@implementation LoginManagerModel

- (void)loginVerify:(NSString *)account withPwd:(NSString *)passwd Complete:(void(^)(void))success
{
//    // 网络通并且PushSession存在，获取Push通知并处理
//    if (kNetworkNotReachability)
//    {
//        [ToolsFunction showPromptViewWithString:@"无法连接网络，请检查你的数据网络连接。" background:nil timeDuration:1];
//        return;
//    }
    
    [BmobUser loginInbackgroundWithAccount:account andPassword:passwd block:^(BmobUser *user, NSError *error) {
        if (user) {
            success();
            //获取个人信息
            BmobQuery *query = [UserProfile query];
            [query whereKey:@"username" equalTo:user.username];
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                for (BmobObject *obj in array) {
                    UserProfile *t = [[UserProfile alloc] initFromBmobObject:obj];
                    [AppDelegate appDelegate].userProfile = t;
                }
            }];
        } else {
            NSLog(@"%@",error);
        }
    }];
}

- (void)Register:(NSString *)account withPwd:(NSString *)passwd Complete:(void(^)(void))success
{
    __weak typeof(self) vc = self;
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:account];
    [bUser setPassword:passwd];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"Sign up successfully");
            [vc saveUserProfile:account withPwd:passwd];
            success();
            [ToolsFunction showPromptViewWithString:@"注册成功" background:nil timeDuration:1];
        } else {
            NSLog(@"%@",error);
            if(error.code == 202){
                [ToolsFunction showPromptViewWithString:@"账号已存在" background:nil timeDuration:1];
            }else{
                [ToolsFunction showPromptViewWithString:@"注册失败" background:nil timeDuration:1];
            }
        }
    }];
}

-(void)saveUserProfile:(NSString *)account withPwd:(NSString *)passwd
{
    NSLog(@"UserProfile:-----------------saveUserProfiles");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (account) {
        [defaults setValue:account forKey:@"account"];
    }
    if (passwd) {
        [defaults setValue:passwd forKey:@"passwd"];
    }
    
    [defaults setValue:[NSString stringWithFormat:@"%ld",(long)self.autoLoginState] forKey:@"UserAutoLoginState"];
    [defaults synchronize];
}

@end
