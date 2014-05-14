//
//  MyScene.h
//  Prototype Tile
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 05/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTImportsDefines.h"

@interface BPTJogo : SKScene {
    NSMutableArray *marrTileMatrix;
    NSMutableArray *marrTilesEnabled;
    BOOL boolCharacterIsSelected;
    BPTCharacter *charSelectedCharacter;
}

@property BPTCharacter *charNumberOne;
@property BPTCharacter *charNumberTwo;

@end
