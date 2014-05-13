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
    self.visionType = 4;
//    self.lblCoords = [[SKLabelNode alloc] init];
//    self.lblCoords.text =[NSString stringWithFormat:@"%.f , %.f",position.x, position.y];
//    self.lblCoords.fontSize = 20;
//    self.lblCoords.position = CGPointMake(0, 0);
//    [self addChild:self.lblCoords];
    return self;
}

@end
