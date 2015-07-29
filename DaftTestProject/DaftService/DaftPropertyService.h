//
//  DaftPropertyService.h
//  DaftTestProject
//
//  Created by daiyuzhang on 29/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
static const NSString *API_KEY = @"7d44326a4d8144112daae2ba8138409a87d6dd10";

@interface DaftPropertyService : AFHTTPClient
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSArray *array))success failure:(void (^)(NSError *))failure;

@end
