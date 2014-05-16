//
//  BPTMapController.m
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTMapController.h"

@implementation BPTMapController

- (NSMutableArray*) createTerrain{
    
    NSMutableArray *marrTileMatrix = [[NSMutableArray alloc] init];
    SKTexture *grassTile = [SKTexture textureWithImageNamed:@"grass.png"];
    
    for (int i=0; i<5; i++) {
        for (int j=0; j <5 ; j++) {
            BPTTile *tileNode = [[BPTTile alloc] initWithPos: CGPointMake(i, j) AndTexture: grassTile];
            tileNode.size = CGSizeMake(WIDTH_TILE, HEIGHT_TILE);
            tileNode.nbrIsOccupiedByTeam = 0;
            [marrTileMatrix addObject: tileNode];
        }
    }
    
    return marrTileMatrix;
}



-(id) init{
    
    self = [super init];
    
    if(self){
        tileMap = [self createTerrain];
    }
    return self;
}

-(NSMutableArray *) getMap{
    return tileMap;
}

-(BPTTile *) tileAtIndex: (int) index{

    return [tileMap objectAtIndex:index];
}

-(void) setTile: (BPTTile *) tile atIndex: (int) index{

    [tileMap setObject:tile atIndexedSubscript:index];
}
@end
