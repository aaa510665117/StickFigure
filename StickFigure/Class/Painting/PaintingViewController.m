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
#import "UpMyStickViewController.h"

@interface PaintingViewController ()
{
    BOOL isViewWillAppear;
}
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *colorsModel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (weak, nonatomic) IBOutlet HBColorBall *ballView;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet HBDrawingBoard *drawView;
@property (nonatomic, strong) UIImageView * upButton;
@property (nonatomic, strong) CALayer * layer;
@property (nonatomic, strong) NSMutableArray * imgAry;

@end

@implementation PaintingViewController

- (NSArray *)colors
{
    if (!_colors) {
        _colors = [NSArray arrayWithObjects:@"#000000",
                   @"#ed4040",
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

-(NSMutableArray *)imgAry
{
    if(!_imgAry){
        _imgAry = [[NSMutableArray alloc]init];
    }
    return _imgAry;
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
    isViewWillAppear = NO;
    // Do any additional setup after loading the view.
    UIButton *canelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    canelButton.backgroundColor = [UIColor clearColor];
    canelButton.titleLabel.font = [UIFont systemFontOfSize: 16];
    canelButton.frame = CGRectMake(0, 0, 48, 40);
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
    __weak typeof(self) vc = self;
    _drawView.clickSaveDone = ^(UIImage * img) {
        [vc addAnimatedWithFrame:img];
    };
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isViewWillAppear == NO)
    {
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        _upButton = [[UIImageView alloc]init];
        _upButton.backgroundColor = [UIColor whiteColor];
        _upButton.frame = CGRectMake(0, 0, 50, 30);
        _upButton.layer.cornerRadius = 6.0;
        _upButton.layer.masksToBounds = YES;
        _upButton.userInteractionEnabled = YES;
        [rightView addSubview:_upButton];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUpButton)];
        [rightView addGestureRecognizer:tapGesture];
        //    [_upButton addTarget:self action:@selector(clickUpButton) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *upButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
        self.navigationItem.rightBarButtonItem = upButtonItem;
    }
    _tipsLab.text = [NSString stringWithFormat:@"第%ld步",_imgAry.count+1];
    isViewWillAppear = YES;
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

-(void)clickUpButton
{
    if(self.imgAry.count == 0)
    {
        [ToolsFunction showPromptViewWithString:@"画完请点击右下角保存~" background:nil timeDuration:1.5];
        return;
    }
    UpMyStickViewController * upMyStick = [[UpMyStickViewController alloc]init];
    upMyStick.imgAry = self.imgAry;
    [self.navigationController pushViewController:upMyStick animated:YES];
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

- (void)addAnimatedWithFrame:(UIImage *)img {
    // 该部分动画 以self.view为参考系进行
    [self.imgAry addObject:img];
    _tipsLab.text = [NSString stringWithFormat:@"第%ld步",_imgAry.count+1];
    UIImageView * temp = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    temp.image = img;
    [_drawView addSubview:temp];
    temp.center = _drawView.center;
    CGPoint fromCenter =  [temp convertPoint:CGPointMake(temp.frame.size.width * 0.5f, temp.frame.size.height * 0.5f) toView:[AppDelegate appDelegate].window];
    CGPoint endCenter = [_upButton convertPoint:CGPointMake(_upButton.frame.size.width * 0.5f, _upButton.frame.size.height * 0.5f) toView:[AppDelegate appDelegate].window];

    _layer = [CALayer layer];
    _layer.bounds = temp.bounds;
    _layer.contents = temp.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspect;
    _layer.borderColor = [UIColor orangeColor].CGColor;
    _layer.borderWidth = 1.0f;
    _layer.cornerRadius = 6.0;
    [[AppDelegate appDelegate].window.layer addSublayer:_layer];

    _layer.position = fromCenter; //a 点
    // 路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_layer.position];
    _layer.position = endCenter; //a 点
    
    [path addQuadCurveToPoint:endCenter controlPoint:CGPointMake(UISCREEN_BOUNDS_SIZE.width/2, fromCenter.y)];
    //关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;

    //往下抛时旋转小动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    
    /**
     *   kCAMediaTimingFunctionLinear   动画从头到尾的速度是相同的
     kCAMediaTimingFunctionEaseIn   动画以低速开始。
     kCAMediaTimingFunctionEaseOut  动画以低速结束。
     kCAMediaTimingFunctionEaseInEaseOut   动画以低速开始和结束。
     kCAMediaTimingFunctionDefault
     */
    
    rotateAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,rotateAnimation];
    groups.duration = 1.2f;
    
    //设置之后做动画的layer不会回到一开始的位置
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    
    //让工具类成为组动画的代理
    groups.delegate = self;
    [temp removeFromSuperview];
    [_layer addAnimation:groups forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_layer animationForKey:@"group"]) {
        UIImage * img = [[UIImage alloc] initWithCGImage:(CGImageRef)_layer.contents];
        [_upButton setImage:img];
        [_layer removeFromSuperlayer];
        _layer = nil;
    }
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

