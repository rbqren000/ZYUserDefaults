//
//  ZYUserDefaultsViewController.m
//  ZYUserDefaults
//
//  Created by objcat on 2022/1/26.
//  Copyright © 2022 objcat. All rights reserved.
//

#import "ZYUserDefaultsViewController.h"
#import "ZYUserDefaultsExampleViewController.h"
#import "ZYUserDefaults-Swift.h"

@interface ZYUserDefaultsViewController ()

@end

@implementation ZYUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [EHFormTableView tableView];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    [self addRows];
}

- (void)addRows {
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addNormalRowWithName:@"OC" value:@"" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        ZYUserDefaultsExampleViewController *example = [[ZYUserDefaultsExampleViewController alloc] init];
        [weakSelf.navigationController pushViewController:example animated:YES];
    }];
    
    [self.tableView addNormalRowWithName:@"Swift" value:@"" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        SwiftExampleViewController *example = [[SwiftExampleViewController alloc] init];
        [weakSelf.navigationController pushViewController:example animated:YES];
    }];
}
@end
