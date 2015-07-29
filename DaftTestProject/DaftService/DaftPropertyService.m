//
//  DaftPropertyService.m
//  DaftTestProject
//
//  Created by daiyuzhang on 29/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "DaftPropertyService.h"
#import "NSString+tools.h"

static const NSString *URL_PATH = @"https://api.daft.com/v2/json/";

@implementation DaftPropertyService
- (id)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:(NSString *)URL_PATH]];
    if (self) {
        
    }
    return self;
}

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSArray *array))success failure:(void (^)(NSError *))failure
{
    void (^onSuccess)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject){
        NSError *jsonParseError;
        if (responseObject) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonParseError];
            if (jsonParseError) {
                failure(jsonParseError);
            } else if (![jsonDict isKindOfClass:[NSDictionary class]]
                || !jsonDict[@"result"]
                || ![jsonDict[@"result"] isKindOfClass:[NSDictionary class]]
                || !jsonDict[@"result"][@"results"]
                || ![jsonDict[@"result"][@"results"] isKindOfClass:[NSDictionary class]]
                || !jsonDict[@"result"][@"results"][@"ads"]
                || ![jsonDict[@"result"][@"results"][@"ads"] isKindOfClass:[NSArray class]]) {
                failure([NSError errorWithDomain:(NSString *)URL_PATH code:-1 userInfo:@{@"error":@"data error!"}]);
            } else {
                success(jsonDict[@"result"][@"results"][@"ads"]);
            }
        }
    };
    
    void (^onFailure)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject){
        failure(responseObject);
    };
    
    [super getPath:path parameters:parameters success:onSuccess failure:onFailure];
}

@end
