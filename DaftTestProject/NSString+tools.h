//
//  NSString+tools.h
//  DaftTestProject
//
//  Created by daiyuzhang on 29/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (tools)
+(NSString *)convertToJson:(NSObject *)obj;
-(BOOL)isContainKeyword:(NSString *)keyword;

@end
