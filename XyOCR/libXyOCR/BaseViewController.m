//
//  BaseViewController.m
//
//
//
//  Copyright © 2016年 Lefu. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"

#import "CertificateDefine.h"

@interface BaseViewController ()//<MBProgressHUDDelegate>
@property (nonatomic, strong) UIView *backViewHUD;

@end

@implementation BaseViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super  initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    
    return self;
    
}

- (void)dealloc
{
    //[self hideHud];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.titleLabel.text = self.navTitle;

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor  whiteColor];
    
    // 加载导航栏
    [self  setNavigationBarWithTintColor:[UIColor whiteColor]];
    
    // 加载back按钮
    [self  setLeftBarButtonWithImage:@"icon_ocr_return_black.png"];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


#pragma mark -  设置自定义导航栏
- (void)setNavigationBarWithTintColor:(UIColor *)tintColor
{
    [self.view  addSubview:[self  navigationBar]];
    
    _navigationBar.backgroundColor = tintColor;
}

- (void)setNavigationBarWithBackgroundImage:(NSString *)imageName
{
    [self.view  addSubview:[self  navigationBar]];
    
    _navigationBar.image = [UIImage imageNamed:imageName];
    _navigationBar.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setNavigationBarWithTintColor:(UIColor *)tintColor bottomLineColor:(UIColor *)lineColor
{
    _navigationBar.backgroundColor = tintColor;
    _bottomLine.backgroundColor = lineColor;
    
}


//郭子川新加 不含黄色分割线设置自定义导航栏

#pragma mark - 设置导航栏的隐藏与显示
- (void)setNavigationBarhidden:(BOOL)hidden
{
    _navigationBar.hidden = hidden;
}

#pragma mark -  设置Title
- (void)setTitle:(NSString *)title
{
    self.navTitle = title;
    self.titleLabel.text = title;
}

- (void)setTitle:(NSString *)title  withTitleColor:(UIColor *)titleColor
{
    self.navTitle = title;
    self.titleLabel.text = title;
    self.titleLabel.textColor = titleColor;
}

#pragma mark -  设置leftBarButton
- (void)setLeftBarButtonWithTitle:(NSString *)title
{
    [_navigationBar  addSubview:[self  leftBarButton]];
    
    [_leftBarButton  setTitle:title forState:UIControlStateNormal];
    [_leftBarButton  addTarget:self action:@selector(leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setLeftBarButtonWithImage:(NSString *)imageName
{
    [_navigationBar  addSubview:[self  leftBarButton]];
    
    [_leftBarButton  setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_leftBarButton  addTarget:self action:@selector(leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 35);
}

#pragma mark -  设置rightBarButton
- (void)setRightBarButtonWithTitle:(NSString *)title
{
    [_navigationBar  addSubview:[self  rightBarButton]];
    
    [_rightBarButton  setTitle:title forState:UIControlStateNormal];
    [_rightBarButton  addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setRightBarButtonWithImage:(NSString *)imageName
{
    [_navigationBar  addSubview:[self  rightBarButton]];
    [_rightBarButton  setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_rightBarButton  addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _rightBarButton.imageEdgeInsets = UIEdgeInsetsMake(2, 35, 2, 15);
}

#pragma mark - 设置导航栏左右按钮的显示与隐藏
- (void)setLeftBarButtonHidden:(BOOL)hidden
{
    _leftBarButton.hidden = hidden;
}

- (void)setRightBarbuttonHidden:(BOOL)hidden
{
    _rightBarButton.hidden = hidden;
}

#pragma mark - 设置导航栏下划线的显示与隐藏
- (void)setBottomLineHidden:(BOOL)hidden
{
    if (hidden)
    {
        _bottomLine.alpha = 0.0f;
    }
    else
    {
        _bottomLine.alpha = 1.0f;
        _titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:255/255.0];
        [_leftBarButton  setImage:[UIImage imageNamed:@"icon_ocr_return_black.png"] forState:UIControlStateNormal];
    }
}

#pragma mark -  leftBarButton绑定的方法
- (void)leftBarButtonPressed:(UIButton *)sender
{
    // 默认为pop出栈操作
    [self.navigationController  popViewControllerAnimated:YES];
    
    // 如果需要自定义操作，子类去继承
}

#pragma mark -  rightBarButton绑定的方法
- (void)rightBarButtonPressed:(UIButton *)sender
{
    // 如果需要，子类去继承
}

#pragma mark - 删除本地首页，付款界面的文件
- (void)removePaymentFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *paymentViewPath = [path stringByAppendingString:@"/LefuTongPayment.txt"];
    if([[NSFileManager defaultManager] fileExistsAtPath:paymentViewPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:paymentViewPath error:nil];
    }
}
/*
#pragma mark -  显示Loading
- (void)showHud:(NSString *)text
{
    [self hideHud];

    if (!_HUD)
    {
        _HUD = [MBProgressHUD showHUDAddedTo:self.backViewHUD animated:YES];
        _HUD.delegate = self;
        [self.view addSubview:self.backViewHUD];
    }
    if (text) {
        _HUD.labelText = text;
    }else{
        _HUD.labelText = @"请稍等...";

    }
}

- (void)appearHUDAndHid:(NSString *)errMessage
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    MBProgressHUD *errHUD = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
    errHUD.mode = MBProgressHUDModeText;
    errHUD.labelText = errMessage;
    errHUD.opacity   = 0.4;
    [errHUD show:YES];
    
    [errHUD hide:YES afterDelay:1];
}

#pragma mark -  隐藏Loading
- (void)hideHud
{
    [_HUD  hide:YES];
    [_HUD removeFromSuperview];
    [self.backViewHUD removeFromSuperview];
    _HUD = nil;
}
 
 */

#pragma mark - 懒加载
- (UIImageView *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[UIImageView alloc] init];
        _navigationBar.frame = CGRectMake(0, 0, kScreenWidth, 64);
        _navigationBar.backgroundColor = [UIColor  blackColor];
        _navigationBar.userInteractionEnabled = YES;
        
        [_navigationBar  addSubview:self.titleLabel];
        [_navigationBar  addSubview:self.bottomLine];
    }
    
    return _navigationBar;
}

- (UIView *)backViewHUD
{
    if (!_backViewHUD) {
        _backViewHUD = [[UIView alloc] init];
        _backViewHUD.backgroundColor = [UIColor clearColor];
        _backViewHUD.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    }
    return _backViewHUD;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel  alloc] init];
        _titleLabel.frame = CGRectMake(60, 20, kScreenWidth-2*60, 44);
        _titleLabel.backgroundColor = [UIColor  clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:255/255.0];
        _titleLabel.font = [UIFont  fontWithName:@"STHeitiSC-Medium" size:18];
    }

    return _titleLabel;
}
 
- (UIButton *)leftBarButton
{
    if (!_leftBarButton) {
        _leftBarButton = [UIButton  buttonWithType:UIButtonTypeCustom];
        _leftBarButton.backgroundColor = [UIColor  clearColor];
        _leftBarButton.frame = CGRectMake(0, 20, 80, 44);
        [_leftBarButton  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    }
    
    return _leftBarButton;
}


- (UIButton *)rightBarButton
{
    if (!_rightBarButton) {
        _rightBarButton = [UIButton  buttonWithType:UIButtonTypeCustom];
        _rightBarButton.backgroundColor = [UIColor  clearColor];
        _rightBarButton.frame = CGRectMake(kScreenWidth-80, 20, 80, 44);
        [_rightBarButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightBarButton.titleLabel.font = [UIFont  boldSystemFontOfSize:17.f];
    }
    
    return _rightBarButton;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:255/255.0];
        _bottomLine.frame = CGRectMake(0, 63.5, kScreenWidth, 0.5);
        _bottomLine.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255/255.0];
    }
    
    return _bottomLine;
}


#pragma mark -  实现旋转的函数，默认只支持竖屏
- (BOOL)shouldAutorotate
{
    return  NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  (UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskPortrait);
}

#pragma mark - 跳转回到登录界面
- (void)forceLoginOutAboutAlert
{

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertViewWithTag:(int)tag message:(NSString *)message
{
    if (message.length < 3) return;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message
                         delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.tag = tag;
    [alert    show];
}


@end
