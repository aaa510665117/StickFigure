//
//  StickTypeCollectionViewCell.m
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "StickTypeCollectionViewCell.h"

@implementation StickTypeCollectionViewCell

-(UIImageView *)stickImg
{
    if(!_stickImg)
    {
        _stickImg = [[UIImageView alloc]init];
        _stickImg.backgroundColor = [UIColor whiteColor];
        _stickImg.translatesAutoresizingMaskIntoConstraints = NO;
        _stickImg.layer.borderWidth = 2.0f;
        _stickImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _stickImg;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.stickImg];
        [_stickImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        }];
    }
    return self;
}

@end
