//
//  NSDictionary+Accessors.h
//  Belle
//
//  Created by Allen Hsu on 1/11/14.
//  Copyright (c) 2014 Allen Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Accessors)

- (BOOL)ac_isKindOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)ac_isMemberOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)ac_isArrayForKey:(NSString *)key;
- (BOOL)ac_isDictionaryForKey:(NSString *)key;
- (BOOL)ac_isStringForKey:(NSString *)key;
- (BOOL)ac_isNumberForKey:(NSString *)key;

- (NSArray *)ac_arrayForKey:(NSString *)key;
- (NSDictionary *)ac_dictionaryForKey:(NSString *)key;
- (NSString *)ac_stringForKey:(NSString *)key;
- (NSNumber *)ac_numberForKey:(NSString *)key;
- (double)ac_doubleForKey:(NSString *)key;
- (float)ac_floatForKey:(NSString *)key;
- (int)ac_intForKey:(NSString *)key;
- (unsigned int)ac_unsignedIntForKey:(NSString *)key;
- (NSInteger)ac_integerForKey:(NSString *)key;
- (NSUInteger)ac_unsignedIntegerForKey:(NSString *)key;
- (long long)ac_longLongForKey:(NSString *)key;
- (unsigned long long)ac_unsignedLongLongForKey:(NSString *)key;
- (BOOL)ac_boolForKey:(NSString *)key;

@end
