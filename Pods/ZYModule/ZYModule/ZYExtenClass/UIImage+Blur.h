//
//  UIImage+Blur.h
//  SkyHospital
//
//  Created by ZY on 15/5/27.
//  Copyright (c) 2015年 GrayWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (Blur)

+(UIImage *)screenshot:(UIView*)view;

- (UIImage*)blurredImage:(CGFloat)blurAmount;

@end
