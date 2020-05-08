//
//  ZYUserInfo.m
//  ZYKit
//
//  Created by 张祎 on 2020/5/7.
//  Copyright © 2020 objcat. All rights reserved.
//

#import "ZYUserInfo.h"
#import "objc/runtime.h"

@interface ZYUserInfo ()
@property (strong, nonatomic) NSUserDefaults *ud;
@property (strong, nonatomic) NSMutableArray *propertyList;
@end

@implementation ZYUserInfo

/**
 *  单例
 */
+ (instancetype)shareInstance {
    static ZYUserInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[ZYUserInfo alloc] init];
        // 自定义保存位置 不喜欢 standardUserDefaults - -
        info.ud = [[NSUserDefaults alloc] initWithSuiteName:@"zy_info"];
        [info bindData];
        [info addObserver];
        NSLog(@"ZYUserInfo启动成功, 保存路径: \n %@/Preferences/zy_info.plist", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]);
    });
    return info;
}

/**
 *  绑定数据 目前仅用于初始化
 */
- (void)bindData {
    for (NSString *propertyName in self.propertyList) {
        id value = [self.ud objectForKey:propertyName];
        if (value == nil) continue;
        [self setValue:value forKey:propertyName];
    }
}

/**
 *  设置监听
 */
- (void)addObserver {
    for (NSString *property in self.propertyList) {
        [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
    }
}

/**
 *  KVO
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id value = [object valueForKey:keyPath];
    [self.ud setObject:value forKey:keyPath];
}

/**
 *  获取属性列表
 */
- (NSArray *)propertyList {
    if (!_propertyList) {
        _propertyList = [NSMutableArray array];
        unsigned count = 0;
        // 设置屏蔽属性
        NSArray *ignores = @[@"propertyList", @"ud"];
        objc_property_t *properties = class_copyPropertyList(self.class, &count);
        for (NSInteger i = 0; i < count; i++) {
            NSString *prop = [NSString stringWithFormat:@"%s", property_getName(properties[i])];
            if ([ignores containsObject:prop]) {
                continue;
            }
            [_propertyList addObject:prop];
        }
        free(properties);
    }
    return _propertyList;
}

/**
 *  打印模型
 */
- (NSString *)description {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *propertyName in self.propertyList) {
        // 设置nil打印值
        id value = [self valueForKey:propertyName] ? : @"我是空的nil";
        [dictionary setObject:value forKey:propertyName];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:1 error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"<%@: %p> \n %@ ", [self class], self, str];
}

- (void)clean {
    // 清理属性
    [self cleanPropertys];
    // 清理ud, 理论上来说上面的方法已经全部清空了, 但是NSNumber类型的仍然会存留在ud不清理也没什么关系 这里还是选择了清理
    [self cleanUserDefaults];
}

- (void)cleanPropertys {
    for (NSString *propertyName in self.propertyList) {
        if ([[self valueForKey:propertyName] isKindOfClass:[NSNumber class]]) {
            //NSNumber bool int float long
            [self setValue:@(0) forKey:propertyName];
        } else {
            [self setValue:nil forKey:propertyName];
        }
    }
}

- (void)cleanUserDefaults {
    NSDictionary *dic = [self.ud dictionaryRepresentation];
    for (id key in dic) {
        [self.ud removeObjectForKey:key];
    }
    [self.ud synchronize];
}

- (void)dealloc {
    // 由于是单例 所以不用担心释放的问题 固不用移除
    //        NSArray *propertys = self.propertyList;
    //        for (NSString *property in propertys) {
    //            [self removeObserver:self forKeyPath:property];
    //        }
}

@end