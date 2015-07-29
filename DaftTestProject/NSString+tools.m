//
//  NSString+tools.m
//  DaftTestProject
//
//  Created by daiyuzhang on 29/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "NSString+tools.h"

@implementation NSString (tools)
+(NSString *)convertToJson:(NSObject *)obj
{
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(BOOL)isContainKeyword:(NSString *)keyword
{
    return [self rangeOfString:keyword options:NSCaseInsensitiveSearch].length > 0;
}

@end
