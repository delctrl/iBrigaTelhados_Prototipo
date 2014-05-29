//
//  BPTPlayer.m
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTPlayer.h"
#import "BPTCharacter.h"

@implementation BPTPlayer

@synthesize marrMapVision;

- (NSMutableArray *) getAllCharacters { /** @note Retorna os personagens do time. **/
    return marrCharacters;
}

- (void) setCharacters: (NSMutableArray *) characters { /** @note Inicia com o número do time. O player deveria ser criado no controlador, já com os personagens, pois eventualmente existirá um controlador de partidas. **/
    marrCharacters = characters;
    
}

- (id)initWithTeamId: (int) teamId{ /** @note Inicia com o número do time. **/

    self = [super init];
    
    if(self){
        self.nbrTeam = [NSNumber numberWithInt:teamId];
        [self initVision];

    }
    
    return self;
}

- (void) updateVision { /** @ref @note Atualiza a visão do jogador. Levando em conta que o esquema de alphas é errado. **/
    [self initVision];
    for (BPTCharacter *charNode in marrCharacters) {
        for (int i = 0; i < charNode.marrMapVision.count; i++) {
            BPTTile *auxPlayerTile = [[self marrMapVision] objectAtIndex:i];
            BPTTile *auxCharTile = [charNode.marrMapVision objectAtIndex:i];
            if (auxCharTile.nbrVisionType < auxPlayerTile.nbrVisionType) {
                auxPlayerTile.nbrVisionType = auxCharTile.nbrVisionType;
            }
            if(auxCharTile.alpha > auxPlayerTile.alpha)
            {
                auxPlayerTile.alpha = auxCharTile.alpha;
            }
        }
    }
}

- (void) initVision { /** @ref @note Inicia a visão do jogador. Levando em conta que o esquema de alphas é errado. **/
    self.marrMapVision = [[NSMutableArray alloc] init];
    for(int i=0; i< MAP_H; i++){
        for(int j =0; j < MAP_W; j++){
            BPTTile *visionTile = [[BPTTile alloc] initWithPos: CGPointMake(i, j) AndTexture: nil];
            visionTile.nbrVisionType = [NSNumber numberWithInt:4];
            visionTile.alpha = 0.2;
            [self.marrMapVision addObject:visionTile];
        }
    }
    
}

-(void) giveUp { /** @ref @note Faz com que o jogador perca. Deveria ser do controlador, sendo que o certo não é setar a vida para 0 e sim tirar todos os personagens do array. **/
    for (BPTCharacter *character in marrCharacters) {
        character.nbrLife = 0;
    }
}

- (void) removeCharacter: (BPTCharacter *) character { /** @note Remove um personagem do vetor de personagens vivos **/
    [marrCharacters removeObject: character];
}

@end
