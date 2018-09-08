//
//  StickFigureViewController.m
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "StickFigureViewController.h"
#import "ListCollectionView.h"

@interface StickFigureViewController ()<UIScrollViewDelegate>
{
    BOOL isViewDidAppear;
}
@property(nonatomic, assign) SFType choseType;
@property(nonatomic, strong) NSMutableArray * viewAry;
@property (nonatomic, strong)HMSegmentedControl *mySegment;
@property (nonatomic, strong) UIScrollView * myScrollView;

@end

@implementation StickFigureViewController

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StickFigure" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"StickFigureViewController"];
    if(self)
    {
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"简笔画" image:[[UIImage imageNamed:@"work_noCheckTabBar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"work_checkTabBar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        self.title = @"简笔画";
    }
    return self;
}

-(NSMutableArray *)viewAry
{
    if(!_viewAry)
    {
        _viewAry = [[NSMutableArray alloc]init];
    }
    return _viewAry;
}

-(UIScrollView *)myScrollView
{
    if(!_myScrollView)
    {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 55, CGRectGetWidth(self.view.frame), self.view.frame.size.height-55-StatusBarHeight-NavigationBarHeight)];
        _myScrollView.pagingEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * [StickFigureImgObj getTypeAry].count, self.view.frame.size.height-55-StatusBarHeight-NavigationBarHeight);
        _myScrollView.delegate = self;
        _myScrollView.bounces = NO;
    }
    return _myScrollView;
}

-(HMSegmentedControl *)mySegment
{
    if(!_mySegment)
    {
        __weak typeof(self) weakSelf = self;
        _mySegment = [[HMSegmentedControl alloc] initWithSectionTitles:[StickFigureImgObj getTypeAry]];
        [_mySegment setFrame:CGRectMake(0, 0, UISCREEN_BOUNDS_SIZE.width, 44)];
        _mySegment.selectionIndicatorHeight = 3.0f;
        _mySegment.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor colorWithRed:0.349 green:0.341 blue:0.341 alpha:1.000]};
        _mySegment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:244/255.0 green:88/255.0 blue:85/255.0 alpha:1.0]};
        _mySegment.selectionIndicatorColor = [UIColor colorWithRed:244/255.0 green:88/255.0 blue:85/255.0 alpha:1.0];
        _mySegment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _mySegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _mySegment.verticalDividerEnabled = NO;
        _mySegment.verticalDividerColor = [UIColor colorWithRed:0.788 green:0.792 blue:0.792 alpha:1.000];
        _mySegment.selectedSegmentIndex = 0;
        [_mySegment setIndexChangeBlock:^(NSInteger index) {
            weakSelf.choseType = (SFType)index;
            [weakSelf.myScrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(weakSelf.view.frame) * index, 0, CGRectGetWidth(weakSelf.view.frame), weakSelf.myScrollView.frame.size.height) animated:YES];
            ListCollectionView * listView = [weakSelf.viewAry objectAtIndex:index];
            [listView getData];
        }];
    }
    return _mySegment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isViewDidAppear = NO;
    _choseType = SFTypeAnimal;
    
    [self.view addSubview:self.mySegment];
    [self.view addSubview:self.myScrollView];
    
    __weak typeof(self) weakSelf = self;
    [[StickFigureImgObj getTypeAry] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ListCollectionView * listView = [[ListCollectionView alloc]initWithFrame:CGRectMake((CGRectGetWidth(weakSelf.view.frame))*idx, 0, CGRectGetWidth(weakSelf.view.frame), weakSelf.myScrollView.frame.size.height)];
        listView.sftype = (SFType)idx;
        [self.myScrollView addSubview:listView];
        [weakSelf.viewAry addObject:listView];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(isViewDidAppear == NO){
        isViewDidAppear = YES;
        ListCollectionView * listView = [self.viewAry objectAtIndex:0];
        [listView getData];
    }
}

-(void)getphotoAry
{
    [[ZYHttpAPI sharedUpDownAPI]requestGetOrdinary:@"GetPhotoLink" withParams:nil withSuccess:^(NSDictionary *success) {
        
        __weak typeof(self) vc = self;
        NSMutableArray * dic = [success objectForKey:HTTP_RETURN_RESULT];
        [dic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSDictionary * dic = obj;
//            if(idx == 0)vc.animalAry = [dic objectForKey:@"animal"];
//            if(idx == 1)vc.fruitsAry = [dic objectForKey:@"fruits"];
//            if(idx == 2)vc.vegetablesAry = [dic objectForKey:@"vegetables"];
//            if(idx == 3)vc.cartoonAry = [dic objectForKey:@"cartoon"];
//            if(idx == 4)vc.vehicleAry = [dic objectForKey:@"Vehicle"];
            [vc.showImgCollectionView reloadData];
        }];
        
    } withFailure:^(NSDictionary *failure) {
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    _mySegment.selectedSegmentIndex = page;
    ListCollectionView * listView = [self.viewAry objectAtIndex:page];
    [listView getData];
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
