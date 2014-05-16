
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
        [self setMapController:[[BPTMapController alloc] init]];
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

- (BOOL) checkIfThereIsACharacterAtPosition: (CGPoint) position SelectedCharacter:(BPTCharacter*) character {
    
    if ([[self mapController] returnTileAtPosition:position].nbrIsOccupiedByTeam == character.nbrTeam) {
        return TRUE;
    }
    
    return FALSE;
}

- (BPTCharacter*) checkIfCharacterWasSelectedOnPoint: (CGPoint) touchPoint andChildrenArray: (NSArray*) sceneChildren{
    
    for (SKNode *node in sceneChildren) {
        if (CGRectContainsPoint (node.frame, touchPoint) && [node isKindOfClass: [BPTCharacter class]]) {
            return (BPTCharacter *) node;
        }
    }
    
    return Nil;
}

- (void) checkPushMovementForTile: (BPTTile *) tile AndFirstCharacter: (BPTCharacter *) character01 AndSecondCharacter: (BPTCharacter*) character02{
    
    BPTTile* tileAux = [[BPTTile alloc] init];
    CGPoint aux;
    int bounds = 0;
    
    for (int i = -1; i<2; i++) {
        if (i == 0) {
            continue;
        }
        
        if (i > 0) {
            bounds = 4;
        }
        
        if (character01.cgpPosAtTileMap.x - character02.cgpPosAtTileMap.x == i) {
            if (character01.cgpPosAtTileMap.x == bounds) {
                [character01 removeFromParent];
                return;
            }
            aux = CGPointMake(character01.cgpPosAtTileMap.x+i, character01.cgpPosAtTileMap.y);
        }
        else if (character01.cgpPosAtTileMap.y - character02.cgpPosAtTileMap.y == i) {
            if (character01.cgpPosAtTileMap.y == bounds) {
                [character01 removeFromParent];
                return;
            }
            aux = CGPointMake(character01.cgpPosAtTileMap.x, character01.cgpPosAtTileMap.y+i);
        }
    }
    
    tileAux = [[self mapController] returnTileAtPosition: aux];
    [character01 changePositionWithDifferences:tileAux.position];
    
    character01.cgpPosAtTileMap = tileAux.cgpPosAtTileMap;
    tileAux.nbrIsOccupiedByTeam = character01.nbrTeam;
}

- (BPTCharacter*) checkCharacterToBeMoved: (BPTCharacter*) character AndPoint: (CGPoint)touchPoint onMovimentArray:(NSMutableArray*)marrTilesEnabled andCharacterArray: (NSMutableArray*) sceneChildren {
    for (BPTTile *node in marrTilesEnabled) {
        if (CGRectContainsPoint (node.frame, touchPoint)) {
            [[self mapController] returnTileAtPosition:character.cgpPosAtTileMap].nbrIsOccupiedByTeam = 0;
            
            if (node.nbrIsOccupiedByTeam > 0) {
                for (BPTCharacter * charNode in sceneChildren) {
                    if ([charNode isKindOfClass: [BPTCharacter class]] && CGRectContainsPoint (charNode.frame, node.position)) {
                        [self checkPushMovementForTile: node AndFirstCharacter: charNode AndSecondCharacter:character];
                    }
                }
            }
            
            [character changePositionWithDifferences:node.position];
            character.cgpPosAtTileMap = node.cgpPosAtTileMap;
            node.nbrIsOccupiedByTeam = character.nbrTeam;
            
            return Nil;
        }
    }
    
    return character;
}


@end
