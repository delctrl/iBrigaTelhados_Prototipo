//
//  JogoTests.m
//  Movement Protorype
//
//  Created by Rodrigo P. Assunção on 13/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Jogo.h"

@interface JogoTests : XCTestCase

@end

@implementation JogoTests

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

- (void)testIfSceneNeverReturnsNull
{
    // Create and configure the scene.
    Jogo * scene = [Jogo sceneWithSize:CGSizeMake(200, 300)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    XCTAssertNotEqual(scene, nil, @"Cena não deveria ser nulo");
}

-(void)testIfChar01NeverReturnsNull
{
    // Create and configure the scene.
    Jogo * scene = [Jogo sceneWithSize:CGSizeMake(200, 300)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    XCTAssertNotEqual(scene.character01, nil, @"Char01 não deveria ser nulo");
}

-(void)testIFChar02NeverReturnsNull
{
    // Create and configure the scene.
    Jogo * scene = [Jogo sceneWithSize:CGSizeMake(200, 300)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    XCTAssertNotEqual(scene.character02, nil, @"Char02 não deveria ser nulo");
}

@end
