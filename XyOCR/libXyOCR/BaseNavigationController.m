//
//  BaseNavigationController.m
//
//
//
//  Copyright © 2016年 Lefu. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    self.toolbarHidden = YES;
    
    //////////////////设置侧滑返回///////////////////////
    self.delegate = self;
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    ///////////////////////////////////////////////////
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // fix 'nested pop animation can result in corrupted navigation bar'
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super  viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super  viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super  viewDidDisappear:animated];
}

// 实现旋转的函数，默认只支持竖屏
#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
- (BOOL)shouldAutorotate
{
    return  YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return  (UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskPortrait);
}

#else

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return  (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

#endif


@end
