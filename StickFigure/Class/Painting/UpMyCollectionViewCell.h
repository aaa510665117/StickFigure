//
//  UpMyCollectionViewCell.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDelDone)(void);

@interface UpMyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (nonatomic, copy) ClickDelDone clickDelDone;

@end
