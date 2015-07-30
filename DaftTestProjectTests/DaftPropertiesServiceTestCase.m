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
//    Given
    NSDictionary *parameters = @{@"parameters":@"{\"api_key\":\"7d44326a4d8144112daae2ba8138409a87d6dd10\",\"query\":{\"perpage\":50}}"};
    NSString *path = @"search_sale";

//    When
    XCTestExpectation *exception = [self expectationWithDescription:@"testRetriveData"];
    [_service getPath:path
           parameters:parameters
              success:^(NSArray *responsedData) {
                  [exception fulfill];
              }
              failure:^(NSError *error) {
              }];
//    Then
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error){
        if (error) {
            XCTFail(@"timeout");
        } else {
            NSLog(@"%s success", __func__);
            XCTAssertTrue(@"pass");
        }
    }];
}


@end
