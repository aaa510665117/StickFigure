//
//  MyWorkCollectionViewCell.m
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "MyWorkCollectionViewCell.h"

@implementation MyWorkCollectionViewCell

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
    
    [self addSubview:self.likeNumLab];
    _likeNumLab.text = @"2";
    [_likeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-23);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-12);
    }];
    
    [self addSubview:self.likeBtn];
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeNumLab.mas_left).with.offset(3);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-6);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
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

- (IBAction)clickEditBtn:(id)sender {
    if(_clickDelDone) _clickDelDone();
}

@end
