//
//  CALayer+Additions.h
//  SkyHospital
//
//  Created by ZY on 15/4/29.
//  Copyright (c) 2015年 GrayWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CALayer(Additions)

//运行时规则添加边框
- (void)setBorderColorFromUIColor:(UIColor *)color;

@end
