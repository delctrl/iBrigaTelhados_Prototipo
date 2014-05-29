//
//  Tile.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 09/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//
/** @test @details @note @bug @skip @overload @ref **/


#import "BPTTile.h"

@implementation BPTTile

- (id) initWithPos: (CGPoint) position AndTexture: (SKTexture *) texture { /** @note Inicia a tile, com posição na matriz do mapa, o tipo de visão base e textura da tile. **/
    self = [super initWithTexture: texture];
    self.cgpPosAtTileMap = position;
    self.nbrVisionType = [NSNumber numberWithInt:4];
    
    
    /** @skip @note Printa na tela as coordenadas da tile, dentro da matriz mãe. Usado para debug.
//    self.lblCoords = [[SKLabelNode alloc] init];
//    self.lblCoords.text =[NSString stringWithFormat:@"%.f , %.f",position.x, position.y];
//    self.lblCoords.fontSize = 20;
//    self.lblCoords.position = CGPointMake(0, 0);
//    [self addChild:self.lblCoords]; **/
    return self;
}

@end
