//
//  MyWorkViewController.m
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "MyWorkViewController.h"
#import "MyWorkCollectionViewCell.h"
#import "StickFigureImgObj.h"

#define MAX_SERVICE_PAGE 20

@interface MyWorkViewController ()
{
    BOOL isViewDidAppear;
    BOOL isViewWillAppear;
}
@property(nonatomic, assign) BOOL isEdit;
@property(nonatomic, strong) NSMutableArray * showDataAry;
@property(nonatomic, strong) UIButton *canelButton;
@property (nonatomic, assign) long recordPage;

@end

@implementation MyWorkViewController

-(NSMutableArray *)showDataAry
{
    if(!_showDataAry)
    {
        _showDataAry = [[NSMutableArray alloc]init];
    }
    return _showDataAry;
}

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MySB" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"MyWorkViewController"];
    if (self) {
        // Custom initialization
        self.title = @"作者作品";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isViewDidAppear = NO;
    isViewWillAppear = NO;
    _isEdit = NO;
    [self addHeader];
    [self addFooter];
    _recordPage = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isViewWillAppear == NO)
    {
        if([_bUser.objectId isEqualToString:[BmobUser currentUser].objectId])
        {
            _canelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _canelButton.backgroundColor = [UIColor clearColor];
            _canelButton.titleLabel.font = [UIFont systemFontOfSize: 16];
            _canelButton.frame = CGRectMake(0, 0, 48, 40);
            [_canelButton setTitle:@"编辑" forState:UIControlStateNormal];
            [_canelButton addTarget:self action:@selector(clickCanelButton) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *canelButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_canelButton];
            self.navigationItem.rightBarButtonItem = canelButtonItem;
        }
        else
        {
//            _canelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            _canelButton.backgroundColor = [UIColor clearColor];
//            _canelButton.titleLabel.font = [UIFont systemFontOfSize: 16];
//            _canelButton.frame = CGRectMake(0, 0, 48, 40);
//            [_canelButton setTitle:@"关注作者" forState:UIControlStateNormal];
//            [_canelButton addTarget:self action:@selector(clickFollowButton) forControlEvents:UIControlEventTouchUpInside];
//            UIBarButtonItem *canelButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_canelButton];
//            self.navigationItem.rightBarButtonItem = canelButtonItem;
        }
        isViewWillAppear = YES;
    }
}

-(void)clickCanelButton
{
    _isEdit = !_isEdit;
    if(_isEdit)
        [_canelButton setTitle:@"完成" forState:UIControlStateNormal];
    else
        [_canelButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_myCollectionView reloadData];
}

-(void)clickFollowButton
{
    //关注
}

- (void)addHeader
{
    __weak typeof(self) vc = self;
    self.myCollectionView.mj_header = [DiyMjRefresh headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [vc getMyWork:1];
    }];
}

- (void)addFooter
{
    __weak typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    self.myCollectionView.mj_footer = [DiyMjRefreshFooter footerWithRefreshingBlock:^{
        // 进入刷新状态就会回调这个Block
        [vc getMyWork:vc.recordPage];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(isViewDidAppear == NO)
    {
        [self.myCollectionView.mj_header beginRefreshing];
    }
    isViewDidAppear = YES;
}

-(void)getMyWork:(long)page
{
    __weak typeof(self) vc = self;
    BmobQuery   *bquery = [StickFigureImgObj query];
    bquery.limit = MAX_SERVICE_PAGE;
    bquery.skip = MAX_SERVICE_PAGE * (page-1);
    [bquery whereKey:@"userInfo" equalTo:_bUser];
    [bquery orderByDescending:@"likeNum"];
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
            [vc.myCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            [vc.myCollectionView.mj_footer endRefreshing];
        }
        
        [vc.myCollectionView reloadData];
        [vc.myCollectionView.mj_header endRefreshing];
    }];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.showDataAry.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) vc = self;
    static NSString *moreCellIdentifier = @"MyWorkCollectionViewCell";
    StickFigureImgObj * sfObj = [_showDataAry objectAtIndex:indexPath.row];
    MyWorkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:moreCellIdentifier forIndexPath:indexPath];
    __weak typeof(cell) weakCell = cell;
    cell.sfImg.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.sfImg.layer.borderWidth = 1.0f;
    cell.sfImg.layer.cornerRadius = 6.0;
    [sfObj.imageGroup enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx == sfObj.imageGroup.count-1)
            [cell.sfImg sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"groundImg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
    }];
    [cell.likeBtn setImage:[UIImage imageNamed:@"circleGoodCheckImg"] forState:UIControlStateNormal];
    cell.likeNumLab.text = (sfObj.likeNum == nil) ? @"":[NSString stringWithFormat:@"%@",sfObj.likeNum];
    
//    //关联对象表 查询赞过的所有人
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
//    BmobObject *post = [BmobObject objectWithoutDataWithClassName:@"StickFigureImgObj" objectId:sfObj.objectId];
//    [bquery whereObjectKey:@"likes" relatedTo:post];
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
    
    if(_isEdit)
        cell.editBtn.hidden = NO;
    else
        cell.editBtn.hidden = YES;
    cell.clickDelDone = ^{
        [vc deleteImg:indexPath.row];
    };
    return cell;
}

-(void)deleteImg:(long)index
{
    __weak typeof(self) vc = self;
    [ToolsFunction showHttpPromptView:self.view];
    StickFigureImgObj * sfObj = [_showDataAry objectAtIndex:index];
    BmobQuery *bquery = [StickFigureImgObj query];
    [bquery getObjectInBackgroundWithId:sfObj.objectId block:^(BmobObject *object, NSError *error){
        [ToolsFunction hideHttpPromptView:self.view];
        if (error) {
            //进行错误处理
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackground];
                [vc.showDataAry removeObjectAtIndex:index];
                [vc.myCollectionView reloadData];
                //删除素材文件
                [BmobFile filesDeleteBatchWithArray:sfObj.imageGroup resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
                    [ToolsFunction showPromptViewWithString:@"已删除" background:nil timeDuration:1];
                }];
            }
        }
    }];
    
    
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(UISCREEN_BOUNDS_SIZE.width/3, UISCREEN_BOUNDS_SIZE.width/3);
}

//定义UICollectionView 的边距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //查看图片
    StickFigureImgObj * sfObj = [_showDataAry objectAtIndex:indexPath.row];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.configuration.navBarColor = [UIColor appNavigationColor];
    actionSheet.backgroundColor = [UIColor whiteColor];
    actionSheet.sender = self;
    NSMutableArray * tempPhoto = [[NSMutableArray alloc]init];
    [sfObj.imageGroup enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * dic = GetDictForPreviewPhoto(obj, ZLPreviewPhotoTypeURLImage);
        [tempPhoto addObject:dic];
    }];
    [actionSheet previewPhotos:tempPhoto index:0 hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
