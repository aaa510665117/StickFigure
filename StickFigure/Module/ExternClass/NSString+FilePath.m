//
//  NSString+FilePath.m
//  AirHospital
//
//  Created by C_HAO on 15/10/9.
//  Copyright © 2015年 C_HAO. All rights reserved.
//

#import "NSString+FilePath.h"

@implementation NSString (FilePath)

+ (NSString *)homeDirectory
{
    return NSHomeDirectory();
}

+ (NSString *)documentDirectory
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
}

+ (NSString *)imageDefultDirectory
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Image"];
}

+ (NSString *)voiceDefultDirectory
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Voice"];
}

+(NSString *)FirstAddAdImagePath;
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Image/FirstAPPAdImage"];
    BOOL isDirectory = NO;
    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)userAvatarImagePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Image/AvatarImage"];
    BOOL isDirectory = NO;
    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)DocAuthImageImagePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Image/DocAuthImage"];
    BOOL isDirectory = NO;
    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)DidiDocImagePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Image/DidiDocImage"];
    BOOL isDirectory = NO;
    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)DidiSwsVoicePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Voice/DidiSwsVoice"];
    BOOL isDirectory = NO;
    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

//+ (NSString *)userThumbnailImagePath
//{
//    AppDelegate *appDelegate = [AppDelegate appDelegate];
//    if (!appDelegate.userProfile.userID) {
//        return NSHomeDirectory();
//    }
//    NSFileManager *manager = [NSFileManager defaultManager];
//    
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/Image/thumbnail",appDelegate.userProfile.userID]];
//    BOOL isDirectory = YES;
//    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
//        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    return path;
//}

//+ (NSString *)userImagePath
//{
//    AppDelegate *appDelegate = [AppDelegate appDelegate];
//    if (!appDelegate.userProfile.userID) {
//        return NSHomeDirectory();
//    }
//    NSFileManager *manager = [NSFileManager defaultManager];
//    
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/Image",appDelegate.userProfile.userID]];
//    BOOL isDirectory = NO;
//    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
//        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    return path;
//}

//+ (NSString *)userVoicePath
//{
//    AppDelegate *appDelegate = [AppDelegate appDelegate];
//    if (!appDelegate.userProfile.userID) {
//        return NSHomeDirectory();
//    }
//    NSFileManager *manager = [NSFileManager defaultManager];
//
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/Voice",appDelegate.userProfile.userID]];
//    BOOL isDirectory = NO;
//    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
//        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    return path;
//}
//
//+ (NSString *)userFilePath
//{
//    AppDelegate *appDelegate = [AppDelegate appDelegate];
//    if (!appDelegate.userProfile.userID) {
//        return NSHomeDirectory();
//    }
//    NSFileManager *manager = [NSFileManager defaultManager];
//
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/File/",appDelegate.userProfile.userID]];
//    BOOL isDirectory = NO;
//    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
//        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    return path;
//}

+ (NSString *)tempPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/temp/"];
    BOOL isDirectory = NO;
    if (NO == [manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

@end
