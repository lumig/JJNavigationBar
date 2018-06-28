//
//  UIView+JJNavigationBar.h
//  JJNavigationBar
//
//  Created by luming on 2018/6/27.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JJNavigationBar)
//获取当前view的VC
@property (readonly) UIViewController *currentViewController;
//用来保存一个操作
- (void)jj_bringToFrontBlock:(dispatch_block_t)block;
@end



@interface JJNavigationBar : UIView
/**
 * 左侧按钮
 */
@property(nonatomic,strong)UIButton * btnLeft;
/**
 * 右侧按钮
 */
@property(nonatomic,strong)UIButton * btnRight;
/**
 * 右侧按钮 备用
 */
@property(nonatomic,strong)UIButton * btnRightStandBy;
/**
 * 中间的view
 */
@property(nonatomic,strong)UIView * centerView;
/**
 * 标题的label
 */
@property(nonatomic,strong)UILabel * titleLabel;
/**
 * 背景
 */
@property(nonatomic,strong)UIView * backgroundView;

/**
 导航栏下边的线
 */
@property (nonatomic,strong) UIView *navLineView;

@end

