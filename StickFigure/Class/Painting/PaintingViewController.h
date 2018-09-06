//
//  PaintingViewController.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/6.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintingViewController : RootViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

//画笔展示的球
@interface HBColorBall : UIView
@property (nonatomic, strong) UIColor *ballColor;

@property (nonatomic, assign) CGFloat ballSize;

@property (nonatomic, assign) CGFloat lineWidth;
@end
