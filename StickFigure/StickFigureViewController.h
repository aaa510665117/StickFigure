//
//  StickFigureViewController.h
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoseTypeTableViewCell.h"
#import "StickTypeCollectionViewCell.h"
#import "MWPhotoBrowser.h"

#define UISCREEN_BOUNDS_SIZE      [UIScreen mainScreen].bounds.size // 屏幕的物理尺寸

@interface StickFigureViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *choseTypeTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *showImgCollectionView;

@end
