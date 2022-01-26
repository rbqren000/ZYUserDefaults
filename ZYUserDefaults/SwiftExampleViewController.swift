//
//  SwiftExampleViewController.swift
//  ZYUserDefaults
//
//  Created by objcat on 2022/1/26.
//  Copyright © 2022 objcat. All rights reserved.
//

import UIKit

let x_store: ExampleUserDefaults = ExampleUserDefaults.shareInstance()

class SwiftExampleViewController: ZYUserDefaultsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func addRows() {
        
        self.tableView.addNormalRow(withName: "标准值测试", value: "", cellClass: EHTapTableViewCell.self, rowHeight: 44) { model, eventType, dictionary in
            x_store.environment = .dev
            x_store.testString = "123"
            x_store.testNumber = 666
            x_store.testArray = ["1", "2", "3"]
            x_store.testMutableArray = ["1", "2", "3"]
            x_store.testDictionary = ["name": "张三", "age": "18"]
            x_store.testData = Data()
            x_store.testDate = Date()
            x_store.testTimeInterval = 1
            x_store.testInteger = 1
            x_store.testUInteger = 2
            x_store.testInt = 1
            x_store.testLong = 11
            x_store.testFloat = 0.2
            x_store.testDouble = 0.22
            x_store.testCGFloat = 0.222
            x_store.testBool = true
            x_store.testBoolean = true
            print(x_store)
        }
        
        self.tableView.addNormalRow(withName: "空值测试", value: "", cellClass: EHTapTableViewCell.self, rowHeight: 44) { model, eventType, dictionary in
            x_store.environment = .dev
            x_store.testString = nil
            x_store.testNumber = nil
            x_store.testArray = nil
            x_store.testMutableArray = nil
            x_store.testDictionary = nil
            x_store.testData = nil
            x_store.testDate = nil
            x_store.testTimeInterval = 1
            x_store.testInteger = 1
            x_store.testUInteger = 2
            x_store.testInt = 1
            x_store.testLong = 11
            x_store.testFloat = 0.2
            x_store.testDouble = 0.22
            x_store.testCGFloat = 0.222
            x_store.testBool = true
            x_store.testBoolean = true
            print(x_store)
        }
        
        self.tableView.addNormalRow(withName: "NSNull测试", value: "", cellClass: EHTapTableViewCell.self, rowHeight: 44) { model, eventType, dictionary in
            x_store.testString = NSNull() as? String
            // swift的设计就相当安全 当类型不同的时候 直接把值置为nil 其他的就不测试了
            print(x_store)
        }
        
        self.tableView.addNormalRow(withName: "清除数据", value: "", cellClass: EHTapTableViewCell.self, rowHeight: 44) { model, eventType, dictionary in
            x_store.clean()
            print(x_store)
        }
        
        self.tableView.addNormalRow(withName: "打印数据", value: "", cellClass: EHTapTableViewCell.self, rowHeight: 44) { model, eventType, dictionary in
            print(x_store)
        }
    }
}
