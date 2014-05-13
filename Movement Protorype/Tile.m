//
//  Tile.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 09/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Tile.h"

@implementation Tile

- (id) initWithPos : (CGPoint) position : (SKTexture *) texture {
    self = [super initWithTexture: texture];
    self.positionAtTileMap = position;
    return self;
}

@end
