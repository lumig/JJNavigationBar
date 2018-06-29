//
//  UIView+JJNavigationBar.m
//  JJNavigationBar
//
//  Created by luming on 2018/6/27.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "UIView+JJNavigationBar.h"
#import <objc/runtime.h>
#import "Masonry.h"

#define NAV_HEIGHT 64
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation UIView (JJNavigationBar)

- (UIViewController *)currentViewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

+ (void)load{
    [self exchangeInstanceMethod1:@selector(didMoveToSuperview) method2:@selector(jj_didMoveToSuperview)];
}

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

- (void)jj_didMoveToSuperview{
    [self jj_didMoveToSuperview];
    dispatch_block_t block = objc_getAssociatedObject(self, @selector(jj_bringToFrontBlock:));
    block ? block() : nil;
}

- (void)jj_bringToFrontBlock:(dispatch_block_t)block{
    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end




/**
 自定义导航栏view
 */
@implementation JJNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT)]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor clearColor];
    
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.width.height.equalTo(self);
    }];
    
    _btnLeft = [[UIButton alloc] init];
    _btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_btnLeft setImage:[UIImage imageNamed:@"go_left"] forState:UIControlStateNormal];
    [_btnLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_btnLeft];
    [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(20);
        make.width.offset(40);
        make.height.offset(NAV_HEIGHT-20);
    }];
    
    _btnRight = [[UIButton alloc] init];
    _btnRight.titleLabel.font = [UIFont systemFontOfSize:14];
    _btnRight.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_btnRight];
    [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.centerY.equalTo(_btnLeft);
        make.width.offset(50);
        make.height.offset(NAV_HEIGHT-20);
    }];
    
    _centerView = [[UIView alloc] init];
    
    [self addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.centerX.equalTo(self);
        make.width.offset(SCREEN_WIDTH-120);
        make.height.offset(NAV_HEIGHT-20);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btnLeft);
        make.centerX.equalTo(_centerView);
    }];
    
    _btnRightStandBy = [[UIButton alloc] init];
    _btnRightStandBy.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btnRightStandBy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_btnRightStandBy];
    [_btnRightStandBy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_btnRight.mas_left).offset(-10);
        make.centerY.equalTo(_btnLeft);
    }];
    
    _navLineView = [[UIView alloc] init];
    _navLineView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self addSubview:_navLineView];
    [_navLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

#pragma mark - navbar添加到父试图时添加一个操作
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    if (!self.currentViewController.navigationController.navigationBarHidden) {
        self.currentViewController.navigationController.navigationBarHidden = YES;
    }
    __weak typeof(self) wself = self;
    [self.superview jj_bringToFrontBlock:^{
        __strong typeof(wself) sself = wself;
        [sself.superview bringSubviewToFront:wself];
    }];
}

@end


/**
 UIColor的一个类别，扩展hexColor
 */
@implementation UIColor (JJNav)
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end

