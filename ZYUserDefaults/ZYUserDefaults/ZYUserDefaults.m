//
//  ZYUserDefaults.m
//  ZYKit
//
//  Created by 张祎 on 2020/5/7.
//  Copyright © 2020 objcat. All rights reserved.
//

#import "ZYUserDefaults.h"
#import "objc/runtime.h"

@interface ZYUserDefaults ()
@property (strong, nonatomic) NSUserDefaults *ud;
@property (strong, nonatomic) NSUserDefaults *zy_env;
@property (strong, nonatomic) NSMutableArray *propertyList;
@property (strong, nonatomic) NSMutableDictionary *typeList;
@end

@implementation ZYUserDefaults

/**
 *  单例
 */
+ (instancetype)shareInstance {
    static ZYUserDefaults *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[[self class] alloc] init];
        // 设置zy_env路径
        info.zy_env = [[NSUserDefaults alloc] initWithSuiteName:@"zy_env"];
        // 设置ud路径
        info.ud = [[NSUserDefaults alloc] initWithSuiteName:@"zy_ud"];
        // 绑定数据
        [info bindData];
        // 监听数据变化
        [info addObserver];
        NSLog(@"ZYUserDefaults启动成功, 保存路径: \n %@/Preferences/zy_ud.plist", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]);
    });
    return info;
}

- (NSMutableDictionary *)typeList {
    if (!_typeList) {
        _typeList = [NSMutableDictionary dictionary];
    }
    return _typeList;
}

/// 绑定数据 目前仅用于初始化
- (void)bindData {
    for (NSString *propertyName in self.propertyList) {
        id value = nil;
        if ([propertyName isEqualToString:@"environment"]) {
            value = [self.zy_env objectForKey:propertyName];
        } else {
            value = [self.ud objectForKey:propertyName];
        }
        [self safeSetValueForKey:propertyName value:value];
    }
}

/// 设置监听
- (void)addObserver {
    for (NSString *property in self.propertyList) {
        [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
    }
}

// 忽略bindData的属性
- (NSArray *)ignore_properties {
    return @[@"propertyList", @"zy_env", @"ud", @"typeList", @"environment"];
}

/// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id value = [object valueForKey:keyPath];
    if ([keyPath isEqualToString:@"environment"]) {
        // 保存环境的变量单独放在env, 防止clean时改变环境
        [self.zy_env setObject:value forKey:keyPath];
    } else {
        [self safeSetObjectWithStore:self.ud key:keyPath value:value];
    }
}

/// 获取属性列表
- (NSArray *)propertyList {
    if (!_propertyList) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *keys = [self zy_propertity_keys];
        for (NSString *key in keys) {
            if ([self.ignore_properties containsObject:key]) {
                continue;
            }
            [tempArray addObject:key];
        }
        _propertyList = tempArray.copy;
    }
    return _propertyList;
}

- (NSArray *)zy_propertity_keys {
    // key字典
    NSMutableArray *keyArray = [NSMutableArray array];
    // 类
    Class clz = self.class;
    // 遍历属性列表
    while (1) {
        // 获取属性列表
        unsigned int count;
        objc_property_t *propertyArray = class_copyPropertyList(clz, &count);
        for (unsigned int i = 0; i < count; i++) {
            objc_property_t property = propertyArray[i];
            NSString *key = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *type = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            self.typeList[key] = type ? : @"";
            [keyArray addObject:key];
        }
        // 释放属性列表
        free(propertyArray);
        // 找完子类找父类
        clz = class_getSuperclass(clz);
        // 父类找到NSObject为止跳出
        if ([clz isEqual:[NSObject class]]) {
            break;
        }
    }
    return keyArray.copy;
}

/// 打印模型
- (NSString *)description {
    NSString *result = [NSMutableString string];
    /// 打印环境
    NSString *propertyKeyValue = [NSString stringWithFormat:@"environment %@", [self valueForKey:@"environment"]];
    result = [NSString stringWithFormat:@"%@ \n %@", result, propertyKeyValue];
    /// 打印值
    for (NSString *propertyName in self.propertyList) {
        NSString *propertyKeyValue = [NSString stringWithFormat:@"%@ %@", propertyName, [self valueForKey:propertyName]];
        result = [NSString stringWithFormat:@"%@ \n %@", result, propertyKeyValue];
    }
    return result;
}

- (void)clean {
    // 清理属性
    [self cleanPropertys];
    // 清理ud, 理论上来说上面的方法已经全部清空了, 但是NSNumber类型的仍然会存留在ud不清理也没什么关系 但这里还是选择了清理
    [self cleanUserDefaults];
}

- (void)cleanPropertys {
    for (NSString *propertyName in self.propertyList) {
        [self safeSetValueForKey:propertyName value:nil];
    }
}

- (void)cleanUserDefaults {
    NSDictionary *dic = [self.ud dictionaryRepresentation];
    for (id key in dic) {
        [self.ud removeObjectForKey:key];
    }
    [self.ud synchronize];
}

- (void)safeSetObjectWithStore:(NSUserDefaults *)store key:(id)key value:(id)value {
    Class classz = [self classFromKey:key];
    if ([value isKindOfClass:classz]) {
        // 如果类型正确设置正确的值
        [store setObject:value forKey:key];
    } else {
           
#ifdef DEBUG
        NSLog(@"key=%@ 的`值类型`与`属性类型`不符 被直接置空!", key);
#endif
        // 如果类型错误直接设为空
        [store setObject:nil forKey:key];
    }
}

- (void)safeSetValueForKey:(NSString *)key value:(id)value {
    Class classz = [self classFromKey:key];
    if (value == nil) {
        [self safeSetNilValueForKey:key];
    } else {
        if ([value isKindOfClass:classz]) {
            [self setValue:value forKey:key];
        } else {
            [self safeSetNilValueForKey:key];
        }
    }
}

- (void)safeSetNilValueForKey:(NSString *)key {
    Class classz = [self classFromKey:key];
    if ([classz isEqual:[NSNumber class]]) {
        [self setValue:@(0) forKey:key];
    } else {
        [self setValue:nil forKey:key];
    }
}

- (Class)classFromKey:(NSString *)key {
    NSString *type = self.typeList[key];
//    NSLog(@"key=%@ type=%@", key, type);
    if ([type hasPrefix:@"T@\"NSString\""]) {
        return [NSString class];
    } else if ([type hasPrefix:@"T@\"NSMutaleString\""]) {
        return [NSMutableString class];
    } else if ([type hasPrefix:@"T@\"NSNumber\""] || ![type containsString:@"T@"]) {
        // Ti int, Tf float, Td double, Tq NSInteger, TQ NSUInteger, TB BOOL, TC Boolean
        return [NSNumber class];
    } else if ([type hasPrefix:@"T@\"NSArray\""]) {
        return [NSArray class];
    } else if ([type hasPrefix:@"T@\"NSMutableArray\""]) {
        return [NSMutableArray class];
    } else if ([type hasPrefix:@"T@\"NSDictionary\""]) {
        return [NSDictionary class];
    } else if ([type hasPrefix:@"T@\"NSMutableDictionary\""]) {
        return [NSMutableDictionary class];
    } else if ([type hasPrefix:@"T@\"NSData\""]) {
        return [NSData class];
    } else if ([type hasPrefix:@"T@\"NSMutableData\""]) {
        return [NSMutableData class];
    } else if ([type hasPrefix:@"T@\"NSDate\""]) {
        return [NSDate class];
    }
    return nil;
}

- (void)dealloc {
    // 由于是单例 所以不用担心释放的问题 固不用移除
}

@end
