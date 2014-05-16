//
//  BPTMapController.m
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTMapController.h"

@implementation BPTMapController

- (NSMutableArray*) createTerrainOnScene: (BPTGameScene*) scene{
    
    NSMutableArray *marrTileMatrix = [[NSMutableArray alloc] init];
    SKTexture *grassTile = [SKTexture textureWithImageNamed:@"grass.png"];
    
    for (int i=0; i<5; i++) {
        for (int j=0; j <5 ; j++) {
            BPTTile *tileNode = [[BPTTile alloc] initWithPos: CGPointMake(i, j) AndTexture: grassTile];
            tileNode.size = CGSizeMake(WIDTH_TILE, HEIGHT_TILE);
            tileNode.position = [scene getIsoPosition:CGPointMake(i*HEIGHT_TILE, j*HEIGHT_TILE)];
            tileNode.nbrIsOccupiedByTeam = 0;
            [marrTileMatrix addObject: tileNode];
            [scene addChild:tileNode];
        }
    }
    
    return marrTileMatrix;
}

@end
