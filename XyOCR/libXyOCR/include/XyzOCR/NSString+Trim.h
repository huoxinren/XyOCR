//
//  NSString+Trim.h
//  
//
//  Created by xyz on 14/11/3.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;

+ (NSString *)trimWhitespace:(NSString *)val;

+ (NSString *)trimNewline:(NSString *)val;

+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;

+ (NSString *)trimWhitespaceNoContinuous:(NSString *)val;

@end
