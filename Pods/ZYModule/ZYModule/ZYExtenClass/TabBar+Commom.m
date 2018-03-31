//
//  TabBar+Commom.m
//  SkyEmergency
//
//  Created by ZY on 15/10/16.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import "TabBar+Commom.h"

@implementation UITabBar (Commom)

-(void)showSelectImage:(long)index
{
    //移除之前的小红点
    [self hideSelectImage:index];
    
    UIImageView *dotView = [[UIImageView alloc]init];
    dotView.tag = 5000 + index;
    dotView.layer.cornerRadius =0;
    dotView.backgroundColor = [UIColor colorWithRed:0.867 green:0.251 blue:0.231 alpha:0.080];
    CGRect tabFrame = self.frame;
    //frame
    float percentX = (index +0.0) / TabBarNum;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    dotView.frame = CGRectMake(x, 0, tabFrame.size.width/TabBarNum, tabFrame.size.height);
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -0.5, dotView.frame.size.width, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:0.867 green:0.251 blue:0.231 alpha:1.000];
    [dotView addSubview:lineLabel];
    [self insertSubview:dotView atIndex:1];
}

- (void)hideSelectImage:(long)index
{
    //按照tag值进行移除
    for (UIImageView *subView in self.subviews) {
        
        if (subView.tag >= 5000) {
            [subView removeFromSuperview];
        }
    }
}

//-------index  tabbar所在位置 0开始
- (void)showDotMarkIndex:(int)index
{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    UIView *dotView = [[UIView alloc]init];
    dotView.tag = 4802 + index;
    dotView.layer.cornerRadius = 5;
    dotView.backgroundColor = [UIColor colorWithRed:0.867 green:0.251 blue:0.231 alpha:1.000];
    CGRect tabFrame = self.frame;
    
    //frame
    float percentX = (index +0.7) / TabBarNum;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    dotView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:dotView];
}

- (void)hideDotMarkIndex:(int)index
{
    //remove
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index
{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 4802+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:subView];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}

@end
