//
//  DiyMjRefresh.m
//  SkyEmergency
//
//  Created by ZY on 16/8/8.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "DiyMjRefresh.h"

@interface DiyMjRefresh()

@property (weak, nonatomic) UILabel *label;

@end

@implementation DiyMjRefresh
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    [self addSubview:label];
    label.text = @"~~~";
    self.label = label;

    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=32; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pullframe_000%zd",i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages duration:10 forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullImages = [NSMutableArray array];
    UIImage *pullImage = [UIImage imageNamed:[NSString stringWithFormat:@"pullframe_00032"]];
    [pullImages addObject:pullImage];
    [self setImages:pullImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 33; i<=103; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%zd",i]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages  duration:5 forState:MJRefreshStateRefreshing];

    [self setTitle:@"123" forState:MJRefreshStateRefreshing];

    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

//#pragma mark 监听控件的刷新状态
//- (void)setState:(MJRefreshState)state
//{
//    MJRefreshCheckState;
//    
//    switch (state) {
//        case MJRefreshStateIdle:
//            self.label.text = @"赶紧下拉吖";
//            break;
//        case MJRefreshStatePulling:
//            self.label.text = @"赶紧放开我吧";
//            break;
//        case MJRefreshStateRefreshing:
//            self.label.text = @"加载数据中";
//            break;
//        default:
//            break;
//    }
//}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.gifView.center = CGPointMake(self.center.x, self.gifView.center.y+15);
    self.gifView.tintColor = [UIColor blueColor];
    self.label.center = CGPointMake(self.center.x, self.gifView.center.y-20);
}

@end
