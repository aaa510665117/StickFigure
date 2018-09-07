//
//  Definition.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/5.
//  Copyright © 2018年 ZY. All rights reserved.
//

#ifndef Definition_h
#define Definition_h
#import <UIKit/UIKit.h>

#define Umeng_APPKey @"5b8f418ef29d9827e6000061"

UIKIT_EXTERN NSString * const SendColorAndWidthNotification;

//是否是iPhone X
#define is_iPhoneX          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//状态栏高度
#define StatusBarHeight     (is_iPhoneX ? 44.f : 20.f)
// 导航高度
#define NavigationBarHeight 44.f

#endif /* Definition_h */
