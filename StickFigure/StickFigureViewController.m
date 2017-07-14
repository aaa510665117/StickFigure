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
}
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
    self.title = @"简笔画";
    choseTypeAry = @[@"动物",@"水果",@"蔬菜",@"昆虫",@"植物",@"交通工具"];
    animalImgAry = @[@"bee",@"cat",@"catGroup",@"crab",@"dog",@"fish",@"mouse",@"potato",];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"绘画" style:UIBarButtonItemStylePlain target:self action:@selector(draw)];
}

-(void)draw
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return choseTypeAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idetifier = @"ChoseTypeTableViewCell";
    ChoseTypeTableViewCell *cell = (ChoseTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idetifier];
    cell.cellLabel.text = [choseTypeAry objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma collectionView--Delegate
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UISCREEN_BOUNDS_SIZE.width-110)/2 , (UISCREEN_BOUNDS_SIZE.width-110)/2);
}

//定义UICollectionView 的边距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return animalImgAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StickTypeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StickTypeCollectionViewCell" forIndexPath:indexPath];
    cell.stickImg.image = [UIImage imageNamed:[animalImgAry objectAtIndex:indexPath.row]];
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
