//
//  CertificateInfo.h
//
//
//  Created by xyz on 16/11/11.
//  Copyright (c) 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertificateInfo : NSObject

//证件名称
@property (strong, nonatomic) NSString *typeName;
//证件代码
@property (assign, nonatomic) int typeCode;
//字段个数
@property (assign, nonatomic) int count;

@property (strong, nonatomic) NSMutableDictionary *MyCertificateInfo;

//签发机关:上海市公安局黄浦分局
//有效期限:20090515-20290515
//签发日期:2009-05-15
//有效期至:2029-05-15
//姓名:
//性别:男
//民族:汉
//出生:
//住址:
//公民身份号码:

@end
