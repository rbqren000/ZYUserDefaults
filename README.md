# ZYUserDefaults
# 一.前言
正如标题所述, ZYUserDefaults是一款个轻量化存储工具类, 它是对NSUserDefaults的封装, 可以方便的进行轻量化存储, 大大的提高了代码效率, 并且完全不依赖于第三方, 不使用私有API, 存储过程使用KVO进行属性监听.

# 二.使用方法

## OC

> 存储数据

```
x_store.environment = ZYEnvironmentDev;
x_store.testString = @"123";
x_store.testNumber = @(666);
x_store.testArray = @[@"1", @"2", @"3"];
x_store.testMutableArray = x_store.testArray.mutableCopy;
x_store.testDictionary = @{@"name": @"张三", @"age": @"18"};
x_store.testMutableDictionary = x_store.testDictionary.mutableCopy;
x_store.testData = [[NSData alloc] init];
x_store.testMutableData = [[NSMutableData alloc] init];
x_store.testDate = NSDate.date;
x_store.testTimeInterval = 1;
x_store.testInteger = 1;
x_store.testUInteger = 2;
x_store.testInt = 1;
x_store.testLong = 11;
x_store.testFloat = 0.2;
x_store.testDouble = 0.22;
x_store.testCGFloat = 0.222;
x_store.testBool = YES;
x_store.testBoolean = true;
NSLog(@"%@", x_store);
```

> 清除数据

```
x_store.clean;
NSLog(@"%@", x_store);
```

## Swift

> 存储数据

```
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
```

> 清除数据

```
x_store.clean()
print(x_store)
```

