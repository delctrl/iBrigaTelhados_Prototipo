//
//  Character.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Imports and Defines.h"

@interface Character : SKSpriteNode

@property int team;
@property CGPoint posAtTileMap;
@property NSNumber *life;
@property NSNumber *defense;
@property NSNumber *attack;
@property NSNumber *initiative;

- (id) initWithTexture : (SKTexture *) texture;

@end
