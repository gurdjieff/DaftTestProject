//
//  DaftPropertiesServiceTestCase.m
//  DaftTestProject
//
//  Created by daiyuzhang on 29/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DaftPropertyService.h"
#import "NSString+tools.h"

@interface DaftPropertiesServiceTestCase : XCTestCase
{
    DaftPropertyService *_service;
}
@end

@implementation DaftPropertiesServiceTestCase

- (void)setUp {
    [super setUp];
    _service = [[DaftPropertyService alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testRetriveData
{
    NSString *path = @"search_sale";
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:API_KEY forKey:@"api_key"];
    [parameters setObject:@{@"perpage":@50} forKey:@"query"];
    NSString *parametersJSON = [NSString convertToJson:parameters];
    
    [parameters removeAllObjects];
    [parameters setObject:parametersJSON forKey:@"parameters"];
    
    __block NSInteger statusCode;

    void (^onSuccess)(NSArray *responsedData) = ^(NSArray *responsedData) {
        statusCode = 200;
        CFRunLoopRef runloopref = CFRunLoopGetCurrent();
        CFRunLoopStop(runloopref);
    };
    
    void (^onFailure)(NSError *error) = ^(NSError *error) {
        statusCode = 400;
        CFRunLoopRef runloopref = CFRunLoopGetCurrent();
        CFRunLoopStop(runloopref);
    };
    
    [_service getPath:path parameters:parameters success:onSuccess failure:onFailure];
    CFRunLoopRun();
    XCTAssertTrue(statusCode == 200, @"passed !");
}


@end
