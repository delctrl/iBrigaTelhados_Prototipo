//
//  CharacterTests.m
//  Movement Protorype
//
//  Created by Rodrigo P. Assunção on 13/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Character.h"

@interface CharacterTests : XCTestCase

@end

@implementation CharacterTests

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

- (void)testInitWithValidTexture
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"hunter.png"];
    Character *testChar = [[Character alloc] initWithTexture:texture];
    XCTAssertNotEqualObjects(testChar, Nil, @"Personagem não devia estar nulo");
    XCTAssertNotEqualObjects(testChar.texture, Nil, @"Textura não devia ser nula");
}

-(void)testInitWithInvalidTexture
{
    SKTexture *texture = nil;
    Character *testChar = [[Character alloc] initWithTexture:texture];
    XCTAssertNotEqualObjects(testChar, Nil, @"Personagem não devia estar nulo");
    XCTAssertEqualObjects(testChar.texture, Nil, @"Textura devia ser nula");
}

-(void)testInitWithValidTextureAndPositionInArray
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"hunter.png"];
    Character *testChar = [[Character alloc] initWithTexture:texture nodePosition:CGPointMake(30, 30) arrayPosition:CGPointMake(3, 4)];
    XCTAssertNotEqualObjects(testChar, Nil, @"Personagem não devia estar nulo");
    XCTAssertNotEqualObjects(testChar.texture, Nil, @"Textura não devia ser nula");
    XCTAssertEqual(testChar.posAtTileMap.x, 3.0f, @"Posição devia ser 3");
    XCTAssertEqual(testChar.posAtTileMap.y, 4.0f, @"Posição devia ser 4");
}

-(void)testIsometricPositionInScene
{
    Character *testChar = [[Character alloc] init];
    [testChar changePositionWithDifferences:CGPointMake(0, 0)];
    XCTAssertEqual(testChar.position.x, 10.0f, @"Posicao X na cena deveria ser 10");
    XCTAssertEqual(testChar.position.y, 42.5f, @"Posição Y na cena deveria ser 42.5");
}

@end
