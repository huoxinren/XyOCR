//
//  CheckViewController.m
//  OCRTest
//
//  Created by xyz on 2016/12/13.
//  Copyright © 2016年 xyz. All rights reserved.
//

#import "CheckViewController.h"

#import "CertificateDefine.h"

#import "NSString+Trim.h"

#define kMaxLengthCardNo    25
#define kMaxLengthCardIDNo  21

@interface CheckViewController ()<UITextFieldDelegate, UIScrollViewDelegate>

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self adjustView];
}

- (void)adjustView
{
    if (self.pageType == 0)//身份证
    {
        [self  setTitle:@"确认身份证号"];
    }
    else
    {
        [self  setTitle:@"确认卡号"];
    }
    [self  setLeftBarButtonHidden:NO];
    [self  setRightBarbuttonHidden:YES];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255/255.0]];
    
    UIScrollView *scrollViewBG = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    [scrollViewBG setTag:-100];
    [scrollViewBG setDelegate:self];
    [scrollViewBG setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255/255.0]];
    [self.view addSubview:scrollViewBG];
    
    UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [viewBG setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:255/255.0]];
    [scrollViewBG addSubview:viewBG];
    
    [scrollViewBG setContentSize:CGSizeMake(0, kScreenHeight+20)];
    
    //请核对信息，确认无误
    UILabel *lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 15)];
    [lableTitle setBackgroundColor:[UIColor clearColor]];
    [lableTitle setTextAlignment:NSTextAlignmentCenter];
    [lableTitle setNumberOfLines:1];
    if (self.pageType == 0)//身份证
    {
        [lableTitle setText:@"请核对身份证号，确认无误"];
    }
    else
    {
        [lableTitle setText:@"请核对银行卡号，确认无误"];
    }
    [lableTitle setFont:[UIFont systemFontOfSize:14.0f]];
    [lableTitle setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:255/255.0]];
    [viewBG addSubview:lableTitle];
    
    //取数据先
    NSString *cardNo;
    NSString *username;
    NSString *imagePath;
    
    NSDictionary *myDictionary;
    
    if (self.pageType == 0)//身份证
    {
        //公民身份号码  IDCardImagePath
        //读取字典类型NSDictionary类型的数据
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        myDictionary = [userDefaultes dictionaryForKey:@"dictionaryCertificateInfo"];
        
        cardNo = [myDictionary valueForKey:@"公民身份号码"];
        imagePath = [myDictionary valueForKey:@"IDCardImagePath"];//IDCardHeadImagePath //IDCardImagePath
        username = [myDictionary valueForKey:@"姓名"];
    }
    else
    {
        //读取字典类型NSDictionary类型的数据
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        myDictionary = [userDefaultes dictionaryForKey:@"dictionaryBankInfo"];
        
        cardNo = [myDictionary valueForKey:@"cardNumber"];
        imagePath = [myDictionary valueForKey:@"BankCardImagePath"];
    }

    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setTag:-99];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [viewBG addSubview:imageView];
    
    if (self.pageType == 0)//身份证
    {
        [imageView setFrame:CGRectMake(28, 56, kScreenWidth-56, (kScreenWidth-56)*0.63)];
    }
    else
    {
        [imageView setFrame:CGRectMake(15, 56, kScreenWidth-30, 78)];
    }
    
    self.arrayCardInfo = [self getArrayFromString:cardNo];
    
    //如果显示姓名的话
    if (self.bIfShowUserName)
    {
        UIView *viewName = [[UIView alloc]init];
        viewName.translatesAutoresizingMaskIntoConstraints = NO;
        [viewName setBackgroundColor:[UIColor whiteColor]];
        [viewBG addSubview:viewName];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewName
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewBG
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0f
                                                            constant:15.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewName
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:imageView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:25.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewName
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:(kScreenWidth-30)]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewName
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:52.0f]];
        
        UITextField *textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [textField setTag:-2000];
        [textField setBackgroundColor:[UIColor clearColor]];
        [textField setTextColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:255/255.0]];
        [textField setFont:[UIFont systemFontOfSize:20.0f]];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.keyboardType = UIKeyboardTypeNamePhonePad;
        textField.text = username;
        textField.delegate = self;
        [viewBG addSubview:textField];
        
        if (self.bIfCheckViewNoEdit)//禁止编辑
        {
            [textField setEnabled:NO];
        }
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0f
                                                            constant:30.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        //前面竖线
        UIView *viewLeftVerticalLine = [[UIView alloc]init];
        viewLeftVerticalLine.translatesAutoresizingMaskIntoConstraints = NO;
        [viewLeftVerticalLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:255/255.0]];
        [viewBG addSubview:viewLeftVerticalLine];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:1.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:8.0f]];
        
        //后面竖线
        UIView *viewRightVerticalLine = [[UIView alloc]init];
        viewRightVerticalLine.translatesAutoresizingMaskIntoConstraints = NO;
        [viewRightVerticalLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:255/255.0]];
        [viewBG addSubview:viewRightVerticalLine];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:1.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:8.0f]];

        //横线
        UIView *viewBottomLine = [[UIView alloc]init];
        viewBottomLine.translatesAutoresizingMaskIntoConstraints = NO;
        [viewBottomLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:255/255.0]];
        [viewBG addSubview:viewBottomLine];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewName
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0f
                                                            constant:1.0f]];
        
    }
    
    UIView *viewField = [[UIView alloc]init];
    viewField.translatesAutoresizingMaskIntoConstraints = NO;
    [viewField setBackgroundColor:[UIColor whiteColor]];
    [viewBG addSubview:viewField];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewField
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:viewBG
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0f
                                                        constant:15.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewField
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:imageView
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0f
                                                        constant:self.bIfShowUserName?90.0f:25.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewField
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0f
                                                        constant:(kScreenWidth-30)]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewField
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0f
                                                        constant:52.0f]];
    
    self.arrayLenCardInfo = [self getArrayLenRateFromArrayCardInfo];

    float fTotleWidth = 0;
    
    for (int i=0; i<[self.arrayCardInfo count]; i++)
    {
        UITextField *textField = [[UITextField alloc]init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [textField setTag:-1000-i];
        [textField setBackgroundColor:[UIColor clearColor]];
        [textField setTextColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:255/255.0]];
        [textField setFont:[UIFont systemFontOfSize:20.0f]];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.textAlignment = NSTextAlignmentCenter;
        if (self.pageType == 0)//身份证
        {
            textField.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        else
        {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        textField.text = self.arrayCardInfo[i];
        textField.delegate = self;
        [viewBG addSubview:textField];
        
        if (self.bIfCheckViewNoEdit)//禁止编辑
        {
            [textField setEnabled:NO];
        }
        
        float fWidth = (kScreenWidth-30)*[self.arrayLenCardInfo[i] floatValue];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewField
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0f
                                                            constant:fTotleWidth]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:viewField
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:fWidth]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:52.0f]];
        
        fTotleWidth = fTotleWidth + fWidth;
        
        //前面竖线
        UIView *viewLeftVerticalLine = [[UIView alloc]init];
        viewLeftVerticalLine.translatesAutoresizingMaskIntoConstraints = NO;
        [viewLeftVerticalLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:255/255.0]];
        [viewBG addSubview:viewLeftVerticalLine];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:textField
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:textField
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:1.0f]];
        
        [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewLeftVerticalLine
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0f
                                                            constant:8.0f]];
    }
    
    //最后一个竖线
    UIView *viewRightVerticalLine = [[UIView alloc]init];
    viewRightVerticalLine.translatesAutoresizingMaskIntoConstraints = NO;
    [viewRightVerticalLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:255/255.0]];
    [viewBG addSubview:viewRightVerticalLine];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:viewField
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0f
                                                                  constant:0.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:viewField
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0f
                                                        constant:0.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0f
                                                        constant:1.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewRightVerticalLine
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0f
                                                        constant:8.0f]];
    
    
    //横线
    UIView *viewBottomLine = [[UIView alloc]init];
    viewBottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [viewBottomLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:255/255.0]];
    [viewBG addSubview:viewBottomLine];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:viewField
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0f
                                                                  constant:0.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:viewField
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0f
                                                        constant:0.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:viewField
                                                       attribute:NSLayoutAttributeWidth
                                                      multiplier:1.0f
                                                        constant:0.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:viewBottomLine
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeHeight
                                                      multiplier:1.0f
                                                        constant:1.0f]];
    
    
    UIButton *buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonNext.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonNext setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:50.0/255.0 blue:60.0/255.0 alpha:255/255.0]];
    [buttonNext setTitle:@"下一步" forState:UIControlStateNormal];
    [buttonNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonNext.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [buttonNext addTarget:self action:@selector(buttonNextMethod:) forControlEvents:UIControlEventTouchUpInside];
    [viewBG addSubview:buttonNext];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:buttonNext
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewBG
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0f
                                                           constant:15.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:buttonNext
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:40.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:buttonNext
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewBG
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0f
                                                           constant:-15.0f]];
    
    [viewBG addConstraint:[NSLayoutConstraint constraintWithItem:buttonNext
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0f
                                                        constant:42.0f]];

    buttonNext.layer.cornerRadius = 2.0;
}

- (void)buttonNextMethod:(UIButton *)sender
{
    if (![self makeUpCardNumber])
    {
        //提示身份证有误
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"身份证信息有误，请检查"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        return;
    }
    
    //返回
    if (self.pageType == 0)//身份证
    {
        int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
        
        NSLog(@"1页面层级index:[%d] [%u]", index, (int)[[self.navigationController viewControllers] count]);

        if ([self getJumpPageMyDoStatus])
        {
            NSLog(@"1发送通知...通知跳自定义页面");
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationJumpPageMyDo object:nil];
            
            NSLog(@"2发送通知...通知移除相关页面");
            
            //[[NSNotificationCenter defaultCenter] postNotificationName:NotificationRemoveOCRMainView object:nil];
            
            return;
        }
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
        
        NSLog(@"1发送通知...通知已取得信息");
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetIDInfo object:nil];
        
        NSLog(@"2发送通知...通知移除相关页面");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRemoveOCRMainView object:nil];
    }
    else
    {
        int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetBankInfo object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRemoveOCRMainView object:nil];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //往下滑
    if (scrollView.contentOffset.y < 0)
    {
        for (int i=0; i<[self.arrayCardInfo count]; i++)
        {
            UITextField *textField = (UITextField *)[self.view viewWithTag:-1000-i];
            [textField resignFirstResponder];
        }
        
        if (scrollView.contentOffset.y > 0)
        {
            [scrollView setContentSize:CGSizeMake(0, kScreenHeight)];
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
}

#pragma mark - textField delegate -

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIScrollView *viewBG = (UIScrollView *)[self.view viewWithTag:-100];
    
    [viewBG setContentSize:CGSizeMake(0, kScreenHeight+150)];
    
    NSLog(@"1 viewBG.contentOffset.y[%f]...", viewBG.contentOffset.y);
    
    if (viewBG.contentOffset.y == 0)
    {
        [viewBG setContentOffset:CGPointMake(0, 150) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UIScrollView *viewBG = (UIScrollView *)[self.view viewWithTag:-100];
    
    NSLog(@"2 viewBG.contentOffset.y[%f]...", viewBG.contentOffset.y);
    
    if (viewBG.contentOffset.y > 0)
    {
        [viewBG setContentSize:CGSizeMake(0, kScreenHeight)];
        [viewBG setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    //如果显示姓名且可编辑，重新保存姓名
    if ((self.pageType == 0) && (self.bIfShowUserName) && (!self.bIfCheckViewNoEdit))
    {
        [self saveUserName];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"textField: [%@]...", textField.text);
}

- (NSArray *)getArrayLenRateFromArrayCardInfo
{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:5];
    
    NSUInteger nTotleLen = 0;
    
    for (int i=0; i<[self.arrayCardInfo count]; i++)
    {
        nTotleLen = nTotleLen + [self.arrayCardInfo[i] length];
    }
    
    for (int i=0; i<[self.arrayCardInfo count]; i++)
    {
        NSUInteger nLen = [self.arrayCardInfo[i] length];
        
        float fLenRate = (float)nLen/(float)nTotleLen;
        
        NSString *lenRate = [NSString stringWithFormat:@"%.03f", fLenRate];
        
        [arrayTemp addObject:lenRate];
    }
    
    NSArray *arrayLenRate = [NSArray arrayWithArray:arrayTemp];
    
    return arrayLenRate;
}

- (NSArray *)getArrayFromString:(NSString *)stringInput
{
    if (self.pageType == 0)//身份证
    {
        if ([stringInput length] > 0)
        {
            NSString * string1 = [stringInput substringWithRange:NSMakeRange(0, 6)];
            NSString * string2 = [stringInput substringWithRange:NSMakeRange(6, 4)];
            NSString * string3 = [stringInput substringWithRange:NSMakeRange(10, 4)];
            NSString * string4 = [stringInput substringWithRange:NSMakeRange(14, 4)];
            
            NSArray *arrayTagsTemp = [[NSArray alloc]initWithObjects:string1, string2, string3, string4, nil];
            
            return arrayTagsTemp;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        if ([stringInput length] > 0)
        {
            NSString * newString;
            
            //去掉多余空格
            newString = [NSString trimWhitespaceNoContinuous:stringInput];
            
            NSArray *arrayTagsTemp = [newString componentsSeparatedByString:@" "];
            
            return arrayTagsTemp;
        }
        else
        {
            return nil;
        }
    }
}

- (BOOL)saveUserName
{
    if (self.pageType != 0)
    {
        return NO;
    }
    
    NSString *allResult = @"";
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:-2000];
    
    allResult = textField.text;
    
    NSLog(@"最终的姓名:[%@]...", allResult);
    
    if ([allResult length] < 1) //姓名
    {
        return NO;
    }
    
    NSDictionary *myDictionary;
    
    //公民身份姓名
    //读取字典类型NSDictionary类型的数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    myDictionary = [userDefaults dictionaryForKey:@"dictionaryCertificateInfo"];
    
    NSMutableDictionary *myDictionaryNew = [NSMutableDictionary dictionaryWithDictionary:myDictionary];
    [myDictionaryNew setObject:allResult forKey:@"姓名"];
    
    //保存字典
    [userDefaults setObject:myDictionaryNew forKey:@"dictionaryCertificateInfo"];
    [userDefaults synchronize];
    
    return YES;
}

//组装卡号等
- (BOOL)makeUpCardNumber
{
    NSString *allResult = @"";
    
    for (int i=0; i<[self.arrayCardInfo count]; i++)
    {
        UITextField *textField = (UITextField *)[self.view viewWithTag:-1000-i];
        
        allResult = [allResult stringByAppendingString:[NSString stringWithFormat:@"%@", textField.text]];
    }
    
    NSLog(@"组合后的身份证/银行卡结果:[%@]...", allResult);
    
    if ((self.pageType == 0) && ([allResult length] != 18)) //身份证
    {
        return NO;
    }
    
    NSDictionary *myDictionary;
    
    if (self.pageType == 0)//身份证
    {
        //公民身份号码  IDCardImagePath
        //读取字典类型NSDictionary类型的数据
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        myDictionary = [userDefaults dictionaryForKey:@"dictionaryCertificateInfo"];
        
        NSMutableDictionary *myDictionaryNew = [NSMutableDictionary dictionaryWithDictionary:myDictionary];
        [myDictionaryNew setObject:allResult forKey:@"公民身份号码"];
        
        //保存字典
        [userDefaults setObject:myDictionaryNew forKey:@"dictionaryCertificateInfo"];
        [userDefaults synchronize];
    }
    else
    {
        //读取字典类型NSDictionary类型的数据
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        myDictionary = [userDefaults dictionaryForKey:@"dictionaryBankInfo"];
        
        NSMutableDictionary *myDictionaryNew = [NSMutableDictionary dictionaryWithDictionary:myDictionary];
        [myDictionaryNew setObject:allResult forKey:@"cardNumber"];
        
        //保存字典
        [userDefaults setObject:myDictionaryNew forKey:@"dictionaryBankInfo"];
        [userDefaults synchronize];
    }
    
    return YES;
}

- (BOOL)getJumpPageMyDoStatus
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:PlistJumpPageMyDoStatus] isEqualToString:@"YES"])
    {
        [userDefaults setObject:nil forKey:PlistJumpPageMyDoStatus];
        
        return YES;
    }
    
    return NO;
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
