//
//  StickFigureImgObj.m
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "StickFigureImgObj.h"

@implementation StickFigureImgObj

@synthesize userInfo;
@synthesize type;
@synthesize imageGroup;

+(NSArray *)getTypeAry
{
    return @[@"动物",@"果蔬",@"动漫",@"交通工具"];
}

@end
