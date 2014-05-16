//
//  BPTMapController.h
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPTImportsDefines.h"
#import "BPTTile.h"

@interface BPTMapController : NSObject{

    NSMutableArray *tileMap;
}

- (BPTTile *) returnTileAtPosition: (CGPoint) pointAtMatrix;
-(NSMutableArray *) getMap;

@end
