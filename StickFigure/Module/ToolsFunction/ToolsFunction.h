//
//  ToolsFunction.h
//  SkyEmergency
//
//  Created by ZY on 15/9/8.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsFunction : NSObject

#pragma mark -
#pragma mark Network
// Check the reachability of internet
+ (void)checkInternetReachability;

// 检查并提示用户开启推送通知
+ (void)checkAndShowPushNotificationDisableAlert;

//获取顶层controller
+ (UIViewController *)getCurrentRootViewController;

//获取登录controller
+ (UIViewController *)getSignViewController;

+ (void)exitApp;

//判断用户是否第一次登录
+(BOOL)checkUserIsFirstLogin;

//设置用户是否第一次登录标记
+(void)setUserFirstLoginCheck;

// 判断是否只含有字母、数字
+ (BOOL)isOnlyAbcAndNum:(NSString *)string;

#pragma mark -
#pragma mark 提示框部分
// 添加自定义提示框(图片+文字)
+ (void)showPromptViewWithString:(NSString*)string background:(UIImage*)image timeDuration:(int)duration;

// 显示请求提示窗
+ (void)showHttpPromptView:(UIView *)view;

// 隐藏请求提示窗
+ (void)hideHttpPromptView:(UIView *)view;

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

//设置cell的右边箭头
+ (void)setCellAccessoryView:(UITableViewCell *)cell;

// Get Local iOS language
+ (NSString *)getOSLanguage;

//保存数组至plist
+ (void)saveArrayData:(NSArray *)dataArray withPlistFileName:(NSString *)fileName;

//保存字典至plist
+ (void)saveDictionaryData:(NSDictionary *)dataDictionary withPlistFileName:(NSString *)fileName;

//读取plist 数组
+ (NSArray *)loadPlistArrayData:(NSString *)fileName;

//读取plist 字典
+ (NSDictionary *)loadPlistDictionaryData:(NSString *)fileName;

//获取文件大小
+ (NSString *)getFileSizePath:(NSString *)filePath;

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateMobile:(NSString *)mobile;

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email;

// 判断是否为纯数字的字符串
+ (BOOL)isPureDigit:(NSString *)stringNumber;

// 判断是否为浮点形的字符串
+ (BOOL)isPureFloat:(NSString *)string;

//去掉字符串首尾空格
+ (NSString *)replaceStrForeAndaftApace:(NSString *)str;

//正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName;

//是否为ip地址
+ (BOOL)isValidIP:(NSString *)ipStr;

// 使用原生的电话切换到GSM呼叫
+ (void)callToGSM:(NSString *)phoneNumber;

// 通过iOS SMS接口发送短信
//+ (BOOL)sendSMSMessage:(NSString *)contentString toPhone:(NSArray *)numberString;

// 判断是否正确UID
+ (BOOL)isUserID:(NSString *)userID;

+ (BOOL)isOrderID:(NSString *)orderID;

#pragma mark -
#pragma mark Image Operate Function

// 旋转拍照后的图片
+ (UIImage *)rotateImage:(UIImage *)image oritation:(UIImageOrientation)theOritation;

//将图片处理成大小不超过1024
+ (CGSize)imageSizeFix:(CGSize)sourceImageSize;

//获取当前系统时间
+ (NSString *)getCurrentSysDateSecond;

//将int型秒数转换为00：00格式
+(NSString *)secondToOOOO:(NSInteger)second;

//将int型秒数转换为00：00格式
+(NSString *)secondToOOOOOO:(NSInteger)second;

//将秒数转化为朋友圈所展示的时间格式
+(NSString *)secondToCircleTime:(NSString *)second;

// 标准时间转时间戳
+(float)timeToFloatWithTime:(NSString *)time;

// 时间戳按格式转为标准时间(秒)
+ (NSString *)getStandardTime:(NSString *)dateSecond withFormat:(NSString *)format;

// 标准时间（年月日时分秒）转为标准时间格式(秒)
+ (NSString *)getFormatTime:(NSString *)dateStr withFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

//获取当前时间的时间戳
+(NSString *)getCurrentTimesTamp;

//获取前某天的日期
+(NSDate *)getOldDayDataWithNum:(long)num;

//获取前某个月的时间
+(NSDate *)getPriousorLaterDateFromDate:(int)month;

//获取指定年月的当月天数
+(NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month;

// 判断是否只含有汉字、字母、数字
+ (BOOL)isOnlyChineseAndAbcAndNum:(NSString *)string;

// 获取每通电话的CallID（格式：user id -unix epoch time(s)-2 digits random number，如：24000001-1307516199-83）
+ (NSString *)getCurrentCallID:(NSString *)userID;

//路径是否存在
+ (BOOL)isFileExistsAtPath:(NSString *)filePath;

//图片是否存在
+ (BOOL)isImageFileAtPath:(NSString *)filePath;

//清空路径下内容
+ (void)clearPathFile:(NSString *)filePath;

//toJSONData
+ (NSString *)toJSONData:(id)data;

////音频格式转换
//+ (NSString *)SEAudioFilePath:(NSString *)filePath;
//
////文字转语音
//+ (void)SETTSWithStr:(NSString *)textStr;

@end

