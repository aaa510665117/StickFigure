//
//  DiyMjRefreshFooter.m
//  MobileHospital
//
//  Created by 扬张 on 2018/8/2.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "DiyMjRefreshFooter.h"

@implementation DiyMjRefreshFooter

- (void)prepare
{
    [super prepare];
    [self setTitle:@"~~~" forState:MJRefreshStateNoMoreData];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.stateLabel.textColor = [UIColor lightGrayColor];
}

@end
