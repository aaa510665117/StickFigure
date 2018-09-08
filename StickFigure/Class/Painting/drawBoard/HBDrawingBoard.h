//
//  HBDrawingBoard.h
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/2.
//  Copyright (c) 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBDrawModel.h"

typedef NS_ENUM(NSInteger, HBDrawingStatus)
{
    HBDrawingStatusBegin,//准备绘制
    HBDrawingStatusMove,//正在绘制
    HBDrawingStatusEnd//结束绘制
};

typedef NS_ENUM(NSInteger, actionOpen) {
    actionOpenAlbum,
    actionOpenCamera
};

typedef void(^ClickSaveDone)(UIImage *);

@interface HBDrawingBoard : UIView<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL ise;
@property (nonatomic, strong) UIColor *lineColor;//画笔颜色
@property (nonatomic, assign) CGFloat lineWidth;//线宽
@property (nonatomic, copy) ClickSaveDone clickSaveDone;

- (BOOL)drawWithPoints:(HBDrawModel *)model;

@end

#pragma mark - HBPath
@interface HBPath : NSObject

@property (nonatomic, strong) UIColor *pathColor;//画笔颜色
@property (nonatomic, assign) CGFloat lineWidth;//线宽
@property (nonatomic, assign) BOOL isEraser;//橡皮擦
@property (nonatomic, copy) NSString *imagePath;//图片路径
@property (nonatomic, strong) UIBezierPath *bezierPath;


+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser;//初始化对象
- (void)pathLineToPoint:(CGPoint)movePoint;//画

@end

@interface HBDrawView : UIView

- (void)setBrush:(HBPath *)path;

@end

