//
//  Character.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Character.h"

@implementation Character {
    int matrixVision [5][5];
}

- (id) initWithTexture : (SKTexture *) texture {
    self = [super init];
    self.texture = texture;
    return self;
}

-(id)initWithTexture:(SKTexture *)texture nodePosition:(CGPoint)position arrayPosition:(CGPoint)arrayPosition
{
    self = [self initWithTexture: texture];
    self.size = CGSizeMake(WIDTH_TILE*SCALE, WIDTH_TILE*CHAR_SIZE_RATE*SCALE);
    [self changePositionWithDifferences:position];
    self.posAtTileMap = arrayPosition;
    return self;
}

-(void)changePositionWithDifferences:(CGPoint)position
{
    self.position = CGPointMake(position.x+CHAR_DIFF_X, position.y+(HEIGHT_TILE*CHAR_SIZE_RATE)/2-CHAR_DIFF_Y);
}

@end
