//
//  CALayer+Additions.m
//  SkyHospital
//
//  Created by ZY on 15/4/29.
//  Copyright (c) 2015年 GrayWang. All rights reserved.
//

#import "CALayer+Additions.h"

@implementation CALayer(Additions)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
