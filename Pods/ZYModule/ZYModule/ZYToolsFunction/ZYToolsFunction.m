//
//  ToolsFunction.m
//  SkyEmergency
//
//  Created by ZY on 15/9/8.
//  Copyright (c) 2015年 ZY. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ZYToolsFunction.h"
#import <MessageUI/MessageUI.h>

@implementation ZYToolsFunction

#pragma mark -
#pragma mark Network

// 判断是否只含有字母、数字
+ (BOOL)isOnlyAbcAndNum:(NSString *)string
{
    if ([string length]==0) {
        return NO;
    }
    
    NSString *phoneRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return ![phoneTest evaluateWithObject:string];
}

// 对文本进行UTF8+URL编码
// stringText: 编码的文本字符串
+ (NSString *)urlEncodeUTF8String:(NSString *)stringText
{
    if (stringText == nil) {
        return nil;
    }
    
    // 启用Url编码
    NSString *urlStr = [stringText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return urlStr;
}

// 对文本进行UTF8+URL解码
+ (NSString *)urlDecodeUTF8String:(NSString *)stringText
{
    if (stringText == nil) {
        return nil;
    }
    
    NSString *urlStr = [stringText stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return urlStr;
}


// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    if (stringText == nil || font == nil)
    {
        return CGSizeZero;
    }
    CGSize size = CGSizeZero;
    
    if ([stringText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        CGRect rect = [stringText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName] context:nil];
        size = CGSizeMake(rect.size.width, rect.size.height);
    }
    else
    {
        //        size = [stringText sizeWithFont:font constrainedToSize:maxSize];
        CGRect rect = [stringText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        size = CGSizeMake(rect.size.width, rect.size.height);
    }
    
    return size;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 把image缩放到给定的size
+ (UIImage *)scaleImageSize:(UIImage *)sourceImage toSize:(CGSize)imageSize
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(imageSize);
    // 绘制改变大小的图片
    [sourceImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//裁剪成圆形
+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

// Animation
+ (void)moveUpTransition:(BOOL)bUp forLayer:(CALayer*)layer {
    CATransition *transition = [CATransition animation];
    if (bUp) {
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
    } else {
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromBottom;
    }
    [layer addAnimation:transition forKey:nil];
}

/* Get Local iOS language
 zh-Hans = 简体中文
 zh-Hant = 繁体中文
 en = 英文（其他国家默认语言）
 ja = 日语
 ar = 阿拉伯语言
 */
+ (NSString *)getOSLanguage {
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *systemlanguage = nil;
    
    if (languages)
    {
        systemlanguage = [languages objectAtIndex:0];
    }
    
    return systemlanguage;
}

// 读取plist资源数据到数组中，在外面release返回值
+ (NSMutableArray *)loadArrayFromPlist:(NSString *)fileName
                    withDictionaryPath:(NSString *)dictionaryPath
{
    NSMutableArray *arrayPlist = [[NSMutableArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", dictionaryPath, fileName]];
    return arrayPlist;
}

// 保存数组到plist文件数据
+ (BOOL)saveArrayToPlist:(NSMutableArray *)arrayInfo
            withFileName:(NSString *)fileName
      withDictionaryPath:(NSString *)dictionaryPath
{
    BOOL isSaveSuccessful = NO;
    
    if (arrayInfo==nil)
        return NO; // 异常保护
    
    NSMutableArray * arrayPlist = [[NSMutableArray alloc] initWithArray:arrayInfo];
    if (arrayPlist!=nil )
    {
        if ([arrayPlist count] > 0)
        {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isDirectory = NO;
            if(NO == [fileManager fileExistsAtPath:dictionaryPath isDirectory:&isDirectory])
            {
                [fileManager createDirectoryAtPath:dictionaryPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            if ([arrayPlist writeToFile:[NSString stringWithFormat:@"%@/%@", dictionaryPath, fileName] atomically:YES]) {
                isSaveSuccessful = YES;
            }
        }
    }
    return isSaveSuccessful;
}

// 读取plist资源数据 (注意：在外部释放返回值)
+ (NSMutableDictionary *)loadResourceFromPlist:(NSString *)fileName
                            withDictionaryPath:(NSString *)dictionaryPath
{
    NSMutableDictionary *contactPhonePlist = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", dictionaryPath, fileName]];
    return contactPhonePlist;
}

// 保存plist文件数据
+ (void)saveResourceToPlist:(NSMutableDictionary *)contactPhoneDic
               withFileName:(NSString *)fileName
         withDictionaryPath:(NSString *)dictionaryPath
{
    if(contactPhoneDic==nil)
        return;  // 异常保护
    
    NSMutableDictionary *contactDic = [[NSMutableDictionary alloc] initWithDictionary:contactPhoneDic];
    if (contactDic!=nil )
    {
        if([contactDic count] > 0)
        {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isDirectory = NO;
            
            if(NO == [fileManager fileExistsAtPath:dictionaryPath isDirectory:&isDirectory])
            {
                [fileManager createDirectoryAtPath:dictionaryPath
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:nil];
            }
            
            [contactDic writeToFile:[NSString stringWithFormat:@"%@/%@", dictionaryPath, fileName] atomically:YES];
        }
    }
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
    
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

// 判断是否为纯数字的字符串
+ (BOOL)isPureDigit:(NSString *)stringNumber
{
    int val = 0;
    NSScanner * scan = [NSScanner scannerWithString:stringNumber];
    
    BOOL bPureDigit = [scan scanInt:&val] && [scan isAtEnd];
    //    /DDLogVerbose(@"TOOLS: isPureDigit: stringNumber = %@, return bPureDigit = %d", stringNumber, bPureDigit);
    return bPureDigit;
}

// 判断是否为浮点形的字符串
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark -
#pragma mark Image Operate Function

// 旋转拍照后的图片
+ (UIImage *)rotateImage:(UIImage *)image oritation:(UIImageOrientation)theOritation
{
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef),
                                  CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    
    switch(theOritation) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width,
                                                         imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height,
                                                         imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (theOritation == UIImageOrientationRight || theOritation ==
        UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

//将图片处理成大小不超过1024
+ (CGSize)imageSizeFix:(CGSize)sourceImageSize{
    
    float imageHeight = sourceImageSize.height;
    float imageWidth = sourceImageSize.width;
    float rate = 0.0;
    
    float max = 1024.0f;
    
    if ((imageWidth > max) ||
        (imageHeight > max))
    {
        if (imageWidth > imageHeight)
        {
            rate = max / imageWidth;
            imageWidth = max;
            imageHeight = imageHeight * rate;
        }
        else {
            rate = max / imageHeight;
            imageHeight = max;
            imageWidth = imageWidth * rate;
        }
    }
    return CGSizeMake(imageWidth, imageHeight);
}

+ (NSString *)getCurrentSysDateSecond
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSince1970];
    NSString *strTimeInterval = @(floor(timeInterval)).stringValue;
    return strTimeInterval;
}

//将int型秒数转换为00：00格式
+(NSString *)secondToOOOO:(long)second
{
    NSString *tmpmm = [NSString stringWithFormat:@"%ld",(second/60)%60];
    if ([tmpmm length] == 1)
    {
        tmpmm = [NSString stringWithFormat:@"0%@",tmpmm];
    }
    NSString *tmpss = [NSString stringWithFormat:@"%ld",second%60];
    if ([tmpss length] == 1)
    {
        tmpss = [NSString stringWithFormat:@"0%@",tmpss];
    }
    NSString * resultStr = [NSString stringWithFormat:@"%@:%@",tmpmm,tmpss];
    return resultStr;
}

//将int型秒数转换为00：00格式
+(NSString *)secondToOOOOOO:(long)second
{
    NSString *tmphh = [NSString stringWithFormat:@"%ld",second/3600];
    if ([tmphh length] == 1)
    {
        tmphh = [NSString stringWithFormat:@"0%@",tmphh];
    }
    NSString *tmpmm = [NSString stringWithFormat:@"%ld",(second/60)%60];
    if ([tmpmm length] == 1)
    {
        tmpmm = [NSString stringWithFormat:@"0%@",tmpmm];
    }
    NSString *tmpss = [NSString stringWithFormat:@"%ld",second%60];
    if ([tmpss length] == 1)
    {
        tmpss = [NSString stringWithFormat:@"0%@",tmpss];
    }
    NSString * resultStr = [NSString stringWithFormat:@"%@:%@:%@",tmphh,tmpmm,tmpss];
    return resultStr;
}

+(NSString *)secondToCircleTime:(NSString *)second
{
    if ([second intValue]/60>=24) {
        return [NSString stringWithFormat:@"%d天前",[second intValue]/60/24];
    }else if ([second intValue]>=60) {
        return [NSString stringWithFormat:@"%d小时前",[second intValue]/60];
    }else if([second intValue]>0){
        return [NSString stringWithFormat:@"%d分钟前",[second intValue]];
    }else{
        return @"刚刚";
    }
}

+(float)timeToFloatWithTime:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:time];
    return [destDate timeIntervalSince1970];
}

+ (NSString *)getStandardTime:(NSString *)dateSecond withFormat:(NSString *)format
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateSecond longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *temp = [formatter stringFromDate:confromTimesp];
    
    return temp;
}

+(NSString *)getCurrentTimesTamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return timeString;
}

+(NSDate *)getOldDayDataWithNum:(long)num
{    
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    if(num!=0)
    {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*num ];
    }
    else
    {
        theDate = nowDate;
    }
    return theDate;
}

+(NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month
{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

// 判断是否只含有汉字、字母、数字
+ (BOOL)isOnlyChineseAndAbcAndNum:(NSString *)string
{
    if ([string length]==0) {
        return NO;
    }
    
    NSString *phoneRegex = @"^[\u4E00-\u9FA5A-Za-z0-9]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return ![phoneTest evaluateWithObject:string];
}

//路径是否存在
+ (BOOL)isFileExistsAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isImageFileAtPath:(NSString *)filePath
{
    BOOL file = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    file = [fileManager fileExistsAtPath:filePath];
    
    if (file) {
        
        //文件小于57byte 则不会是图片
        if ([[fileManager attributesOfItemAtPath:filePath error:nil] fileSize] <= 57) {
            
            return NO;
            
        }
        
    }
    
    return file;
}

//toJSONData
+ (NSString *)toJSONData:(id)data
{
    if (!data) {
        return @"";
    }
    if ([data isKindOfClass:[NSString class]]) {
        return data;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return @"";
    }
}

@end
