//
//  StickFigureImgObj.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

typedef enum{
    SFTypeAnimal,       //动物
    SFTypeFruit,        //果蔬
    SFTypePreson,       //人物
    SFTypeTraffic,      //交通工具
}SFType;

@interface StickFigureImgObj : BmobObject

@property(nonatomic, strong) BmobUser * userInfo;
@property(nonatomic, strong) NSString * type;
@property(nonatomic, strong) NSArray * imageGroup;

+(NSArray *)getTypeAry;

@end
