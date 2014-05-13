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
@property NSString *textureName;
@property CGPoint posAtTileMap;
@property NSNumber *life;
@property NSNumber *defense;
@property NSNumber *attack;
@property NSNumber *initiative;
@property NSMutableArray *charMapVision;

<<<<<<< HEAD
- (id) initWithTexture : (SKTexture *) texture;
- (id) initWithTexture:(SKTexture*) texture nodePosition:(CGPoint)position arrayPosition:(CGPoint)arrayPosition;
- (void) changePositionWithDifferences:(CGPoint) position;
=======
-(id) initWithTexture : (SKTexture *) texture;
-(void) updateCharacterVision;
>>>>>>> FETCH_HEAD

@end
