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
        _stickImg.layer.borderColor = [UIColor appNavigationColor].CGColor;
        _stickImg.layer.cornerRadius = 6.0;
    }
    return _stickImg;
}

-(UILabel *)likeNumLab
{
    if(!_likeNumLab)
    {
        _likeNumLab = [[UILabel alloc]init];
        _likeNumLab.translatesAutoresizingMaskIntoConstraints = NO;
        _likeNumLab.textColor = [UIColor lightGrayColor];
        _likeNumLab.font = [UIFont systemFontOfSize:13];
    }
    return _likeNumLab;
}

-(UIButton *)likeBtn
{
    if(!_likeBtn)
    {
        _likeBtn = [[UIButton alloc]init];
        _likeBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_likeBtn addTarget:self action:@selector(clickLikeBtn) forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setImage:[UIImage imageNamed:@"circleGoodImg"] forState:UIControlStateNormal];
    }
    return _likeBtn;
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
            make.left.equalTo(self.contentView.mas_left).with.offset(5);
            make.right.equalTo(self.contentView.mas_right).with.offset(-5);
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        }];
        
        [self addSubview:self.likeNumLab];
        _likeNumLab.text = @"2";
        [_likeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-12);
        }];
        
        [self addSubview:self.likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.likeNumLab.mas_left).with.offset(3);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-6);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return self;
}

-(void)clickLikeBtn
{
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    [_likeBtn.layer addAnimation:k forKey:@"SHOW"];
    if(_clickLikeDone) _clickLikeDone();
}

@end
