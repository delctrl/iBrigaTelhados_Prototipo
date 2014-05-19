//
//  CharacterTests.m
//  Movement Protorype
//
//  Created by Rodrigo P. Assunção on 09/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BPTCharacter.h"

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

- (void)testCharacterInitWithValidTextureWillWork
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"hunter.png"];
    BPTCharacter *testChar = [[BPTCharacter alloc] initWithTexture:texture];
    XCTAssertNotEqualObjects(testChar, Nil, @"Personagem não devia estar nulo");
    XCTAssertNotEqualObjects(testChar.texture, Nil, @"Textura não devia ser nula");
}

-(void)testCharacterInitWithInvalidTextureWillWork
{
    SKTexture *texture = nil;
    BPTCharacter *testChar = [[BPTCharacter alloc] initWithTexture:texture];
    XCTAssertNotEqualObjects(testChar, Nil, @"Personagem não devia estar nulo");
    XCTAssertEqualObjects(testChar.texture, Nil, @"Textura devia ser nula");
}

-(void)testCharacterInitWithValidTextureAndPositionInArrayAndthingsWorkAsExpected
{
    BPTCharacter *testChar = [[BPTCharacter alloc] initWithTexture:@"hunter" arrayPosition:CGPointMake(3, 4) team:[NSNumber numberWithInt:1]];
    XCTAssertNotEqualObjects(testChar, Nil, @"Personagem não devia estar nulo");
    XCTAssertNotEqualObjects(testChar.texture, Nil, @"Textura não devia ser nula");
    XCTAssertEqual(testChar.cgpPosAtTileMap.x, 3.0f, @"Posição devia ser 3");
    XCTAssertEqual(testChar.cgpPosAtTileMap.y, 4.0f, @"Posição devia ser 4");
}

-(void)testIfCharacterIsometricPositionInSceneIsAlwaysValid
{
    BPTCharacter *testChar = [[BPTCharacter alloc] init];
    [testChar changePositionWithDifferences:CGPointMake(0, 0)];
    XCTAssertEqual(testChar.position.x, 10.0f, @"Posicao X na cena deveria ser 10");
    XCTAssertEqual(testChar.position.y, 42.5f, @"Posição Y na cena deveria ser 42.5");
}

@end

