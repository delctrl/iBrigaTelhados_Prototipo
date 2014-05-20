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
            BPTTile *tileNode = [[BPTTile alloc] initWithPos: CGPointMake(i, j)
                                                  AndTexture: grassTile];
            tileNode.size = CGSizeMake(WIDTH_TILE, HEIGHT_TILE);
            tileNode.position = [self getIsoPosition:CGPointMake(i*HEIGHT_TILE, j*HEIGHT_TILE)];
            tileNode.nbrIsOccupiedByTeam = 0;
            [marrTileMatrix addObject: tileNode];
        }
    }
    
    return marrTileMatrix;
}

-(id) init {
    
    self = [super init];
    
    if(self){
        tileMap = [self createTerrain];
    }
    return self;
}

-(NSMutableArray *) getMap {
    return tileMap;
}

-(BPTTile *) tileAtIndex: (int) index {

    return [tileMap objectAtIndex:index];
}

-(void) setTile: (BPTTile *) tile atIndex: (int) index {

    [tileMap setObject:tile atIndexedSubscript:index];
}

- (BPTTile *) returnTileAtPosition: (CGPoint) pointAtMatrix {
    
    if (pointAtMatrix.x < 0 || pointAtMatrix.x >= 5 ||
        pointAtMatrix.y < 0 || pointAtMatrix.y >= 5) {
        return NULL;
    }
    
    return [tileMap objectAtIndex: 5*pointAtMatrix.x+pointAtMatrix.y];
}

- (CGPoint) getIsoPosition: (CGPoint) pt {
    
    CGPoint isoPos;
    isoPos.x = pt.x - pt.y;
    isoPos.y = (pt.x + pt.y)/2;
    
    isoPos.x += 370;
    isoPos.y += 370;
    
    return isoPos;
}
- (CGPoint) get2DPosition: (CGPoint) pt {
    CGPoint pos;
    pos.x = (2*pt.y+pt.x)/2;
    pos.y = (2*pt.y-pt.x)/2;
    return pos;
}
- (CGPoint) getCoordinates: (CGPoint) pt {
    CGPoint pos;
    pos.x = roundf(pt.x/HEIGHT_TILE);
    pos.y = roundf(pt.y/HEIGHT_TILE);
    return pos;
}
@end
