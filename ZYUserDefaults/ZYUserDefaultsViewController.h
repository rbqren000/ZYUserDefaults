//
//  ZYUserDefaultsViewController.h
//  ZYUserDefaults
//
//  Created by objcat on 2022/1/26.
//  Copyright © 2022 objcat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExampleUserDefaults.h"
#import "EHFormTableView.h"

@interface ZYUserDefaultsViewController : UIViewController
@property (strong, nonatomic) EHFormTableView *tableView;
- (void)addRows;
@end
