//
//  ViewController.m
//  ZYUserDefaults
//
//  Created by mac mini on 2020/5/7.
//  Copyright © 2020 objcat. All rights reserved.
//

#import "ViewController.h"
#import "ZYUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    x_store.token = @"sjkldfjlksdjf";
    x_store.isLogin = YES;
    x_store.dic = @{@"name": @"张三", @"age": @"16"};
    x_store.arr = @[@"1", @(2), @"3"];
    x_store.index = 1;
    x_store.intA = 2;
    
    x_store.number = @(3.01);
    x_store.floatA = 3.01;
    x_store.doubleA = 4.03;
    x_store.longA = 5l;
    
    // 注意ZYUserDefaults尽量不要使用可变类型的变量, 比如可变数组
    // 如果确实需要使用, 请注意使用规范
    x_store.marr = @[@"123"].mutableCopy;
    
    // 增加值后比如再次进行数组赋值才能监听到并存储
    [x_store.marr addObject:@"123"];
    x_store.marr = x_store.marr;
    
    // 或者是使用如下方法, 进行赋值就可以做到实时存储的效果了
    [[x_store mutableArrayValueForKey:@"marr"] addObject:@"1234"];
    
    NSLog(@"%@", x_store);
}


@end
