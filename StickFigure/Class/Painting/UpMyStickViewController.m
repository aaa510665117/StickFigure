//
//  UpMyStickViewController.m
//  StickFigure
//
//  Created by 扬张 on 2018/9/7.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "UpMyStickViewController.h"
#import "UpMyCollectionViewCell.h"
#import "StickFigureImgObj.h"
#import "DropDownMenuList.h"

@interface UpMyStickViewController ()

@property (weak, nonatomic) IBOutlet UIView *choseTypeView;
@property (weak, nonatomic) IBOutlet UITextField *choseTypeTextField;
@property (nonatomic, strong) DropDownMenuList * downDropMenu;
@property (nonatomic, strong) NSString * choseTp;

@end

@implementation UpMyStickViewController

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PaintingSB" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"UpMyStickViewController"];
    if(self)
    {
        self.title = @"我的随笔";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.backgroundColor = [UIColor clearColor];
    saveButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    saveButton.frame = CGRectMake(0, 0, 48, 40);
    [saveButton setTitle:@"上传" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    _choseTypeView.userInteractionEnabled = YES;
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseType)];
    [_choseTypeView addGestureRecognizer:gesture];
    _choseTp = @"-1";
}

-(void)choseType
{
    __weak typeof(self)vc = self;
    _downDropMenu = [[DropDownMenuList alloc] init];
    _downDropMenu.isCanMatchStr = YES;
    [_downDropMenu showDropDownMenu:_choseTypeView.frame arrayOfTitle:[StickFigureImgObj getTypeAry]];
    _downDropMenu.clickIndex = ^(long cindex) {
        vc.choseTypeTextField.text = [[StickFigureImgObj getTypeAry] objectAtIndex:cindex];
        vc.choseTp = [NSString stringWithFormat:@"%ld",cindex];
    };
    //添加到主视图上
    [self.view addSubview:_downDropMenu];
}

-(void)clickSaveButton
{
    //上传
    if([_choseTp isEqualToString:@"-1"])
    {
        [ToolsFunction showPromptViewWithString:@"请选择简笔画类型" background:nil timeDuration:1];
        return;
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"确定进行上传吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self uploadImg];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)uploadImg
{
    if(_imgAry.count == 0){
        [ToolsFunction showPromptViewWithString:@"请先画几部吧" background:nil timeDuration:1];
        return;
    }
    
    __weak typeof(self)vc = self;
    NSMutableArray * temp = [[NSMutableArray alloc]init];
    [_imgAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary * imgDic = [[NSMutableDictionary alloc]init];
        [imgDic setValue:[NSString stringWithFormat:@"%ld.png",idx] forKey:@"filename"];
        NSData *data = UIImagePNGRepresentation(obj);
        [imgDic setValue:data forKey:@"data"];
        [temp addObject:imgDic];
    }];
    [ToolsFunction showHttpPromptView:nil];
    [BmobFile filesUploadBatchWithDataArray:temp
                              progressBlock:^(int index, float progress) {
                                  //index 上传数组的下标，progress当前文件的进度
                                  NSLog(@"index %d progress %f",index,progress);
                              } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
                                  [ToolsFunction hideHttpPromptView:nil];
                                  //array 文件数组，isSuccessful 成功或者失败,error 错误信息
                                  //更新图片表
                                  NSMutableArray * urlAry = [[NSMutableArray alloc]init];
                                  [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                      BmobFile *file = obj;
                                      [urlAry addObject:file.url];
                                  }];
                                  StickFigureImgObj *stickFigureObj = [[StickFigureImgObj alloc] init];
                                  stickFigureObj.userInfo = [BmobUser currentUser];
                                  stickFigureObj.type = vc.choseTp;
                                  stickFigureObj.imageGroup = urlAry;
                                  [stickFigureObj sub_saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                      if(isSuccessful){
                                          [ToolsFunction showPromptViewWithString:@"上传成功" background:nil timeDuration:1];
                                          [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                      }
                                  }];
                              }];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imgAry.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *moreCellIdentifier = @"UpMyCollectionViewCell";
    __weak typeof(self) vc = self;
    UpMyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:moreCellIdentifier forIndexPath:indexPath];
    cell.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.imageView.layer.borderWidth = 1.0f;
    cell.imageView.layer.cornerRadius = 6.0;
    cell.imageView.image = [_imgAry objectAtIndex:indexPath.row];
    cell.tipsLab.text = [NSString stringWithFormat:@"第%ld步",indexPath.row+1];
    cell.clickDelDone = ^{
        [vc.imgAry removeObjectAtIndex:indexPath.row];
        [vc.myCollectionView reloadData];
    };
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(UISCREEN_BOUNDS_SIZE.width/2, UISCREEN_BOUNDS_SIZE.width/2);
}

//定义UICollectionView 的边距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
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
