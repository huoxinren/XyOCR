//
//  ViewController.m
//  XyOCR
//
//  Created by xyz on 2017/7/17.
//  Copyright © 2017年 xyz. All rights reserved.
//

#import "ViewController.h"

#import "CertificateHeader.h"

#import "Masonry.h"

#import "JumpPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationGetIDInfo object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationGetBankInfo object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationJumpPageMyDo object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //身份证
    UIButton *buttonID = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonID setBackgroundColor:[UIColor clearColor]];
    [buttonID setTitle:@"身份证2代识别" forState:UIControlStateNormal];
    [buttonID setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonID.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [buttonID addTarget:self action:@selector(buttonIDMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonID];
    
    [buttonID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(150);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    
    buttonID.layer.cornerRadius = 4.0;
    buttonID.layer.borderColor  = [UIColor blueColor].CGColor;
    buttonID.layer.borderWidth  = 0.5;
    
    //银行卡
    UIButton *buttonBankCard = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBankCard setBackgroundColor:[UIColor clearColor]];
    [buttonBankCard setTitle:@"银行卡识别" forState:UIControlStateNormal];
    [buttonBankCard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonBankCard.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [buttonBankCard addTarget:self action:@selector(buttonBankCardMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBankCard];
    
    [buttonBankCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.top.equalTo(buttonID.mas_bottom).with.offset(50);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    
    buttonBankCard.layer.cornerRadius = 4.0;
    buttonBankCard.layer.borderColor  = [UIColor blueColor].CGColor;
    buttonBankCard.layer.borderWidth  = 0.5;
    
    //增加通知--------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterGetIDInfo:) name:NotificationGetIDInfo object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterGetBankInfo:) name:NotificationGetBankInfo object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JumpPageMyDo) name:NotificationJumpPageMyDo object:nil];
    //增加通知---------
    
    //测试 image
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setTag:-99];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.top.equalTo(buttonBankCard.mas_bottom).with.offset(50);
        make.width.equalTo(@320);
        make.height.equalTo(@200);
    }];
}

- (void)buttonIDMethod:(UIButton *)sender
{
    OCRMainView *myOCRView = [[OCRMainView alloc]initViewWithCardType:OcrType_ID source:OcrSourceType_OnlyOcr ifHaveCheckPage:YES ifCheckViewNoEdit:NO ifShowUserName:YES];
    [myOCRView setBIfJumpPageMyDo:NO];
    [self.view addSubview:myOCRView];
    [myOCRView show];
}

- (void)buttonBankCardMethod:(UIButton *)sender
{
    OCRMainView *myOCRView = [[OCRMainView alloc]initViewWithCardType:OcrType_Bank ifHaveCheckPage:YES];
    [self.view addSubview:myOCRView];
    [myOCRView show];
}

- (void)afterGetIDInfo:(NSNotification*)notification
{
    NSLog(@"收到了二代身份证信息  通知......");
    
    NSString *result = (NSString *)[notification object];
    if ([result isEqualToString:@"NO"])
    {
        NSLog(@"收到了二代身份证信息  超时失败的通知......");
        
        return;
    }
    
    //读取字典类型NSDictionary类型的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userDefaultes dictionaryForKey:@"dictionaryCertificateInfo"];
    NSArray *keys = [myDictionary allKeys];
    NSArray *values = [myDictionary allValues];
    
    NSString *allResult = @"";
    
    for (int i=0; i<[keys count]; i++)
    {
        //NSLog(@"%@:%@", [keys objectAtIndex:i], [values objectAtIndex:i]);
        
        allResult = [allResult stringByAppendingString:[NSString stringWithFormat:@"%@:%@\n", [keys objectAtIndex:i],  [values objectAtIndex:i]]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"身份证信息"
                                                        message:allResult
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    
    //IDCardHeadImagePath  IDCardImagePath
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:-99];
    [imageView setImage:[UIImage imageWithContentsOfFile:[myDictionary valueForKey:@"IDCardImagePath"]]];
}

- (void)afterGetBankInfo:(NSNotification*)notification
{
    NSLog(@"收到了银行卡信息  通知......");
    
    NSString *result = (NSString *)[notification object];
    if ([result isEqualToString:@"NO"])
    {
        NSLog(@"收到了银行卡信息  超时失败的通知......");
        
        return;
    }
    
    //读取字典类型NSDictionary类型的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userDefaultes dictionaryForKey:@"dictionaryBankInfo"];
    NSArray *keys = [myDictionary allKeys];
    NSArray *values = [myDictionary allValues];
    
    NSString *allResult = @"";
    
    for (int i=0; i<[keys count]; i++)
    {
        NSLog(@"%@:%@", [keys objectAtIndex:i], [values objectAtIndex:i]);
        
        allResult = [allResult stringByAppendingString:[NSString stringWithFormat:@"%@:%@\n", [keys objectAtIndex:i],  [values objectAtIndex:i]]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"银行卡信息"
                                                        message:allResult
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    
    //BankCardImagePath
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:-99];
    [imageView setImage:[UIImage imageWithContentsOfFile:[myDictionary valueForKey:@"BigBankCardImagePath"]]];
}

- (void)JumpPageMyDo
{
    NSLog(@"跳一个自己定义的页面");
    
    JumpPageViewController *jumpPageViewController = [[JumpPageViewController alloc]init];
    [self.navigationController pushViewController:jumpPageViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface methods -

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskPortrait);
}


@end
