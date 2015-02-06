//
//  anitomi_for_osx_demoTests.m
//  anitomi-for-osx-demoTests
//
//  Created by Tail Red on 2/6/15.
//  Copyright (c) 2015 Atelier Shiori. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

@interface anitomi_for_osx_demoTests : XCTestCase

@end

@implementation anitomi_for_osx_demoTests

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

@end
