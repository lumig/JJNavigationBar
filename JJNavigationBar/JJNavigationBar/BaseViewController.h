//
//  BaseViewController.h
//  masnoryDemo
//
//  Created by luming on 2018/6/27.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JJNavigationBar.h"
@interface BaseViewController : UIViewController

/**
 自定义导航栏
 */
@property (nonatomic,strong) JJNavigationBar *navigationBar;

@property (nonatomic,strong) UIView *contentView;

//自定义返回按钮事件
- (void)goBack;

@end
