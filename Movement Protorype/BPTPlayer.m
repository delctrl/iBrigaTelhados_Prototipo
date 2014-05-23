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

- (NSMutableArray *) getAllCharacters {
    return marrCharacters;
}

- (void) setCharacters: (NSMutableArray *) characters {
    marrCharacters = characters;
    
}

- (id)initWithTeamId: (int) teamId{

    self = [super init];
    
    if(self){
        self.nbrTeam = [NSNumber numberWithInt:teamId];
        [self initVision];

    }
    
    return self;
}
<<<<<<< HEAD
/**@bug */
- (void) updateVision {
    [self initVision];
    for (BPTCharacter *charNode in marrCharacters) {
        for (int i = 0; i < charNode.marrMapVision.count; i++) {
            BPTTile *auxPlayerTile = [[self marrMapVision] objectAtIndex:i];
            BPTTile *auxCharTile = [charNode.marrMapVision objectAtIndex:i];
            if (auxCharTile.nbrVisionType < auxPlayerTile.nbrVisionType) {
                auxPlayerTile.nbrVisionType = auxCharTile.nbrVisionType;
                if(auxCharTile.alpha > auxPlayerTile.alpha)
                {
                    auxPlayerTile.alpha = auxCharTile.alpha;
                }
                if(auxPlayerTile.cgpPosAtTileMap.x == charNode.cgpPosAtTileMap.x &&
                   auxPlayerTile.cgpPosAtTileMap.y == charNode.cgpPosAtTileMap.y)
                {
                    auxPlayerTile.alpha = 1;
                }
            }
        }
    }
}

/**@bug */
- (void) initVision {
    self.marrMapVision = [[NSMutableArray alloc] init];
    for(int i=0; i< MAP_H; i++){
        for(int j =0; j < MAP_W; j++){
            BPTTile *visionTile = [[BPTTile alloc] initWithPos: CGPointMake(i, j) AndTexture: nil];
            visionTile.nbrVisionType = [NSNumber numberWithInt:4];
            visionTile.alpha = 0.2;
            [self.marrMapVision addObject:visionTile];
        }
=======
-(void) giveUp{

    for(BPTCharacter *character in marrCharacters){
        character.nbrLife = 0;
>>>>>>> FETCH_HEAD
    }
}
@end
