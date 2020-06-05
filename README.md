# ZYUserDefaults
# 一.前言
正如标题所述, ZYUserDefaults是一款个轻量化存储工具类, 它是对NSUserDefaults的封装, 可以方便的进行轻量化存储, 大大的提高了代码效率, 并且完全不依赖于第三方, 不使用私有API, 存储过程使用KVO进行属性监听.

# 二.使用方法

> 存储数据

```
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


2020-06-05 11:12:11.325905+0800 ZYUserDefaults[6743:97412] <ZYUserDefaults: 0x600001f76d80> 
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
  "mdic" : "我是空的nil",
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

## 宏变量并不支持po

当我们使用宏变量来打印的时候可能出现下面的情况

```
(lldb) po x_store
error: <user expression 7>:1:1: use of undeclared identifier 'x_store'
x_info
^
```

所以我们直接使用`ZYUserDefaults`类进行打印, 就可以达到我们预期的效果了, 宏变量只是为了使用方便简化代码

```
(lldb) po ZYUserDefaults.shareInstance
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

## 关于精度丢失的问题

```
打印出的数据缺失存在精度丢失问题, 不过不用担心, 这只是系统工具在进行数字转换的时候造成的, 实际上正常使用NSNumber是不会造成数字精度丢失问题的
```

