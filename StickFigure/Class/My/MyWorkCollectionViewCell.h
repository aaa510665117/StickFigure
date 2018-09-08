//
//  MyWorkCollectionViewCell.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDelDone)(void);

@interface MyWorkCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sfImg;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (nonatomic, copy) ClickDelDone clickDelDone;

@end
