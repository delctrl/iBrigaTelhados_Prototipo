//
//  Character.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTImportsDefines.h"
#import "BPTTile.h"
#import "BPTObjectWithVision.h"

@interface BPTCharacter : SKSpriteNode <BPTObjectWithVision>

@property NSNumber *nbrTeam;
@property NSString *strTextureName;
@property CGPoint cgpPosAtTileMap;
@property NSNumber *nbrLife;
@property NSNumber *nbrDefense;
@property NSNumber *nbrAttack;
@property NSNumber *nbrInitiative;

- (id) initWithTexture : (SKTexture *) texture;
- (id) initWithTexture: (NSString*) textureName arrayPosition: (CGPoint) arrayPosition team: (NSNumber *) team;
- (void) changePositionWithDifferences: (CGPoint) position;

@end
