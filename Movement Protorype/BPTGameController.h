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
#import "BPTGameScene.h"

@interface BPTGameController : NSObject {
    BPTPlayer *playerOne;
    BPTPlayer *playerTwo;
}

@property BPTMapController *mapController;

- (NSMutableArray *) getAllCharacters;

- (void) createCharactesPlayerOne: (NSMutableArray *) characters;
- (void) createCharactesPlayerTwo: (NSMutableArray *) characters;

- (BPTCharacter*) checkIfCharacterWasSelectedOnPoint: (CGPoint) touchPoint onScene: (BPTGameScene*) scene;
@end
