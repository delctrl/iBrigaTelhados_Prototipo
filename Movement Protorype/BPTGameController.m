
//
//  BPTGameController.m
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTGameController.h"

@implementation BPTGameController

- (id) init {
    self = [super init];
    
    if (self) {
        playerOne = [[BPTPlayer alloc] init];
        playerTwo = [[BPTPlayer alloc] init];
        [self criaCharTestes];
    }
    
    return self;
}

- (void) criaCharTestes {
    BPTCharacter *auxChar;
    NSMutableArray *auxMarrPlayerOne = [[NSMutableArray alloc] init];
    NSMutableArray *auxMarrPlayerTwo = [[NSMutableArray alloc] init];
    
    auxChar = [[BPTCharacter alloc] initWithTexture:@"hunter.png"
                                      arrayPosition: CGPointMake(0,0)
                                               team: [NSNumber numberWithInt:1]];
    [auxMarrPlayerOne addObject: auxChar];
    auxChar = [[BPTCharacter alloc] initWithTexture:@"hunter.png"
                                      arrayPosition: CGPointMake(0,1)
                                               team: [NSNumber numberWithInt:1]];
    [auxMarrPlayerOne addObject: auxChar];
    auxChar = [[BPTCharacter alloc] initWithTexture:@"hunter.png"
                                      arrayPosition: CGPointMake(1,0)
                                               team: [NSNumber numberWithInt:1]];
    [auxMarrPlayerOne addObject: auxChar];
    [self createCharactesPlayerOne:auxMarrPlayerOne];
    
    auxChar = [[BPTCharacter alloc] initWithTexture:@"medic.png"
                                      arrayPosition: CGPointMake(4,4)
                                               team: [NSNumber numberWithInt:2]];
    [auxMarrPlayerTwo addObject: auxChar];
    auxChar = [[BPTCharacter alloc] initWithTexture:@"medic.png"
                                      arrayPosition: CGPointMake(4,3)
                                               team: [NSNumber numberWithInt:2]];
    [auxMarrPlayerTwo addObject: auxChar];
    auxChar = [[BPTCharacter alloc] initWithTexture:@"medic.png"
                                      arrayPosition: CGPointMake(3,4)
                                               team: [NSNumber numberWithInt:2]];
    [auxMarrPlayerTwo addObject: auxChar];
    [self createCharactesPlayerTwo:auxMarrPlayerTwo];
}

- (NSMutableArray *) getAllCharacters {
    NSMutableArray * allCharacters = [[NSMutableArray alloc] init];
    [allCharacters addObjectsFromArray:[playerOne getAllCharacters]];
    [allCharacters addObjectsFromArray:[playerTwo getAllCharacters]];
    return allCharacters;
}

- (void) createCharactesPlayerOne: (NSMutableArray *) characters {
    [playerOne setCharacters: characters];
}

- (void) createCharactesPlayerTwo: (NSMutableArray *) characters {
    [playerTwo setCharacters: characters];
}

- (BOOL) checkIfThereIsACharacterAtPosition: (CGPoint) position onScene: (BPTGameScene*) scene {
    
    if ([scene returnTileAtPosition:position].nbrIsOccupiedByTeam == [scene charSelectedCharacter].nbrTeam) {
        return TRUE;
    }
    
    return FALSE;
}

- (BPTCharacter*) checkIfCharacterWasSelectedOnPoint: (CGPoint) touchPoint onScene: (BPTGameScene*) scene {
    
    for (SKNode *node in scene.children) {
        if (CGRectContainsPoint (node.frame, touchPoint) && [node isKindOfClass: [BPTCharacter class]]) {
            [scene startShowingMovableTiles];
            [scene startShowingCharacterVision];
            return (BPTCharacter *) node;
        }
    }
    
    return Nil;
}


@end
