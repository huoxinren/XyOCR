//
//  BaseViewController.h
//
//
//
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MBProgressHUD/MBProgressHUD.h>

@interface BaseViewController : UIViewController
{
    UIImageView  *_navigationBar;
    UIButton     *_rightBarButton;
    UIButton     *_leftBarButton;
    UIView       *_bottomLine;

    //MBProgressHUD  *_HUD;
}

/**
 *  导航栏标题
 */
@property (nonatomic, copy)   NSString  *navTitle;

/**
 *  导航栏标题
 */
@property (nonatomic, strong) UILabel   *titleLabel;

/// 导航栏下面的灰色线条
@property (nonatomic, weak) UIView *grayLine;


// 设置自定义导航栏
- (void)setNavigationBarWithTintColor:(UIColor *)tintColor;
- (void)setNavigationBarWithBackgroundImage:(NSString *)imageName;
- (void)setNavigationBarWithTintColor:(UIColor *)tintColor bottomLineColor:(UIColor *)lineColor;

// 设置导航栏的隐藏与显示
- (void)setNavigationBarhidden:(BOOL)hidden;

// 设置Title
- (void)setTitle:(NSString *)title;
- (void)setTitle:(NSString *)title  withTitleColor:(UIColor *)titleColor;

// 设置leftBarButton
- (void)setLeftBarButtonWithTitle:(NSString *)title;
- (void)setLeftBarButtonWithImage:(NSString *)imageName;

// 设置rightBarButton
- (void)setRightBarButtonWithTitle:(NSString *)title;
- (void)setRightBarButtonWithImage:(NSString *)imageName;

// 设置导航栏左右按钮的显示与隐藏
- (void)setLeftBarButtonHidden:(BOOL)hidden;
- (void)setRightBarbuttonHidden:(BOOL)hidden;

// 设置导航栏下划线的显示与隐藏
- (void)setBottomLineHidden:(BOOL)hidden;

// leftBarButton绑定的方法
- (void)leftBarButtonPressed:(UIButton *)sender;

// rightBarButton绑定的方法
- (void)rightBarButtonPressed:(UIButton *)sender;

// 删除本地首页，付款界面的文件
- (void)removePaymentFile;

// 弹框设置
- (void)showAlertViewWithTag:(int)tag message:(NSString *)message;

// 显示Loading
//- (void)showHud:(NSString *)text;

// 隐藏Loading
//- (void)hideHud;

// 显示提示内容后自动消失
//- (void)appearHUDAndHid:(NSString *)errMessage;

/**
 *  登录超时弹框 强制退出需要重写此方法
 */
- (void)forceLoginOutAboutAlert;


@end
