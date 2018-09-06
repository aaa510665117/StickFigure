//
//  HBDrawingBoard.m
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/2.
//  Copyright (c) 2015年 HB. All rights reserved.
//

#import "HBDrawingBoard.h"
//#import "UIView+WHB.h"
#import "HBDrawPoint.h"

@interface HBDrawingBoard()
{
    UIColor *_lastColor;
    CGFloat _lastLineWidth;
    
//    CGFloat _lineWidth;
//    UIColor *_lineColor;
}

@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) NSMutableArray *tempPoints;

@property (nonatomic, strong) NSMutableArray *tempPath;

@property (nonatomic, strong) UIImageView *drawImage;

@property (nonatomic, strong) HBDrawView *drawView;

@end

#define ThumbnailPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"HBThumbnail"]

@implementation HBDrawingBoard

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, UISCREEN_BOUNDS_SIZE.width, UISCREEN_BOUNDS_SIZE.height-64-60-65);
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.drawImage];

    [self.drawImage addSubview:self.drawView];
    
    _lineColor = [UIColor orangeColor];
    _lineWidth = 10.0f;
}

#pragma mark - Public_Methd
- (BOOL)drawWithPoints:(HBDrawModel *)model{

    self.userInteractionEnabled = NO;
    
    //比值
    CGFloat xPix = ([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale);
    CGFloat yPix = ([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale);
    CGFloat xp = model.width.floatValue / xPix;
    CGFloat yp = model.height.floatValue / yPix;
    
    HBDrawPoint *point = [model.pointList firstObject];
    
    HBPath *path = [HBPath pathToPoint:CGPointMake(point.x.floatValue * xp , point.y.floatValue * yp) pathWidth:model.paintSize.floatValue isEraser:model.isEraser.boolValue];
    path.pathColor = [UIColor colorWithHexString:model.paintColor alpha:1.0];
    
    [self.paths addObject:path];
    
    NSMutableArray *marray = [model.pointList mutableCopy];
    
    [marray removeObjectAtIndex:0];

    [marray enumerateObjectsUsingBlock:^(HBDrawPoint *point, NSUInteger idx, BOOL *stop) {
        
        [path pathLineToPoint:CGPointMake(point.x.floatValue * xp , point.y.floatValue * yp)];
        
        [self.drawView setBrush:path];
        
    }];
    
    self.userInteractionEnabled = YES;
    return YES;
}

#pragma mark - CustomMethd
- (CGPoint)getTouchSet:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
     return [touch locationInView:self];
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self getTouchSet:touches];

    HBPath *path = [HBPath pathToPoint:point pathWidth:_lineWidth isEraser:self.ise];

    path.pathColor = _lineColor;
    
    path.imagePath = [NSString stringWithFormat:@"%@.png",[self getTimeString]];
    
    [self.paths addObject:path];

    [self.tempPoints addObject:[HBDrawPoint drawPoint:point]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self getTouchSet:touches];

    HBPath *path = [self.paths lastObject];
    
    [path pathLineToPoint:point];
    
    if (self.ise) {
        [self setEraseBrush:path];
    }else{
        [self.drawView setBrush:path];
    }
    
    [self.tempPoints addObject:[HBDrawPoint drawPoint:point]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];

    UIImage *image = [self screenshot:self.drawImage];

    self.drawImage.image = image;

    [self.drawView setBrush:nil];

    //清空
    [self.tempPoints removeAllObjects];
}

- (void)setEraseBrush:(HBPath *)path{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);
    
    [self.drawImage.image drawInRect:self.bounds];
    
    [[UIColor clearColor] set];
    
    path.bezierPath.lineWidth = _lineWidth;
    
    [path.bezierPath strokeWithBlendMode:kCGBlendModeClear alpha:1.0];
    
    [path.bezierPath stroke];
    
    self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
}
- (UIImage *)screenshot:(UIView *)shotView{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [shotView.layer renderInContext:context];
    
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return getImage;
}
- (NSString *)getTimeString{
    
    NSDateFormatter  *dateformatter = nil;
    if (!dateformatter) {
        dateformatter = [[NSDateFormatter alloc] init];
    }
    
    [dateformatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    
    return [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}

#pragma mark - Lazying
- (NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}
- (NSMutableArray *)tempPoints{
    if (!_tempPoints) {
        _tempPoints = [NSMutableArray array];
    }
    return _tempPoints;
}
- (NSMutableArray *)tempPath{
    if (!_tempPath) {
        _tempPath = [NSMutableArray array];
    }
    return _tempPath;
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (self.ise) {
        
        _lastColor = lineColor;
        
        return;
    }
    
    _lineColor = lineColor;
}
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    _lastLineWidth = lineWidth;
}

- (UIImageView *)drawImage
{
    if (!_drawImage) {
        _drawImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _drawImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _drawImage;
}

- (HBDrawView *)drawView{
    if (!_drawView) {
        _drawView = [HBDrawView new];
        _drawView.backgroundColor = [UIColor clearColor];
        _drawView.frame = self.bounds;
    }
    return _drawView;
}

- (IBAction)clickEraser:(id)sender {
    //点击橡皮擦
    _ise = YES;
    _lineColor = [UIColor whiteColor];
}

- (IBAction)clickClean:(id)sender {
    //点击清空
    self.drawImage.image = [ToolsFunction imageWithColor:[UIColor whiteColor] size:CGSizeMake(UISCREEN_BOUNDS_SIZE.width, UISCREEN_BOUNDS_SIZE.height)];
    [self.drawView setBrush:nil];
}

- (IBAction)clickSave:(id)sender {
    //点击保存
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SendColorAndWidthNotification object:nil];
}
@end

#pragma mark - HBPath
@interface HBPath()

@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGFloat pathWidth;

@end

@implementation HBPath

+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser
{
    HBPath *path = [[HBPath alloc] init];
    path.beginPoint = beginPoint;
    path.pathWidth = pathWidth;
    path.isEraser = isEraser;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = pathWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath moveToPoint:beginPoint];
    path.bezierPath = bezierPath;
    
    return path;
}
//HBDrawingShapeCurve = 0,//曲线
//HBDrawingShapeLine,//直线
//HBDrawingShapeEllipse,//椭圆
//HBDrawingShapeRect,//矩形
- (void)pathLineToPoint:(CGPoint)movePoint
{
    [self.bezierPath addLineToPoint:movePoint];
}

- (CGRect)getRectWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGPoint orignal = startPoint;
    if (startPoint.x > endPoint.x) {
        orignal = endPoint;
    }
    CGFloat width = fabs(startPoint.x - endPoint.x);
    CGFloat height = fabs(startPoint.y - endPoint.y);
    return CGRectMake(orignal.x , orignal.y , width, height);
}

@end

@implementation HBDrawView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)setBrush:(HBPath *)path
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    
    shapeLayer.strokeColor = path.pathColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = path.bezierPath.lineWidth;
    ((CAShapeLayer *)self.layer).path = path.bezierPath.CGPath;
}


@end
