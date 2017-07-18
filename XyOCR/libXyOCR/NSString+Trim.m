//
//  NSString+Trim.m
//
//
//  Created by xyz on 14/11/3.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet {
    NSString *returnVal = @"";
    if (val) {
        returnVal = [val stringByTrimmingCharactersInSet:characterSet];
    }
    return returnVal;
}

+ (NSString *)trimWhitespace:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉前后空格
}

+ (NSString *)trimNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]]; //去掉前后回车符
}

+ (NSString *)trimWhitespaceAndNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去掉前后空格和回车符
}

+ (NSString *)trimWhitespaceNoContinuous:(NSString *)val {
    
    val = [NSString trimWhitespaceAndNewline:val];
    
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@" {1,}"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
    val = [regular stringByReplacingMatchesInString:val options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, [val length]) withTemplate:@" "];
    
    NSLog(@"处理后得到的字符串：[%@]", val);
    
    return val;
}

@end
