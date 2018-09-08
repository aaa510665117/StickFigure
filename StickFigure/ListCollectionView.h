//
//  ListCollectionView.h
//  StickFigure
//
//  Created by 扬张 on 2018/9/8.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StickFigureImgObj.h"

@interface ListCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView * myColletionView;
@property(nonatomic, assign) SFType sftype;

-(void)getData;

@end
