//
//  MapControllerTests.m
//  Movement Protorype
//
//  Created by Rodrigo P. Assunção on 19/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BPTMapController.h"
#import "BPTTile.h"

@interface MapControllerTests : XCTestCase

@end

@implementation MapControllerTests

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

- (void)testIfYouGetTheCorrectTileFromMap
{
    BPTMapController *map = [[BPTMapController alloc] init];
    BPTTile *tile = [map returnTileAtPosition:CGPointMake(3, 4)];
    
    XCTAssertEqual(tile.cgpPosAtTileMap.x, 3.0f, @"Posicao x do tile deveria ser 3");
    XCTAssertEqual(tile.cgpPosAtTileMap.y, 4.0f, @"Posicao x do tile deveria ser 4");
}

- (void)testIfYouCantGetTileFromOutsideOfBounds
{
    BPTMapController *map = [[BPTMapController alloc] init];
    BPTTile *tile = [map returnTileAtPosition:CGPointMake(-3, -4)];
    
    XCTAssertNil(tile, @"O tile invalido deveria ser nulo");
}

-(void)testIfYouCanGetTheMapWithTheRightSize
{
    BPTMapController *map = [[BPTMapController alloc] init];
    NSMutableArray *array = [map getMap];
    
    XCTAssertNotNil(array, @"Array não deveria ser nulo");
    XCTAssertEqual((float)[array count], 25.0f, @"Tamanho do array do mapa deveria ser 25");
}

@end
