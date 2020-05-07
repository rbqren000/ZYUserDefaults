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
 *  绑定数据
 */
- (void)bindData {
    NSArray *propertys = self.propertyList;
    for (NSString *property in propertys) {
        id value = [self.ud objectForKey:property];
        if (value == nil) continue;
        [self setValue:value forKey:property];
    }
}

/**
 *  KVO
 */
- (void)addObserver {
    NSArray *propertys = self.propertyList;
    for (NSString *property in propertys) {
        [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
    }
}

/**
 *  KVO
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id value = [object valueForKey:keyPath];
    if (value) {
        [self.ud setObject:value forKey:keyPath];
    }
}

/**
 *  懒加载
 */
- (NSArray *)propertyList {
    if (!_propertyList) {
        _propertyList = [NSMutableArray array];
        unsigned count = 0;
        // 忽略这两个属性
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
    NSArray *propertyList = [self propertyList];
    for (NSString *key in propertyList) {
        // 设置默认值
        id value = [self valueForKey:key] ? : @"nil";
        [dictionary setObject:value forKey:key];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:1 error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"<%@: %p> \n %@ ", [self class], self, str];
}

- (void)dealloc {
    // 由于是单例 所以不用担心释放的问题 固不用移除
    //    NSArray *propertys = self.propertyList;
    //    for (NSString *property in propertys) {
    //        [self removeObserver:self forKeyPath:property];
    //    }
}

@end
