//
//  MyWorkCollectionViewCell.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDelDone)(void);
typedef void(^ClickLikeDone)(void);

@interface MyWorkCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sfImg;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) UIButton *likeBtn;
@property (strong, nonatomic) UILabel *likeNumLab;

@property (nonatomic, copy) ClickDelDone clickDelDone;
@property (nonatomic, copy) ClickLikeDone clickLikeDone;

@end
