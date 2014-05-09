//
//  MyScene.h
//  Prototype Tile
//

//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Imports and Defines.h"
#import "Character.h"

@interface MyScene : SKScene {
    SKSpriteNode *matriz[5][5];
    BOOL characterIsSelected;
    Character *selectedCharacter;
}

@property Character *personagemUm;
@property Character *personagemDois;

- (void) createTerrain;

@end
