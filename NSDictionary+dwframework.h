//
//  NSDictionary+jojo.h
//  PoBar
//
//  Created by jojo on 6/8/14.
//  Copyright (c) 2014 jojo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSUInteger, DWDictionaryKeySortedType) {
    DWDictionaryKeySortedTypeAscending,
    DWDictionaryKeySortedTypeDescending,
};

@interface NSDictionary (dwframework)

- (id)objectForKey:(NSString *)key defalutObj:(id)defaultObj;
- (id)objectForKey:(id)aKey ofClass:(Class)aClass defaultObj:(id)defaultObj;
- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue;
- (long)longValueForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long long)longlongValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSArray *)arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSDictionary *)dictionaryValueForKey:(NSString *)key defalutValue:(NSDictionary *)defaultValue;

- (void)setRect:(CGRect)rect forKey:(NSString *)key;
- (CGRect)rectValueForKey:(NSString *)key;

- (NSArray *)sortedKeysWithOption:(DWDictionaryKeySortedType)type;
- (NSArray *)allValuesWithKeySortedOpetion:(DWDictionaryKeySortedType)type;

// 过滤NSNull
- (NSDictionary *)dictionaryWithoutNullValue;

@end
