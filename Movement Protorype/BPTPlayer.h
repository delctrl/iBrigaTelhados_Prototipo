//
//  BPTPlayer.h
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPTCharacter.h"
#import "BPTTile.h"
#import "BPTObjectWithVision.h"

@interface BPTPlayer : NSObject <BPTObjectWithVision> {
    NSMutableArray *marrCharacters;

}


@property NSNumber *nbrTeam;

- (void) removeCharacter: (BPTCharacter *) character;
- (void) setCharacters: (NSMutableArray *) characters;
- (NSMutableArray *) getAllCharacters;
- (id) initWithTeamId: (int) teamId;

@end
