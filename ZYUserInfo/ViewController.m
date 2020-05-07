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
    
    zy_info.token = @"sjkldfjlksdjf";
    zy_info.isLogin = YES;
    zy_info.dic = @{@"name": @"张三", @"age": @"16"};
    zy_info.arr = @[@"1", @(2), @"3"];
    zy_info.index = 1;
    
    NSLog(@"%@", zy_info);
}


@end
