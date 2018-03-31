//
//  StickFigureViewController.m
//  StickFigure
//
//  Created by ZY on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "StickFigureViewController.h"

@interface StickFigureViewController ()
{
    NSArray * choseTypeAry;
    NSArray * animalImgAry;
    NSArray * fruitsImgAry;
    NSArray * vegetablesImgAry;
}
@property(nonatomic, assign) long choseTypeIndex;
@property (nonatomic, strong)HMSegmentedControl *mySegment;

@end

@implementation StickFigureViewController

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StickFigure" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"StickFigureViewController"];
    if(self)
    {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扬哥教你简笔画";
//    choseTypeAry = @[@"动物",@"水果",@"蔬菜",@"植物",@"交通工具"];
    choseTypeAry = @[@"动物",@"水果",@"蔬菜",@"动漫",@"交通工具"];
    animalImgAry = @[@"bee",@"cat",@"catGroup",@"crab",@"dog",@"fish",@"mouse",@"potato",@"bear",@"snail",@"swallow",@"owl",@"fish2",@"rhinoceros",@"butterfly",@"hedgehog",@"pig",@"Elephant",@"giraffe",@"chicken",@"cow"];
    fruitsImgAry = @[@"apple",@"watermelon",@"banana",@"strawberry",@"grape",@"pineapple",@"durian",@"mango",@"carambola",@"peach",@"lemon",@"persimmon",@"tangerine",@"cherry",@"pear"];
    vegetablesImgAry = @[@"cabbage",@"cauliflower",@"cucumber",@"eggplant",@"greenbean",@"greencapsicum",@"lotus",@"mushroom",@"peanut",@"potato",@"pumpkin",@"radish",@"tomato"];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(draw)];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    _choseTypeIndex = 0;
    
    __weak typeof(self) weakSelf = self;
    _mySegment = [[HMSegmentedControl alloc] initWithSectionTitles:choseTypeAry];
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
        weakSelf.choseTypeIndex = index;
        [weakSelf.showImgCollectionView reloadData];
//        if(weakSelf.changIndex) weakSelf.changIndex(index);
    }];
    [self.view addSubview:_mySegment];
    
    [[SDImageCache sharedImageCache] clearDisk];  //清除缓存
}

-(void)draw
{
    
}

#pragma collectionView--Delegate
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UISCREEN_BOUNDS_SIZE.width-40)/3 , (UISCREEN_BOUNDS_SIZE.width-40)/3);
}

//定义UICollectionView 的边距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (_choseTypeIndex) {
        case 0:
        {
            return animalImgAry.count;
        }
            break;
        case 1:
        {
            return fruitsImgAry.count;
        }
            break;
        case 2:
        {
            return vegetablesImgAry.count;
        }
            break;
        default:
            break;
    }
    return animalImgAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StickTypeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StickTypeCollectionViewCell" forIndexPath:indexPath];
    
    switch (_choseTypeIndex) {
        case 0:
        {
            [cell.stickImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Animal/",[animalImgAry objectAtIndex:indexPath.row],[animalImgAry objectAtIndex:indexPath.row]]]];

        }
            break;
        case 1:
        {
            [cell.stickImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Fruits/",[fruitsImgAry objectAtIndex:indexPath.row],[fruitsImgAry objectAtIndex:indexPath.row]]]];

        }
            break;
        case 2:
        {
            [cell.stickImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Vegetables/",[vegetablesImgAry objectAtIndex:indexPath.row],[vegetablesImgAry objectAtIndex:indexPath.row]]]];
        }
            break;
        default:
            [cell.stickImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Animal/",[animalImgAry objectAtIndex:indexPath.row],[animalImgAry objectAtIndex:indexPath.row]]]];

            break;
    }
    
    return cell;
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
