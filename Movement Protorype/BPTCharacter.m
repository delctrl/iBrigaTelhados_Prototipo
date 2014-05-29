//
//  Character.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//
/** @test @details @note @bug @skip @overload **/


#import "BPTCharacter.h"

@implementation BPTCharacter

@synthesize marrMapVision;

- (id) initWithTexture: (SKTexture *) texture { /** @ref @note Inicia personagem com textura e vida padrão. Lembrando que o correto é iniciar o personagem completamente.**/
    
    self = [super init];
    if (self) {
        self.texture = texture;
        self.nbrLife = [[NSNumber alloc] initWithInt:4]; /** @ref @note Não deveria existir vida padrão **/
        
        [self initVision];
    }
    return self;
}

- (void) initVision { /** @note Inicia a visão do personagem **/
    
    self.marrMapVision = [[NSMutableArray alloc] init];
    for (int i=0; i< MAP_W; i++) {
        for (int j =0; j < MAP_H; j++) {
            BPTTile *visionTile = [[BPTTile alloc] initWithPos: CGPointMake(i, j) AndTexture: nil];
    
            [self.marrMapVision addObject:visionTile];
        }
    }
    
    [self updateVision];
}

- (int) returnTileAtX: (int) x AndAtY: (int) y { /** @note wtf, isso é do personagem? **/
    
    return x*MAP_W + y;
}

- (void) updateVision { /** @note Atualiza a visão do personagem **/
    
    [self resetAlphas];
    
    BPTTile *tileCharacter = [self.marrMapVision objectAtIndex:[self returnTileAtX:self.cgpPosAtTileMap.x AndAtY:self.cgpPosAtTileMap.y]];
    tileCharacter.nbrVisionType = 0;
    for(BPTTile *selectedTile in self.marrMapVision){
        int distance = abs((selectedTile.cgpPosAtTileMap.x - tileCharacter.cgpPosAtTileMap.x)) + abs((selectedTile.cgpPosAtTileMap.y - tileCharacter.cgpPosAtTileMap.y));
        if(distance > 4) {
            distance = 4;
        }
        selectedTile.nbrVisionType = [NSNumber numberWithInt: distance];
        selectedTile.alpha = 1 - (distance *0.2);
    }
}

- (void) resetAlphas { /** @ref @note Reseta o alpha das tiles. Uso de alphas é incorreto. **/
    for(BPTTile *selectedTile in self.marrMapVision){
        selectedTile.alpha = 1;
    }
}

- (id) initWithTexture: (NSString *) textureName arrayPosition: (CGPoint) arrayPosition team: (NSNumber *) team { /** @ref @note Inicia personagem com textura, nome do arquivo da textura, realiza o scale do personagem (que não deveria acontecer), recebe o time e a posição do personagem na tile map. Lembrando que o correto é iniciar o personagem completamente. **/

    self = [self initWithTexture: [SKTexture textureWithImageNamed: textureName]];
    self.strTextureName = textureName;
    self.size = CGSizeMake(WIDTH_TILE*SCALE, WIDTH_TILE*CHAR_SIZE_RATE*SCALE);
    self.cgpPosAtTileMap = arrayPosition;
    self.nbrTeam = team;
    
    return self;
}

- (id) initWithTexture: (NSString *) textureName arrayPosition: (CGPoint) arrayPosition team: (NSNumber *) team hp: (NSNumber *) hp initiative: (NSNumber *) initiative { /** @ref @note Fundir os initWithTextures. Inicializa com todos os outros argumentos, mais a iniciativa e o HP. **/
    
    self = [self initWithTexture: textureName arrayPosition: arrayPosition team: team];
    self.nbrLife = hp;
    self.nbrInitiative = initiative;
    
    return self;
}

- (void) changePositionWithDifferences: (CGPoint) position { /** @ref @note Muda a posição do personagem na tela, o controlador de jogo deveria fazer isso **/
    self.position = CGPointMake(position.x+CHAR_DIFF_X, position.y+(HEIGHT_TILE*CHAR_SIZE_RATE)/2-CHAR_DIFF_Y);
}

/** @skip @note Método desnecessário, uma vez que o personagem é tirado do array do player.
-(void) resetVision {
    
    for(BPTTile *visionTile in self.marrMapVision){
        visionTile.nbrVisionType = [NSNumber numberWithInt:4];
        visionTile.alpha = 0.2;
    }
} **/


@end
