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
    NSArray * cartoonImgAry;
    NSArray * vehicleImgAry;
}
@property(nonatomic, assign) long choseTypeIndex;
@property (nonatomic, strong)HMSegmentedControl *mySegment;
@property (nonatomic, strong) NSMutableArray * photos;      //用于查看大图

@end

@implementation StickFigureViewController

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StickFigure" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"StickFigureViewController"];
    if(self)
    {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扬哥带你简笔画";
//    choseTypeAry = @[@"动物",@"水果",@"蔬菜",@"植物",@"交通工具"];
    choseTypeAry = @[@"动物",@"水果",@"蔬菜",@"动漫",@"交通工具"];
    animalImgAry = @[@"bee",@"cat",@"catGroup",@"crab",@"dog",@"fish",@"mouse",@"potato",@"bear",@"snail",@"swallow",@"owl",@"fish2",@"rhinoceros",@"butterfly",@"hedgehog",@"pig",@"Elephant",@"giraffe",@"chicken",@"cow"];
    fruitsImgAry = @[@"apple",@"watermelon",@"banana",@"strawberry",@"grape",@"pineapple",@"durian",@"mango",@"carambola",@"peach",@"lemon",@"persimmon",@"tangerine",@"cherry",@"pear"];
    vegetablesImgAry = @[@"cabbage",@"cauliflower",@"cucumber",@"eggplant",@"greenbean",@"greencapsicum",@"lotus",@"mushroom",@"peanut",@"potato",@"pumpkin",@"radish",@"tomato"];
    cartoonImgAry = @[@"dongman1",@"dongman2",@"dongman3",@"dongman4",@"dongman5",@"dongman6",@"dongman7",@"dongman8",@"dongman9",@"dongman10",@"dongman11",@"dongman12",@"dongman13",@"dongman14",@"dongman15"];
    vehicleImgAry = @[@"Vehicle1",@"Vehicle2",@"Vehicle3",@"Vehicle4",@"Vehicle5",@"Vehicle6",@"Vehicle7",@"Vehicle8",@"Vehicle9",@"Vehicle10",@"Vehicle11",@"Vehicle12",@"Vehicle13",@"Vehicle14",@"Vehicle15"];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(draw)];
//    [UINavigationBar appearance].tintColor = [UIColor darkGrayColor];

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
    }];
    [self.view addSubview:_mySegment];
    
//    [[SDImageCache sharedImageCache] clearDisk];  //清除缓存
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
        case 3:
        {
            return cartoonImgAry.count;
        }
            break;
        case 4:
        {
            return vehicleImgAry.count;
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
        case 3:
        {
            [cell.stickImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Cartoon/",[cartoonImgAry objectAtIndex:indexPath.row],[cartoonImgAry objectAtIndex:indexPath.row]]]];
        }
            break;
        case 4:
        {
            [cell.stickImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Vehicle/",[vehicleImgAry objectAtIndex:indexPath.row],[vehicleImgAry objectAtIndex:indexPath.row]]]];
        }
            break;
        default:
            [cell.stickImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Animal/",[animalImgAry objectAtIndex:indexPath.row],[animalImgAry objectAtIndex:indexPath.row]]]];
            break;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _photos = [NSMutableArray array];
    switch (_choseTypeIndex) {
        case 0:
        {
            [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Animal/",[animalImgAry objectAtIndex:indexPath.row],[animalImgAry objectAtIndex:indexPath.row]]]]];
        }
            break;
        case 1:
        {
            [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Fruits/",[fruitsImgAry objectAtIndex:indexPath.row],[fruitsImgAry objectAtIndex:indexPath.row]]]]];
        }
            break;
        case 2:
        {
            [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Vegetables/",[vegetablesImgAry objectAtIndex:indexPath.row],[vegetablesImgAry objectAtIndex:indexPath.row]]]]];
        }
            break;
        case 3:
        {
            [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Cartoon/",[cartoonImgAry objectAtIndex:indexPath.row],[cartoonImgAry objectAtIndex:indexPath.row]]]]];
        }
            break;
        case 4:
        {
            [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Vehicle/",[vehicleImgAry objectAtIndex:indexPath.row],[vehicleImgAry objectAtIndex:indexPath.row]]]]];
        }
            break;
        default:
            
            [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@.jpg",Service_Local,@"Animal/",[animalImgAry objectAtIndex:indexPath.row],[animalImgAry objectAtIndex:indexPath.row]]]]];
            break;
    }
    
        
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:indexPath.row];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count) {
        return [_photos objectAtIndex:index];
    }
    return nil;
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
