# ZYUserInfo
# 一.前言
正如标题所述, ZYUserInfo是一款个轻量化存储工具类, 它是对NSUserDefaults的封装, 可以方便的进行轻量化存储, 大大的提高了代码效率, 并且完全不依赖于第三方, 不使用私有API, 存储过程使用KVO进行属性监听.

# 二.使用方法

> 存储数据

```
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


2020-05-14 16:04:57.556639+0800 ZYUserInfo[12399:279481] <ZYUserInfo: 0x600003dbdf80> 
 {
  "marr" : [
    "123",
    "123",
    "1234"
  ],
  "index" : 1,
  "intA" : 2,
  "isLogin" : true,
  "dic" : {
    "name" : "张三",
    "age" : "16"
  },
  "haha" : "我是空的nil",
  "arr" : [
    "1",
    2,
    "3"
  ],
  "token" : "sjkldfjlksdjf",
  "number" : 3.04,
  "floatA" : 3.0099999904632568,
  "mdic" : {
    "name" : "mdic"
  },
  "longA" : 5,
  "doubleA" : 4.0300000000000002
}

```

> 清除数据

```
[x_info clean];
NSLog(@"%@", x_info);


2020-05-14 16:06:06.814419+0800 ZYUserInfo[12450:280566] <ZYUserInfo: 0x6000018cb480> 
 {
  "marr" : "我是空的nil",
  "index" : 0,
  "intA" : 0,
  "isLogin" : false,
  "dic" : "我是空的nil",
  "haha" : "我是空的nil",
  "arr" : "我是空的nil",
  "token" : "我是空的nil",
  "number" : 0,
  "floatA" : 0,
  "mdic" : "我是空的nil",
  "longA" : 0,
  "doubleA" : 0
}
```

# 三.注意事项

> 宏变量并不支持打印

当我们使用宏变量来打印的时候可能出现下面的情况

```
(lldb) po x_info
error: <user expression 7>:1:1: use of undeclared identifier 'x_info'
x_info
^
```

所以我们直接使用`ZYUserInfo`类进行打印, 就可以达到我们预期的效果了, 宏变量只是为了使用方便简化代码

```
(lldb) po ZYUserInfo.shareInstance
<ZYUserInfo: 0x60000149d3b0> 
 {
  "marr" : [
    "123",
    "123",
    "1234"
  ],
  "index" : 1,
  "intA" : 2,
  "isLogin" : true,
  "dic" : {
    "name" : "张三",
    "age" : "16"
  },
  "haha" : "我是空的nil",
  "arr" : [
    "1",
    2,
    "3"
  ],
  "token" : "sjkldfjlksdjf",
  "number" : 3.04,
  "floatA" : 3.0099999904632568,
  "mdic" : {
    "name" : "mdic"
  },
  "longA" : 5,
  "doubleA" : 4.0300000000000002
}
```

