//
//  ListCollectionView.m
//  StickFigure
//
//  Created by 扬张 on 2018/9/8.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "ListCollectionView.h"
#import "MyWorkViewController.h"

#define MAX_SERVICE_PAGE 20

@interface ListCollectionView()

@property(nonatomic, strong) NSMutableArray * showDataAry;
@property (nonatomic, assign) long recordPage;

@end

@implementation ListCollectionView

-(UICollectionView *)myColletionView
{
    if(!_myColletionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _myColletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _myColletionView.backgroundColor = [UIColor whiteColor];
        _myColletionView.delegate = self;
        _myColletionView.dataSource = self;
        [_myColletionView registerClass:[StickTypeCollectionViewCell class] forCellWithReuseIdentifier:@"StickTypeCollectionViewCell"];
    }
    return _myColletionView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.myColletionView];
        [self addHeader];
        [self addFooter];
        _recordPage = 1;
    }
    return self;
}

- (void)addHeader
{
    __weak typeof(self) vc = self;
    self.myColletionView.mj_header = [DiyMjRefresh headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [vc getSFImg:1];
    }];
}

- (void)addFooter
{
    __weak typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    self.myColletionView.mj_footer = [DiyMjRefreshFooter footerWithRefreshingBlock:^{
        // 进入刷新状态就会回调这个Block
        [vc getSFImg:vc.recordPage];
    }];
}

-(void)getData
{
    if(_showDataAry.count == 0)
    {
        [_myColletionView.mj_header beginRefreshing];
    }
}

-(void)getSFImg:(long)page
{
    __weak typeof(self) vc = self;
    BmobQuery   *bquery = [StickFigureImgObj query];
    bquery.limit = MAX_SERVICE_PAGE;
    bquery.skip = MAX_SERVICE_PAGE * (page-1);
    [bquery whereKey:@"type" equalTo:[NSString stringWithFormat:@"%d",_sftype]];
//    [bquery orderByDescending:@"updatedAt"];
    [bquery orderByDescending:@"likeNum"];
    [bquery includeKey:@"userInfo"];

    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray * temp = [[NSMutableArray alloc]init];
        for (BmobObject *obj in array) {
            StickFigureImgObj *t = [[StickFigureImgObj alloc] initFromBmobObject:obj];
            [temp addObject:t];
        }
        //数据处理结果加载
        if (page == 1)
        {
            if (temp.count) vc.recordPage = 2;
            vc.showDataAry = [NSMutableArray arrayWithArray:temp];
        }
        else
        {
            if (temp.count) vc.recordPage++;
            [vc.showDataAry addObjectsFromArray:temp];
        }
        
        //刷新控件判断加载
        if(array.count < MAX_SERVICE_PAGE)
        {
            [vc.myColletionView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            [vc.myColletionView.mj_footer endRefreshing];
        }
        
        [vc.myColletionView reloadData];
        [vc.myColletionView.mj_header endRefreshing];
    }];
}

#pragma collectionView--Delegate
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UISCREEN_BOUNDS_SIZE.width-20)/3 , (UISCREEN_BOUNDS_SIZE.width)/3);
}

//定义UICollectionView 的边距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

//定义UICollectionView 每行内部cell item的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//每行的行距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _showDataAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StickTypeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StickTypeCollectionViewCell" forIndexPath:indexPath];
    __weak typeof(cell) weakCell = cell;
    StickFigureImgObj * sfObj = [_showDataAry objectAtIndex:indexPath.row];
    [sfObj.imageGroup enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx == sfObj.imageGroup.count-1)
            [cell.stickImg sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"groundImg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
    }];
    [cell.likeBtn setImage:[UIImage imageNamed:@"circleGoodCheckImg"] forState:UIControlStateNormal];
    cell.likeNumLab.text = (sfObj.likeNum == nil) ? @"":[NSString stringWithFormat:@"%@",sfObj.likeNum];
    
    UserProfile *user = [[UserProfile alloc] initFromBmobObject:sfObj.userInfo];
    [cell.userImg sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:user.userImage] placeholderImage:[UIImage imageNamed:@"noSexDoc"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    cell.clickUserDone = ^{
        //点击用户头像
        MyWorkViewController * myWork = [[MyWorkViewController alloc]init];
        myWork.bUser = sfObj.userInfo;
        myWork.hidesBottomBarWhenPushed = YES;
        [[ToolsFunction getCurrentRootViewController].navigationController pushViewController:myWork animated:YES];
    };
    
    //关联对象表 查询赞过的所有人
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
    BmobObject *post = [BmobObject objectWithoutDataWithClassName:@"StickFigureImgObj" objectId:sfObj.objectId];
    [bquery whereObjectKey:@"likes" relatedTo:post];
    cell.clickLikeDone = ^{
        //修改赞的个数字段
        StickFigureImgObj *stickFigureObj = [[StickFigureImgObj alloc] init];
        stickFigureObj = sfObj;
        if(sfObj.likeNum == nil || [sfObj.likeNum integerValue] == 0){
            stickFigureObj.likeNum = [NSNumber numberWithInteger:1];
        }else{
            NSUInteger num = [sfObj.likeNum intValue]+1;
            stickFigureObj.likeNum = [NSNumber numberWithInteger:num];
        }
        [stickFigureObj sub_updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful){
                weakCell.likeNumLab.text = [NSString stringWithFormat:@"%@",stickFigureObj.likeNum];
            }
        }];
    };
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //查看图片
    StickFigureImgObj * sfObj = [_showDataAry objectAtIndex:indexPath.row];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.configuration.navBarColor = [UIColor appNavigationColor];
    actionSheet.backgroundColor = [UIColor whiteColor];
    actionSheet.sender = [ToolsFunction getCurrentRootViewController];
    NSMutableArray * tempPhoto = [[NSMutableArray alloc]init];
    [sfObj.imageGroup enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * dic = GetDictForPreviewPhoto(obj, ZLPreviewPhotoTypeURLImage);
        [tempPhoto addObject:dic];
    }];
    [actionSheet previewPhotos:tempPhoto index:0 hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
