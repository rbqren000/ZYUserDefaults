//
//  ViewController.m
//  ZYUserInfo
//
//  Created by mac mini on 2020/5/7.
//  Copyright © 2020 objcat. All rights reserved.
//

#import "ViewController.h"
#import "ZYUserInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    x_info.token = @"sjkldfjlksdjf";
    x_info.isLogin = YES;
    x_info.dic = @{@"name": @"张三", @"age": @"16"};
    x_info.arr = @[@"1", @(2), @"3"];
    x_info.index = 1;
    x_info.intA = 2;
    
    x_info.number = @(3.04);
    x_info.floatA = 3.01;
    x_info.doubleA = 4.03;
    x_info.longA = 5l;
    
    // 注意ZYUserInfo尽量不要使用可变类型的变量, 比如可变数组
    // 如果确实需要使用, 请注意使用规范
    x_info.marr = @[@"123"].mutableCopy;
    
    // 增加值后比如再次进行数组赋值才能监听到并存储
    [x_info.marr addObject:@"123"];
    x_info.marr = x_info.marr;
    
    // 或者是使用如下方法, 进行赋值就可以做到实时存储的效果了
    [[x_info mutableArrayValueForKey:@"marr"] addObject:@"1234"];
    
    NSLog(@"%@", x_info);
}


@end
