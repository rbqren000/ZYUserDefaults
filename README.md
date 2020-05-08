# ZYUserInfo
轻量化存储工具类
```
属于对NSUserDefaults的封装, 基于原生不依赖于任何第三方工具

使用方法

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
    
    
    
    2020-05-08 11:30:06.837521+0800 ZYUserInfo[6943:127762] <ZYUserInfo: 0x6000021a0fc0> 
 {
  "number" : 3.04,
  "haha" : "我是空的nil",
  "floatA" : 3.0099999904632568,
  "longA" : 5,
  "doubleA" : 4.0300000000000002,
  "arr" : [
    "1",
    2,
    "3"
  ],
  "dic" : {
    "name" : "张三",
    "age" : "16"
  },
  "token" : "sjkldfjlksdjf",
  "isLogin" : true,
  "intA" : 2,
  "index" : 1
}
2020-05-08 11:30:06.849944+0800 ZYUserInfo[6943:127762] 清理后:<ZYUserInfo: 0x6000021a0fc0> 
 {
  "number" : 0,
  "haha" : "我是空的nil",
  "floatA" : 0,
  "longA" : 0,
  "doubleA" : 0,
  "arr" : "我是空的nil",
  "dic" : "我是空的nil",
  "token" : "我是空的nil",
  "isLogin" : false,
  "intA" : 0,
  "index" : 0
} 
    
```
