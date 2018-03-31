//
//  ToolsFunction.h
//  SkyEmergency
//
//  Created by ZY on 15/9/8.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYToolsFunction : NSObject

// 判断是否只含有字母、数字
+ (BOOL)isOnlyAbcAndNum:(NSString *)string;

// 对文本进行UTF8+URL编码
// stringText: 编码的文本字符串
+ (NSString *)urlEncodeUTF8String:(NSString *)stringText;

// 对文本进行UTF8+URL解码
+ (NSString *)urlDecodeUTF8String:(NSString *)stringText;

// 获取字符串的长度
+ (CGSize)getSizeFromString:(NSString *)stringText withFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;

//颜色与图片的转换
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 把image缩放到给定的size
+ (UIImage *)scaleImageSize:(UIImage *)sourceImage toSize:(CGSize)imageSize;

//裁剪成圆形  insert--画布大小缩进值
+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

// Animation
+ (void)moveUpTransition:(BOOL)bUp forLayer:(CALayer*)layer;

// Get Local iOS language
+ (NSString *)getOSLanguage;

// 读取plist资源数据到数组中
+ (NSMutableArray *)loadArrayFromPlist:(NSString *)fileName
                    withDictionaryPath:(NSString *)dictionaryPath;
// 保存数组到plist文件数据
+ (BOOL)saveArrayToPlist:(NSMutableArray *)arrayInfo
            withFileName:(NSString *)fileName
      withDictionaryPath:(NSString *)dictionaryPath;

// 读取plist资源数据 (注意：在外部释放返回值)
+ (NSMutableDictionary *)loadResourceFromPlist:(NSString *)fileName
                            withDictionaryPath:(NSString *)dictionaryPath;

// 保存plist文件数据
+ (void)saveResourceToPlist:(NSMutableDictionary *)contactPhoneDic
               withFileName:(NSString *)fileName
         withDictionaryPath:(NSString *)dictionaryPath;

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateMobile:(NSString *)mobile;

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email;

// 判断是否为纯数字的字符串
+ (BOOL)isPureDigit:(NSString *)stringNumber;

// 判断是否为浮点形的字符串
+ (BOOL)isPureFloat:(NSString *)string;

// 旋转拍照后的图片
+ (UIImage *)rotateImage:(UIImage *)image oritation:(UIImageOrientation)theOritation;

//将图片处理成大小不超过1024
+ (CGSize)imageSizeFix:(CGSize)sourceImageSize;

//获取当前系统时间
+ (NSString *)getCurrentSysDateSecond;

//将int型秒数转换为00：00格式
+(NSString *)secondToOOOO:(long)second;

//将int型秒数转换为00：00格式
+(NSString *)secondToOOOOOO:(long)second;

//将秒数转化为朋友圈所展示的时间格式
+(NSString *)secondToCircleTime:(NSString *)second;

// 标准时间转时间戳
+(float)timeToFloatWithTime:(NSString *)time;

// 时间戳按格式转为标准时间(秒)
+ (NSString *)getStandardTime:(NSString *)dateSecond withFormat:(NSString *)format;

//获取当前时间的时间戳
+(NSString *)getCurrentTimesTamp;

//获取前某天的日期
+(NSDate *)getOldDayDataWithNum:(long)num;

//获取指定年月的当月天数
+(NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month;

// 判断是否只含有汉字、字母、数字
+ (BOOL)isOnlyChineseAndAbcAndNum:(NSString *)string;

//路径是否存在
+ (BOOL)isFileExistsAtPath:(NSString *)filePath;

//图片是否存在
+ (BOOL)isImageFileAtPath:(NSString *)filePath;

//toJSONData
+ (NSString *)toJSONData:(id)data;

@end

