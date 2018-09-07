//
//  StickFigureImgObj.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StickFigureImgObj : BmobObject

@property(nonatomic, strong) BmobUser * userInfo;
@property(nonatomic, strong) NSString * type;
@property(nonatomic, strong) NSArray * imageGroup;

+(NSArray *)getTypeAry;

@end
