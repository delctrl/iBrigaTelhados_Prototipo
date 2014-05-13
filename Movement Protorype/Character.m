//
//  Character.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Character.h"

@implementation Character

- (id) initWithTexture : (SKTexture *) texture {
    self = [super init];
    self.texture = texture;
    [self initCharVision];
    
    return self;
    
}

- (void) initCharVision{
    
    self.charMapVision = [[NSMutableArray alloc] init];
    
    for(int i=0; i< MAP_W; i++){
        for(int j =0; j < MAP_H; j++){
            
            Tile *visionTile = [[Tile alloc] initWithPos:CGPointMake(i, j) :nil];
            [self.charMapVision addObject:visionTile];
        }
    }
    
    [self updateCharacterVision];
    
    
}






-(int) returnTileX: (int)x Y:(int)y{
    
    return x*MAP_W + y;
}


-(void) updateCharacterVision{
    
    [self resetAlphas];
    

        Tile *tileCharacter = [self.charMapVision objectAtIndex:[self returnTileX:self.posAtTileMap.x Y:self.posAtTileMap.y]];
        tileCharacter.visionType = 0;
        
        
        for(Tile *selectedTile in self.charMapVision){
            
            int distance = abs((selectedTile.positionAtTileMap.x - tileCharacter.positionAtTileMap.x)) + abs((selectedTile.positionAtTileMap.y - tileCharacter.positionAtTileMap.y));
            
            if(distance > 4)
                distance = 4;
            
            selectedTile.visionType = distance;
            
            selectedTile.alpha = 1 - (distance *0.2);
            
        }
}

-(void)resetAlphas{
    
    for(Tile *selectedTile in self.charMapVision){
        
        selectedTile.alpha = 1;
    }
    
}

@end
