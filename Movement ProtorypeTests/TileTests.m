//
//  TileTests.m
//  Movement Protorype
//
//  Created by Rodrigo P. Assunção on 13/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BPTTile.h"

@interface TileTests : XCTestCase

@end

@implementation TileTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testIfTileInitWillNeverReturnNull
{
    BPTTile *t = [[BPTTile alloc] initWithTexture:Nil color:nil size:CGSizeMake(0, 0)];
    XCTAssertNotEqual(t, NULL, @"Não deveria ser nulo");
}

@end
