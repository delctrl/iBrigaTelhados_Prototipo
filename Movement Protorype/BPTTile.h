//
//  Tile.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 09/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTImportsDefines.h"

@interface BPTTile : SKSpriteNode

@property CGPoint cgpPosAtTileMap;

@property NSNumber *nbrVisionType;
@property SKLabelNode *lblCoords;

@property NSNumber *nbrIsOccupiedByTeam;


- (id) initWithPos: (CGPoint) position AndTexture: (SKTexture *) texture;
@end
