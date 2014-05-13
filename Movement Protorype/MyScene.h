//
//  MyScene.h
//  Prototype Tile
//

//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Imports and Defines.h"

@interface MyScene : SKScene {
    NSMutableArray *tileMatrix;
    NSMutableArray *tilesEnabled;
    BOOL characterIsSelected;
    Character *selectedCharacter;
}

@property Character *character01;
@property Character *character02;

- (void) createTerrain;

@end
