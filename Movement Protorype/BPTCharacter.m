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

@synthesize marrMapVision;

/**@a: Model | @b: View | @c: Controller **/

/**@a**/
- (id) initWithTexture: (SKTexture *) texture {
    
    self = [super init];
    if (self) {
        self.texture = texture;
        self.nbrLife = [[NSNumber alloc] initWithInt:4];
        
        [self initVision];
    }
    return self;
}

/**@a**/
- (void) initVision {
    
    self.marrMapVision = [[NSMutableArray alloc] init];
    for(int i=0; i< MAP_W; i++){
        for(int j =0; j < MAP_H; j++){
            BPTTile *visionTile = [[BPTTile alloc] initWithPos: CGPointMake(i, j) AndTexture: nil];
    
            [self.marrMapVision addObject:visionTile];
        }
    }
    
    [self updateVision];
}

/**@a**/
- (int) returnTileAtX: (int) x AndAtY: (int) y {
    
    return x*MAP_W + y;
}

/**@a**/
- (void) updateVision {
    
    [self resetAlphas];
    
    BPTTile *tileCharacter = [self.marrMapVision objectAtIndex:[self returnTileAtX:self.cgpPosAtTileMap.x AndAtY:self.cgpPosAtTileMap.y]];
    tileCharacter.nbrVisionType = 0;
    for(BPTTile *selectedTile in self.marrMapVision){
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
    for(BPTTile *selectedTile in self.marrMapVision){
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

- (id) initWithTexture: (NSString *) textureName arrayPosition: (CGPoint) arrayPosition team: (NSNumber *) team hp: (NSNumber *) hp initiative: (NSNumber *) initiative {
    
    self = [self initWithTexture: textureName arrayPosition: arrayPosition team: team];
    self.nbrLife = hp;
    self.nbrInitiative = initiative;
    
    return self;
}

/**@a**/
- (void) changePositionWithDifferences: (CGPoint) position {
    self.position = CGPointMake(position.x+CHAR_DIFF_X, position.y+(HEIGHT_TILE*CHAR_SIZE_RATE)/2-CHAR_DIFF_Y);
}

-(void) resetVision {
    
    for(BPTTile *visionTile in self.marrMapVision){
        visionTile.nbrVisionType = [NSNumber numberWithInt:4];
        visionTile.alpha = 0.2;
    }
    
    NSLog(@"VISAO RESET");
}


@end
