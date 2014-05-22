//
//  Character.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//
/** @test @details @note @bug @skip @overload **/


#import "BPTCharacter.h"

@implementation BPTCharacter

/**@a: Model | @b: View | @c: Controller **/

/**@a**/
- (id) initWithTexture: (SKTexture *) texture {
    
    self = [super init];
    if (self) {
        self.texture = texture;
        self.nbrLife = [[NSNumber alloc] initWithInt:4];
        
        [self initCharVision];
    }
    return self;
}

/**@a**/
- (void) initCharVision {
    
    self.marrCharMapVision = [[NSMutableArray alloc] init];
    for(int i=0; i< MAP_W; i++){
        for(int j =0; j < MAP_H; j++){
            BPTTile *visionTile = [[BPTTile alloc] initWithPos: CGPointMake(i, j) AndTexture: nil];
    
            [self.marrCharMapVision addObject:visionTile];
        }
    }
    
    [self updateCharacterVision];
}

/**@a**/
- (int) returnTileAtX: (int) x AndAtY: (int) y {
    
    return x*MAP_W + y;
}

/**@a**/
- (void) updateCharacterVision {
    
    [self resetAlphas];
    
    BPTTile *tileCharacter = [self.marrCharMapVision objectAtIndex:[self returnTileAtX:self.cgpPosAtTileMap.x AndAtY:self.cgpPosAtTileMap.y]];
    tileCharacter.nbrVisionType = 0;
    for(BPTTile *selectedTile in self.marrCharMapVision){
        int distance = abs((selectedTile.cgpPosAtTileMap.x - tileCharacter.cgpPosAtTileMap.x)) + abs((selectedTile.cgpPosAtTileMap.y - tileCharacter.cgpPosAtTileMap.y));
        if(distance > 4) {
            distance = 4;
        }
        selectedTile.nbrVisionType = [NSNumber numberWithInt: distance];
        selectedTile.alpha = 1 - (distance *0.2);
    }
}

/**@a**/
- (void) resetAlphas{
    for(BPTTile *selectedTile in self.marrCharMapVision){
        selectedTile.alpha = 1;
    }
}

/**@a**/
- (id) initWithTexture: (NSString *) textureName arrayPosition: (CGPoint) arrayPosition team: (NSNumber *) team {

    self = [self initWithTexture: [SKTexture textureWithImageNamed: textureName]];
    self.strTextureName = textureName;
    self.size = CGSizeMake(WIDTH_TILE*SCALE, WIDTH_TILE*CHAR_SIZE_RATE*SCALE);
    self.cgpPosAtTileMap = arrayPosition;
    self.nbrTeam = team;
    
    return self;
}

/**@a**/
- (void) changePositionWithDifferences: (CGPoint) position {
    self.position = CGPointMake(position.x+CHAR_DIFF_X, position.y+(HEIGHT_TILE*CHAR_SIZE_RATE)/2-CHAR_DIFF_Y);
}

@end
