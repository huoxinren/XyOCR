//
//  CheckViewController.h
//  OCRTest
//
//  Created by xyz on 2016/12/13.
//  Copyright © 2016年 xyz. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckViewController : BaseViewController

@property(nonatomic, assign) int  pageType; //确认什么的号码 0 身份证  1 卡号

@property(nonatomic, assign) BOOL  bIfCheckViewNoEdit; //是否禁止编辑

@property(nonatomic, assign) BOOL  bIfShowUserName;     //是否显示名字

@property(nonatomic, strong) NSArray *arrayCardInfo;    //保存截取的身份号/银行卡号

@property(nonatomic, strong) NSArray *arrayLenCardInfo; //保存截取的身份号/银行卡号长度

@end
