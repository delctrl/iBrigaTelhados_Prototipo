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
    BPTGameController *gameController; /** @details Controlador do jogo. **/
    
    /** @note: Variáveris locais relacionadas ao mapa **/
    NSMutableArray *marrTileMatrix; /** @details Matriz de tiles. **/
    NSMutableArray *marrTilesEnabled; /** @details Matriz auxiliar de tiles andáveis. **/
 
    /** @note: Variáveris locais relacionadas a personagens **/
//    NSMutableArray *marrGameCharacters;
    BPTCharacter *charSelectedCharacter; /** @details Personagem selecionado **/
    BOOL boolCharacterIsSelected; /** @details Variável para checar se existe um personagem selecionado. **/
}

@end
