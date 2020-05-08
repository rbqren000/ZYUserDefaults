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
    
   
    NSLog(@"%@", x_info);
    
    [x_info clean];
    
    NSLog(@"清理后:%@", x_info);
    
}


@end
