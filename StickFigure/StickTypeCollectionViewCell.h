//
//  StickTypeCollectionViewCell.h
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickLikeDone)(void);

@interface StickTypeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *stickImg;
@property (strong, nonatomic) UIButton *likeBtn;
@property (strong, nonatomic) UILabel *likeNumLab;

@property (nonatomic, copy) ClickLikeDone clickLikeDone;

@end
