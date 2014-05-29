
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
        self.playerOne = [[BPTPlayer alloc] initWithTeamId: 1];
        self.playerTwo = [[BPTPlayer alloc] initWithTeamId: 2];
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
    [allCharacters addObjectsFromArray:[self.playerOne getAllCharacters]];
    [allCharacters addObjectsFromArray:[self.playerTwo getAllCharacters]];
    return allCharacters;
}

- (void) createCharactesPlayerOne: (NSMutableArray *) characters {
    [self.playerOne setCharacters: characters];
}

- (void) createCharactesPlayerTwo: (NSMutableArray *) characters {
    [self.playerTwo setCharacters: characters];
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
/**********************************/
/*** MUDAR URGENTEMENTE BEGINS! ***/
/**********************************/
- (void) checkPushMovementForTile: (BPTTile *) tile AndFirstCharacter: (BPTCharacter *) characterPushed AndSecondCharacter: (BPTCharacter*) characterPushing {
    
    BOOL characterHasBeenMoved = NO;
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
        
        if (characterPushed.cgpPosAtTileMap.x - characterPushing.cgpPosAtTileMap.x == i) {
            if (characterPushed.cgpPosAtTileMap.x == bounds) {
                [self.mapController returnTileAtPosition:characterPushed.cgpPosAtTileMap].nbrIsOccupiedByTeam = 0;
                [characterPushed removeFromParent];
                [self.playerOne removeCharacter:characterPushed];
                return;
            }
            aux = CGPointMake(characterPushed.cgpPosAtTileMap.x+i, characterPushed.cgpPosAtTileMap.y);
            if ([self checkPushedMovementForTile:[self.mapController returnTileAtPosition:aux] AndCharacterPushed:characterPushed]) {
                aux = CGPointMake(characterPushed.cgpPosAtTileMap.x+i, characterPushed.cgpPosAtTileMap.y);
                characterHasBeenMoved = YES;
            }
        }
        else if (characterPushed.cgpPosAtTileMap.y - characterPushing.cgpPosAtTileMap.y == i) {
            if (characterPushed.cgpPosAtTileMap.y == bounds) {
                [self.mapController returnTileAtPosition:characterPushed.cgpPosAtTileMap].nbrIsOccupiedByTeam = 0;
                [characterPushed removeFromParent];
                [self.playerOne removeCharacter:characterPushed];
                return;
            }
            aux = CGPointMake(characterPushed.cgpPosAtTileMap.x, characterPushed.cgpPosAtTileMap.y+i);
            if ([self checkPushedMovementForTile:[self.mapController returnTileAtPosition:aux] AndCharacterPushed:characterPushed]) {
                aux = CGPointMake(characterPushed.cgpPosAtTileMap.x, characterPushed.cgpPosAtTileMap.y+i);
                characterHasBeenMoved = YES;
            }
        }
    }
    
    if (characterHasBeenMoved) {
        tileAux = [[self mapController] returnTileAtPosition: aux];
        [characterPushed changePositionWithDifferences:tileAux.position];
        [self.mapController returnTileAtPosition:characterPushed.cgpPosAtTileMap].nbrIsOccupiedByTeam = 0;
    
        characterPushed.cgpPosAtTileMap = tileAux.cgpPosAtTileMap;
        tileAux.nbrIsOccupiedByTeam = characterPushed.nbrTeam;
        characterPushed.nbrLife = [NSNumber numberWithInt: [characterPushed.nbrLife integerValue]-1];
    } else {
        characterPushed.nbrLife = [NSNumber numberWithInt: [characterPushed.nbrLife integerValue]-2];
    }
    
    if ([characterPushed.nbrLife intValue] <= 0) {
        [self.mapController returnTileAtPosition:characterPushed.cgpPosAtTileMap].nbrIsOccupiedByTeam = 0;
        [characterPushed removeFromParent];
        [self.playerOne removeCharacter:characterPushed];
    }
}

- (BOOL) checkPushedMovementForTile: (BPTTile *) tile AndCharacterPushed: (BPTCharacter *) characterPushed {
    if (tile.nbrIsOccupiedByTeam != 0) {
        return NO;
    }
    return YES;
}

- (BPTCharacter*) checkCharacterToBeMoved: (BPTCharacter*) character AndPoint: (CGPoint)touchPoint onMovimentArray:(NSMutableArray*)marrTilesEnabled andCharacterArray: (NSMutableArray*) sceneChildren {
    for (BPTTile *node in marrTilesEnabled) {
        if (CGRectContainsPoint (node.frame, touchPoint)) {
            
            if (node.nbrIsOccupiedByTeam > 0) {
                for (BPTCharacter * charNode in sceneChildren) {
                    if ([charNode isKindOfClass: [BPTCharacter class]] && node.cgpPosAtTileMap.x == charNode.cgpPosAtTileMap.x && node.cgpPosAtTileMap.y == charNode.cgpPosAtTileMap.y) {
                        [self checkPushMovementForTile: node AndFirstCharacter: charNode AndSecondCharacter:character];
                    }
                }
            }
            if (node.nbrIsOccupiedByTeam == 0) {
                [[self mapController] returnTileAtPosition:character.cgpPosAtTileMap].nbrIsOccupiedByTeam = 0;
                [character changePositionWithDifferences:node.position];
                character.cgpPosAtTileMap = node.cgpPosAtTileMap;
                node.nbrIsOccupiedByTeam = character.nbrTeam;
                return Nil;
            }
        }
    }
    
    [self checkPlayerAliveCharacters: self.playerOne];
    [self checkPlayerAliveCharacters: self.playerTwo];
    
    return character;
}
/********************************/
/*** MUDAR URGENTEMENTE ENDS! ***/
/********************************/
-(void) checkPlayerAliveCharacters: (BPTPlayer *) player{

    int sum = 0;
    
    for(BPTCharacter *character in [player getAllCharacters]){
        
        sum += [character.nbrLife intValue];
        
        if(sum > 0){
            return;
        }
    }
    
    
    NSLog(@"O Player %@ perdeu",player.nbrTeam);
}


/**@test @c*/



@end
