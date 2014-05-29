//
//  Tile.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 09/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import "BPTImportsDefines.h"

@interface BPTTile : SKSpriteNode

@property CGPoint cgpPosAtTileMap; /** @note Posição da tile na matriz do mapa **/

@property NSNumber *nbrVisionType; /** @note Tipo de visão da tile, sendo: 0 = Personagem; 1 = Inimigo detalhado; 2 = Inimigo sem detalhes; 3 = Sombra; 4 = Breu **/

@property NSNumber *nbrIsOccupiedByTeam; /** @note Qual time está ocupando a tile, sendo: 0 = Nenhum ou NPC; N = Número do Time **/


/** @skip @note Label para printar na tela as coordenadas da tile na matriz.
@property SKLabelNode *lblCoords; **/

- (id) initWithPos: (CGPoint) position AndTexture: (SKTexture *) texture;
@end
