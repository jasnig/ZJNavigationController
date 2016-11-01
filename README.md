# ZJNavigationController
一个方便实现全屏滑动返回的navigationController, 同时实现了常用的每一个界面都拥有一个独立的navigationBar的功能.


![navigationController.gif](http://upload-images.jianshu.io/upload_images/1271831-30de4f99b3a187f7.gif?imageMogr2/auto-orient/strip)

```
    UIViewController *vc = [ViewController new];
    ZJNavigationController *navi = [[ZJNavigationController alloc] initWithRootViewController:vc];
    // 开启
    [navi zj_enableFullScreenPop:YES];
```