//
//  Tile.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 09/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Tile : SKSpriteNode

@property CGPoint positionAtTileMap;


- (id) initWithPos : (CGPoint) position : (SKTexture *) texture;
@end
