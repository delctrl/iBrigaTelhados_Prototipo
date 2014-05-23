//
//  MyScene.h
//  Prototype Tile
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 05/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTImportsDefines.h"
#import "BPTTile.h"
#import "BPTCharacter.h"
#import "BPTGameController.h"
#import "BPTObjectWithVision.h"

@interface BPTGameScene : SKScene {
    /** @note: Variáveris locais relacionadas ao mapa **/
    BPTGameController *gameController;
    
    /** @note: Variáveris locais relacionadas ao mapa **/
    NSMutableArray *marrTileMatrix;
    NSMutableArray *marrTilesEnabled;
 
    /** @note: Variáveris locais relacionadas a personagens **/
//    NSMutableArray *marrGameCharacters;
    BPTCharacter *charSelectedCharacter;
    BOOL boolCharacterIsSelected;
}

@end
