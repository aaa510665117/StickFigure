//
//  UserProfile.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : BmobObject

@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *userImage;

@end
