//
//  BPTGameController.h
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPTPlayer.h"
#import "BPTMapController.h"
#import "BPTCharacter.h"

@interface BPTGameController : NSObject

@property BPTPlayer *playerOne;
@property BPTPlayer *playerTwo;
@property BPTMapController *mapController;

- (NSMutableArray *) getAllCharacters;

- (void) createCharactesPlayerOne: (NSMutableArray *) characters;
- (void) createCharactesPlayerTwo: (NSMutableArray *) characters;

- (BPTCharacter*) checkIfCharacterWasSelectedOnPoint: (CGPoint) touchPoint andChildrenArray: (NSArray*) sceneChildren;
- (BOOL) checkIfThereIsACharacterAtPosition: (CGPoint) position SelectedCharacter:(BPTCharacter*) character;
- (BPTCharacter*) checkCharacterToBeMoved: (BPTCharacter*) character AndPoint: (CGPoint)touchPoint onMovimentArray:(NSMutableArray*)marrTilesEnabled andCharacterArray: (NSArray*) sceneChildren;
- (BOOL) checkPushedMovementForTile: (BPTTile *) tile AndCharacterPushed: (BPTCharacter *) characterPushed;
@end