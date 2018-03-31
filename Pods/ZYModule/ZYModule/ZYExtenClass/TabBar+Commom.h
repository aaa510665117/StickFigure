//
//  TabBar+Commom.h
//  SkyEmergency
//
//  Created by ZY on 15/10/16.
//  Copyright © 2015年 ZY. All rights reserved.
//  TabBar扩展

#import <Foundation/Foundation.h>

#define TabBarNum 5                 //tabBar数量

@interface UITabBar (Commom)

/**
 *  显示选择后的效果
 *
 *  @param index 第几个tabbar
 */
-(void)showSelectImage:(long)index;

/**
 *  显示小红点
 *
 *  @param index
 */
- (void)showDotMarkIndex:(int)index;

/**
 *  隐藏小红点
 *
 *  @param index
 */
- (void)hideDotMarkIndex:(int)index; 

/**
 *  显示动画
 *
 *  @param index
 */
- (void)animationWithIndex:(NSInteger)index;

@end
