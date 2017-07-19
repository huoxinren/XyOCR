//
//  CertificateDefine.h
//
//
//  Created by xyz on 16/11/11.
//  Copyright (c) 2015年 xyz. All rights reserved.
//

#ifndef CertificateDefine_h
#define CertificateDefine_h

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define     NotificationGetIDInfo   @"NotificationGetIDInfo"                    //通知 取得2代身份证信息

#define     NotificationGetBankInfo   @"NotificationGetBankInfo"                //通知 取得银行卡信息

#define     NotificationRemoveOCRMainView   @"NotificationRemoveOCRMainView"    //通知 check页面后返回主界面后 移除

#define     NotificationJumpPageMyDo   @"NotificationJumpPageMyDo"              //通知 check页面后自定义跳转其它页面

#define     PlistJumpPageMyDoStatus   @"PlistJumpPageMyDoStatus"                //保存是否跳转自定义页面

#endif
