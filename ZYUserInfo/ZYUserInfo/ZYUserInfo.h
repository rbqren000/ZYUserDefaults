//
//  ZYUserInfo.h
//  ZYKit
//
//  Created by 张祎 on 2020/5/7.
//  Copyright © 2020 objcat. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  宏定义方便使用
 *  可以改成你想要的名称
 *  建议不要命名成"info"这类过于简单的字样 容易发生冲突
 */
#define x_info [ZYUserInfo shareInstance]

/**
 *  数据存储工具类
 *  默认存储到 zy_info.plist
 *  可以存储基本数据类型和
 */
@interface ZYUserInfo : NSObject
@property (strong, nonatomic) NSString *token;
@property (assign, nonatomic) BOOL isLogin;
@property (strong, nonatomic) NSDictionary *dic;
@property (strong, nonatomic) NSArray *arr;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSString *haha;
@property (strong, nonatomic) NSNumber *number;
@property (assign, nonatomic) int intA;
@property (assign, nonatomic) float floatA;
@property (assign, nonatomic) long longA;
@property (assign, nonatomic) double doubleA;

/**
 *  单例初始化
 */
+ (instancetype)shareInstance;

/**
 *  清空所有数据
 */
- (void)clean;

@end