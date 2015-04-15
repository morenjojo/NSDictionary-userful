//
//  NSDictionary+jojo.m
//  PoBar
//
//  Created by jojo on 6/8/14.
//  Copyright (c) 2014 jojo. All rights reserved.
//

#import "NSDictionary+dwframework.h"

@implementation NSDictionary (dwframework)

- (id)objectForKey:(NSString *)key defalutObj:(id)defaultObj {
    id obj = [self objectForKey:key];
    return obj ? obj : defaultObj;
}

- (id)objectForKey:(id)aKey ofClass:(Class)aClass defaultObj:(id)defaultObj {
    id obj = [self objectForKey:aKey];
    return (obj && [obj isKindOfClass:aClass]) ? obj : defaultObj;
}

- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value intValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value intValue] : defaultValue;
}

- (int)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value floatValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value floatValue] : defaultValue;
}
- (long)longValueForKey:(NSString *)key defaultValue:(long)defaultValue {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return (long)[(NSString *)value longLongValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value longValue] : defaultValue;
}

- (long long)longlongValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value longLongValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value longLongValue] : defaultValue;
}

- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return value;
    }else if(value && [value isKindOfClass:[NSNumber class]]){
        return [value stringValue];
    }else{
        return defaultValue;
    }
}

- (NSArray *)arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue {
    id value = [self objectForKey:key];
    return (value && [value isKindOfClass:[NSArray class]]) ? value : defaultValue;
}

- (NSDictionary *)dictionaryValueForKey:(NSString *)key defalutValue:(NSDictionary *)defaultValue {
    id value = [self objectForKey:key];
    return (value && [value isKindOfClass:[NSDictionary class]]) ? value : defaultValue;
}

- (void)setRect:(CGRect)rect forKey:(NSString *)key {
    if (key) {
        CFDictionaryRef dictionaryRef = CGRectCreateDictionaryRepresentation(rect);
        if (dictionaryRef) {
            [self setValue:(__bridge NSDictionary *)dictionaryRef forKey:key];
            CFRelease(dictionaryRef);
        }
    }
}

- (CGRect)rectValueForKey:(NSString *)key {
    CGRect rect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
    if (key) {
        id object = [self valueForKey:key];
        if (object && [object isKindOfClass:[NSDictionary class]]) {
            bool result = false;
            result = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)object, &rect);
            if (!result) {
                rect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
            }
        }
    }
    return rect;
}

- (NSArray *)sortedKeysWithOption:(DWDictionaryKeySortedType)type {
    NSArray *allKeys = [self allKeys];
    NSArray *sortedKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (type == DWDictionaryKeySortedTypeAscending) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }
        else {
            return [obj2 compare:obj1 options:NSNumericSearch];
        }
    }];
    
    return sortedKeys;
}

- (NSArray *)allValuesWithKeySortedOpetion:(DWDictionaryKeySortedType)type {
    if (self.count > 0) {
        NSArray *sortedKeys = [self sortedKeysWithOption:type];
        NSMutableArray *mtArr = [NSMutableArray array];
        
        for (NSString *key in sortedKeys) {
            [mtArr addObject:[self objectForKey:key]];
        }
        
        return mtArr;
    }
    return nil;
}

- (NSDictionary *)dictionaryWithoutNullValue {
    if (self.count > 0) {
        NSMutableDictionary *mutDic = [NSMutableDictionary new];
        
        [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (![obj isKindOfClass:[NSNull class]]) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    obj = [obj dictionaryWithoutNullValue];
                }
                [mutDic setObject:obj forKey:key];
            }
        }];
        
        return mutDic;
    }
    
    return self;
}

@end
