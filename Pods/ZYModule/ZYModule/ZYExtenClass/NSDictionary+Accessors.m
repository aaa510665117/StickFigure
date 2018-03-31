//
//  NSDictionary+Accessors.m
//  Belle
//
//  Created by Allen Hsu on 1/11/14.
//  Copyright (c) 2014 Allen Hsu. All rights reserved.
//

#import "NSDictionary+Accessors.h"

@implementation NSDictionary (Accessors)

- (BOOL)ac_isKindOfClass:(Class)aClass forKey:(NSString *)key
{
    id value = [self objectForKey:key];

    return [value isKindOfClass:aClass];
}

- (BOOL)ac_isMemberOfClass:(Class)aClass forKey:(NSString *)key
{
    id value = [self objectForKey:key];

    return [value isMemberOfClass:aClass];
}

- (BOOL)ac_isArrayForKey:(NSString *)key
{
    return [self ac_isKindOfClass:[NSArray class] forKey:key];
}

- (BOOL)ac_isDictionaryForKey:(NSString *)key
{
    return [self ac_isKindOfClass:[NSDictionary class] forKey:key];
}

- (BOOL)ac_isStringForKey:(NSString *)key
{
    return [self ac_isKindOfClass:[NSString class] forKey:key];
}

- (BOOL)ac_isNumberForKey:(NSString *)key
{
    return [self ac_isKindOfClass:[NSNumber class] forKey:key];
}

- (NSString *)ac_stringForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        return number.stringValue;
    } else if ([value respondsToSelector:@selector(description)]) {
        if ([@"<null>" isEqualToString:[value description]]) {
            return nil;
        }
        
        return [value description];
    }
    
    return nil;
}



- (NSArray *)ac_arrayForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }

    return nil;
}

- (NSDictionary *)ac_dictionaryForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }

    return nil;
}

- (NSNumber *)ac_numberForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        return [nf numberFromString:value];
    }

    return nil;
}

- (double)ac_doubleForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value doubleValue];
    }

    return 0;
}

- (float)ac_floatForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }

    return 0;
}

- (int)ac_intForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value intValue];
    }

    return 0;
}

- (unsigned int)ac_unsignedIntForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }

    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntValue];
    }

    return 0;
}

- (NSInteger)ac_integerForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }

    return 0;
}

- (NSUInteger)ac_unsignedIntegerForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }

    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }

    return 0;
}

- (long long)ac_longLongForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }

    return 0;
}

- (unsigned long long)ac_unsignedLongLongForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }

    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }

    return 0;
}

- (BOOL)ac_boolForKey:(NSString *)key
{
    id value = [self objectForKey:key];

    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }

    return NO;
}

@end
