//
//  DaftTestProjectTests.m
//  DaftTestProjectTests
//
//  Created by daiyuzhang on 29/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+tools.h"

@interface DaftTestProjectTests : XCTestCase

@end

@implementation DaftTestProjectTests

- (void)setUp {
    [super setUp];
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

-(void)testConvertToJsonMethod {
    //    Given
    NSDictionary *parameters = @{@"parameters":@"{\"api_key\":\"7d44326a4d8144112daae2ba8138409a87d6dd10\",\"query\":{\"perpage\":50}}"};
    
    //    When
    NSString *jsonString = [NSString convertToJson:parameters];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
       //    Then
    XCTAssertTrue([dictionary isEqualToDictionary:parameters], @"check passed");
}

@end
