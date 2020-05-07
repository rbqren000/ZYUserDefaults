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
    
    NSLog(@"%@", x_info);
    
}


@end
