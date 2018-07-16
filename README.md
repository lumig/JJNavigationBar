# JJNavigationBar
自定义导航栏

由于业务需求，我们经常遇到要对导航栏进行一些操作，如果用系统导航栏的话，就可能会遇到，有的业务模块需要导航栏，有的不需要，这时候在push页面时，会遇到顶部导航栏位置在侧滑返回，返回等操作的时候会有导航栏高度的黑边，为了更好的用户体验，可以考虑隐藏系统导航栏的方式，自定义解决，这是一种简单的解决方式。

隐藏导航栏导致另一个问题,布局向下偏移了20px
解决隐藏导航栏
但这个scroll的轮播图却依然在状态栏以下，并没有将状态栏覆盖。因为状态栏存在，即使隐藏了导航栏，scroll依然会给我们预留部分空白，所有内容向下偏移20px像素位置，当你滑动scroll时，又会将状态栏覆盖掉。此时我们需要设置：
self.automaticallyAdjustsScrollViewInsets =NO;

建议建立一个BaseViewController 方便复用

使用代码如下：
```
_navigationBar = [[JJNavigationBar alloc] init];
[self.view addSubview:_navigationBar];
```
