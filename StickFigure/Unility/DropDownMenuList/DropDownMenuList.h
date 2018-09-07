//
//  MyViewController.h
//  MobileHospital
//
//  Created by ZY on 2018/7/3.
//  Copyright © 2018年 ZY. All rights reserved.
//

#pragma mark - 选择菜单封装类

#import <UIKit/UIKit.h>

typedef void (^ClickIndex)(long cindex);                //单选后的结果
typedef void (^ClickChoseMulti)(NSArray *cindexAry);    //多选后的结果

@interface DropDownMenuList : UIView <UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, copy) ClickIndex clickIndex;
@property (nonatomic, copy) ClickChoseMulti clickChoseMulti;

@property (nonatomic, assign) BOOL isMultiSelect;    //是否多选
@property (nonatomic, assign) BOOL isCanMatchStr;    //是否需要搜索内容

//显示选择菜单
/*
 buttonFrame
 titleArr 选择菜单的文本数组
 */
- (void)showDropDownMenu:(CGRect)buttonFrame arrayOfTitle:(NSArray *)titleArr;
@end
