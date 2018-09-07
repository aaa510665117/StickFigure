//
//  LoginManagerModel.h
//  SmallCapitalBus
//
//  Created by ZY on 2018/4/16.
//  Copyright © 2018年 ZY. All rights reserved.
//  登录管理

#import <Foundation/Foundation.h>

@interface LoginManagerModel : NSObject
{
    BmobUser *userProfile;          // 个人用户的Profile
    NSThread * loginThread;         // 登录线程
}

@property (nonatomic) NSInteger autoLoginState;                              //Mobile Auto LoginCS/GetMyProfile Mode

// 登录服务器
- (void)loginVerify:(NSString *)account withPwd:(NSString *)passwd Complete:(void(^)(void))success;

- (void)Register:(NSString *)account withPwd:(NSString *)passwd Complete:(void(^)(void))success;

-(void)saveUserProfile:(NSString *)account withPwd:(NSString *)passwd;
@end
