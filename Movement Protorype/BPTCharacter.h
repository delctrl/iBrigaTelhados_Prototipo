//
//  Character.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import "BPTImportsDefines.h"
#import "BPTTile.h"
#import "BPTObjectWithVision.h"

@interface BPTCharacter : SKSpriteNode <BPTObjectWithVision>

@property NSNumber *nbrTeam; /** @note Qual time ele faz parte, sendo: 0 = Nenhum ou NPC; N = Número do Time **/
@property NSString *strTextureName; /** @note Nome do arquivo usado para a textura do personagem **/
@property CGPoint cgpPosAtTileMap; /** @note Posição do personagem na tile map **/
@property NSNumber *nbrLife; /** @note Vida do personagem **/
@property NSNumber *nbrDefense; /** @note Defesa do personagem **/
@property NSNumber *nbrAttack; /** @note Ataque do personagem **/
@property NSNumber *nbrInitiative; /** @note Iniciativa do personagem **/

- (id) initWithTexture : (SKTexture *) texture;
- (id) initWithTexture: (NSString*) textureName arrayPosition: (CGPoint) arrayPosition team: (NSNumber *) team;
- (void) changePositionWithDifferences: (CGPoint) position;

/** @skip
- (void) resetVision; **/
@end
