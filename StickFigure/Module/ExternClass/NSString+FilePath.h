//
//  NSString+FilePath.h
//  AirHospital
//
//  Created by C_HAO on 15/10/9.
//  Copyright © 2015年 C_HAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FilePath)


/**
 home路径
 */
+ (NSString *)homeDirectory;

/**
 document路径
 */
+(NSString *)documentDirectory;

/**
 图片默认路径
 */
+(NSString *)imageDefultDirectory;

/**
 音频默认路径
 */
+(NSString *)voiceDefultDirectory;

/**
 *  手卫生音频路径
 */
+ (NSString *)DidiSwsVoicePath;




/**
 *  APP首次加载展示广告图片路径
 */
+(NSString *)FirstAddAdImagePath;

/**
 *  用户头像图片路径
 */
+ (NSString *)userAvatarImagePath;

/**
 *  医生认证图片路径
 */
+ (NSString *)DocAuthImageImagePath;

/**
 *  Didi医生图片路径
 */
+ (NSString *)DidiDocImagePath;

///**
// *  聊天缩略图路径
// */
//+ (NSString *)userThumbnailImagePath;

///**
// *  聊天图片路径
// */
//+ (NSString *)userImagePath;
//
///**
// *  聊天音频路径
// */
//+ (NSString *)userVoicePath;
//
///**
// *  用户文件路径
// */
//+ (NSString *)userFilePath;

/**
 *  临时路径
 */
+ (NSString *)tempPath;

@end
