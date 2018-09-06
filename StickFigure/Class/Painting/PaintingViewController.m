//
//  PaintingViewController.m
//  StickFigure
//
//  Created by 扬张 on 2018/9/6.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "PaintingViewController.h"
#import "ColorBoxModel.h"
#import "HBDrawingBoard.h"

@interface PaintingViewController ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *colorsModel;
@property (weak, nonatomic) IBOutlet HBColorBall *ballView;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet HBDrawingBoard *drawView;

@end

@implementation PaintingViewController

- (NSArray *)colors
{
    if (!_colors) {
        _colors = [NSArray arrayWithObjects:@"#ed4040",
                   @"#f5973c",
                   @"#efe82e",
                   @"#7ce331",
                   @"#48dcde",
                   @"#2877e3",
                   @"#9b33e4",
                   nil];
    }
    return _colors;
}

-(NSArray *)colorsModel
{
    if(!_colorsModel){
        _colorsModel = [[NSArray alloc]init];
        NSMutableArray * temp = [[NSMutableArray alloc]init];
        [self.colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ColorBoxModel * color = [[ColorBoxModel alloc]init];
            if(idx == 0){
                color.isSelect = YES;
            }else{
                color.isSelect = NO;
            }
            color.color = obj;
            [temp addObject:color];
        }];
        _colorsModel = temp;
    }
    return _colorsModel;
}

-(instancetype)init{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PaintingSB" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"PaintingViewController"];
    if(self)
    {
        self.title = @"画简笔";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *canelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    canelButton.backgroundColor = [UIColor clearColor];
    canelButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    canelButton.frame = CGRectMake(0, 0, 48, 22);
    [canelButton setTitle:@"取消" forState:UIControlStateNormal];
    [canelButton addTarget:self action:@selector(clickCanelButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *canelButtonItem = [[UIBarButtonItem alloc]initWithCustomView:canelButton];
    self.navigationItem.leftBarButtonItem = canelButtonItem;
    ColorBoxModel * colorObj = [self.colorsModel objectAtIndex:0];
    _ballView.ballColor = [UIColor colorWithHexString:colorObj.color alpha:1.0];

    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCellID"];
    
    self.ballView.ballSize = 0.3;
    _sliderView.value = 0.3;
    [_drawView setLineWidth:0.3*10];
    [_drawView setLineColor:[UIColor colorWithHexString:colorObj.color alpha:1.0]];
}

- (IBAction)sliderView:(UISlider *)sender {
    
    self.ballView.ballSize = sender.value;
    [_drawView setLineWidth:sender.value*10];
}

-(void)clickCanelButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.colorsModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCellID" forIndexPath:indexPath];
    ColorBoxModel * colorObj = [self.colorsModel objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor colorWithHexString:colorObj.color alpha:1.0];
    cell.layer.cornerRadius = 3;
    if (colorObj.isSelect) {
        cell.layer.borderWidth = 3;
        cell.layer.borderColor = [UIColor purpleColor].CGColor;
    }else{
        cell.layer.borderWidth = 0;
        
    }
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.colorsModel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ColorBoxModel * colorObj = [self.colorsModel objectAtIndex:idx];
        colorObj.isSelect = NO;
    }];
    
    ColorBoxModel * colorObj = [self.colorsModel objectAtIndex:indexPath.row];
    colorObj.isSelect = YES;
    _ballView.ballColor = [UIColor colorWithHexString:colorObj.color alpha:1.0];
    [_drawView setLineColor:[UIColor colorWithHexString:colorObj.color alpha:1.0]];
    [self.myCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@interface HBColorBall()
@property (nonatomic, strong) CAShapeLayer *shape;
@end

@implementation HBColorBall

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.layer addSublayer:self.shape];
    
}
/*
 1 3 5 7
 */

- (void)setBallColor:(UIColor *)ballColor
{
    _ballColor = ballColor;
    
    self.shape.fillColor = self.ballColor.CGColor;
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:SendColorAndWidthNotification object:nil];
}
- (void)setBallSize:(CGFloat)ballSize
{
    _ballSize = ballSize;
    
    //缩放
    CGFloat vaule = 0.3 * (1 - ballSize) + ballSize;
    self.transform = CGAffineTransformMakeScale(vaule, vaule);
    
    NSLog(@"画笔宽度:%.f",self.frame.size.width / 2.0);
    
    self.lineWidth = self.frame.size.width / 2.0;
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:SendColorAndWidthNotification object:nil];
}
- (CAShapeLayer *)shape
{
    if (!_shape) {
        _shape = [[CAShapeLayer alloc] init];
        _shape.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    }
    return _shape;
}
@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

