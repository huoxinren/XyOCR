//
//  OCRMainView.h
//
//
//  Created by xyz on 16/11/11.
//  Copyright © 2016年 xyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCRMainViewDelegate <NSObject>

@optional

//chooseType: 0-选择扫描  1-选择相册，目前选择相册未用
- (void)clickChooseView:(int)chooseType;

//身份证扫描返回
- (void)afterGetIDInfoWithError:(NSString *)error;

//银行卡扫描返回
- (void)afterGetBankInfoWithError:(NSString *)error;


@end

@interface OCRMainView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic, weak)id<OCRMainViewDelegate> delegate;

@property (strong, nonatomic) NSString *devCode;

@property (assign, nonatomic) int source;

@property (assign, nonatomic) BOOL bIfHaveCheckPage;

@property(nonatomic, assign) BOOL  bIfCheckViewNoEdit;  //是否禁止编辑

@property(nonatomic, assign) BOOL  bIfShowUserName;     //是否显示名字

@property(nonatomic, assign) BOOL  bIfJumpPageMyDo;     //是否识别后跳入自定义页面

@property (strong, nonatomic) NSMutableDictionary *dictionaryCertificateInfo;   //保存扫描的信息用

// type 0-二代身份证 1-银行卡 ifHaveCheckPage
- (id)initViewWithCardType:(int)type ifHaveCheckPage:(BOOL)ifHaveCheckPage;

// type 0-二代身份证 1-银行卡 ifHaveCheckPage
- (id)initViewWithCardType:(int)type ifHaveCheckPage:(BOOL)ifHaveCheckPage ifCheckViewNoEdit:(BOOL)ifCheckViewNoEdit;

// type 0-二代身份证 1-银行卡   仅对二代身份证有效 source 0-扫描、选取照片  1-扫描
- (id)initViewWithCardType:(int)type source:(int)source ifHaveCheckPage:(BOOL)ifHaveCheckPage;

// type 0-二代身份证 1-银行卡   仅对二代身份证有效 source 0-扫描、选取照片  1-扫描 ifCheckViewNoEdit 是否禁止编辑
- (id)initViewWithCardType:(int)type source:(int)source ifHaveCheckPage:(BOOL)ifHaveCheckPage ifCheckViewNoEdit:(BOOL)ifCheckViewNoEdit;

// type 0-二代身份证 1-银行卡   仅对二代身份证有效 source 0-扫描、选取照片  1-扫描 ifCheckViewNoEdit 是否禁止编辑   ifShowUserName 是否显示名字
- (id)initViewWithCardType:(int)type source:(int)source ifHaveCheckPage:(BOOL)ifHaveCheckPage ifCheckViewNoEdit:(BOOL)ifCheckViewNoEdit ifShowUserName:(BOOL)ifShowUserName;

- (void)show;

- (void)remove;

@end
