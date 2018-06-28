//
//  BaseViewController.m
//  masnoryDemo
//
//  Created by luming on 2018/6/27.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseView];
}

- (void)initBaseView
{
    self.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.translucent = NO;
    /**
     解决隐藏导航栏
     但这个scroll的轮播图却依然在状态栏以下，并没有将状态栏覆盖。因为状态栏存在，即使隐藏了导航栏，scroll依然会给我们预留部分空白，所有内容向下偏移20px像素位置，当你滑动scroll时，又会将状态栏覆盖掉。此时我们需要设置：
     self.automaticallyAdjustsScrollViewInsets =
     
     NO;
     **/
    self.automaticallyAdjustsScrollViewInsets = NO;

    //解决偏移问题
    if ([self.navigationController respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    处理侧滑返回的操作
    if (self.navigationController.viewControllers.count > 1 ) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    //添加导航栏
    _navigationBar = [[JJNavigationBar alloc] init];
    [self.view addSubview:_navigationBar];
    
        if (self.navigationController && self.navigationController.viewControllers.count > 1){
            [self.navigationBar.btnLeft setImage:[UIImage imageNamed:@"go_left"] forState:UIControlStateNormal];
            [self.navigationBar.btnLeft addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];

        }
    
    self.contentView = [[UIView alloc] init];
    self.contentView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    [self.view addSubview:self.contentView];
}


- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
