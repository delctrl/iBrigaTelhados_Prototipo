//
//  MyScene.m
//  Prototype Tile
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 05/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//
/** @test @details @note @bug @skip @overload **/


#import "BPTGameScene.h"

@implementation BPTGameScene


/**@a: Model | @b: View | @c: Controller **/

/**@b**/
- (id) initWithSize: (CGSize) size {
    
    if (self = [super initWithSize:size]) {
        gameController = [[BPTGameController alloc] init];
        
        boolCharacterIsSelected = FALSE;
        
        /** @skip @details createTerrain ainda não  publico **/
        marrTileMatrix = [[gameController mapController] getMap];
        [self addTilesToScene];
        
        [self createCharacters];
        [self resetZPosition];
    }
    
    return self;
}
- (void) update: (CFTimeInterval) currentTime {
    
}
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    
    if (touches.count != 1) {
        return;
    }
    
    if (boolCharacterIsSelected) {
        [self changeCharacterPosition: touches];
    } else {
        [self selectCharacterToBeMoved: touches];
    }
}
- (void) resetZPosition {
    
    NSMutableArray * allCharacters = [[NSMutableArray alloc] init];
    
    for (SKNode *node in self.children) {
        if ([node isKindOfClass: [BPTCharacter class]]) {
            [allCharacters addObject: node];
        }
    }
    
    [allCharacters sortUsingComparator: ^NSComparisonResult(BPTCharacter *char1, BPTCharacter *char2) {
        if (char1.position.y < char2.position.y)
            return (NSComparisonResult)NSOrderedAscending;
        if (char1.position.y > char2.position.y)
            return (NSComparisonResult)NSOrderedDescending;
        return (NSComparisonResult)NSOrderedSame;
        
    }];
    
    int z = allCharacters.count;
    
    for (BPTCharacter *node in allCharacters) {
        [node setZPosition: z];
        z--;
    }
}
- (void) resetAlphas {
    
    for(BPTCharacter *node in self.children){
        if ([node isKindOfClass: [SKSpriteNode class]]) {
            node.alpha = 1;
            if ([node isKindOfClass: [BPTCharacter class]]) {
                node.texture = [SKTexture textureWithImageNamed: node.strTextureName];
            }
        }
    }
    
}
- (void) startShowingVision:(id<BPTObjectWithVision>) objWithVision team:(NSNumber*) nbrTeam{
    
    [self resetAlphas];
    [objWithVision updateVision];
    [self alphaUpdate: objWithVision team:nbrTeam];
}

- (void) alphaUpdate:(id<BPTObjectWithVision>) objWithVision team:(NSNumber*)nbrTeam{
    for(int i = 0; i < marrTileMatrix.count; i++){
        BPTTile *tile1 = [marrTileMatrix objectAtIndex:i];
        BPTTile *tile2 = [objWithVision.marrMapVision objectAtIndex:i];
        if (tile1.nbrIsOccupiedByTeam > 0) {
            for (BPTCharacter * charNode in self.children) {
                if ([charNode isKindOfClass: [BPTCharacter class]] && CGRectContainsPoint (charNode.frame, tile1.position)) {
                    if (charNode.nbrTeam != nbrTeam && CGPointEqualToPoint(charNode.cgpPosAtTileMap, tile1.cgpPosAtTileMap)) {
                        if ([tile2.nbrVisionType integerValue] == 4) {
                            charNode.alpha = 0;
                        }
                        if ([tile2.nbrVisionType integerValue] == 3) {
                            charNode.alpha = 1;
                            charNode.texture = [SKTexture textureWithImageNamed:@"oculto.png"];;
                        }
                        if ([tile2.nbrVisionType integerValue] == 2) {
                            charNode.alpha = tile2.alpha;
                        }
                    }
                }
            }
        }
        tile1.alpha = tile2.alpha;
    }

}

- (void) startShowingMovableTiles {
    
    marrTilesEnabled = [[NSMutableArray alloc] init];
    
    BPTTile * tileAux;
    CGPoint aux;
    int bounds = 0;
    
    for (int i = -1; i<2; i++) {
        if (i == 0) {
            continue;
        }
        
        if (i > 0) {
            bounds = 4;
        }
        
        if (charSelectedCharacter.cgpPosAtTileMap.x != bounds) {
            aux = CGPointMake(charSelectedCharacter.cgpPosAtTileMap.x+i, charSelectedCharacter.cgpPosAtTileMap.y);
            tileAux = [[gameController mapController]returnTileAtPosition: aux ];
            if (![gameController checkIfThereIsACharacterAtPosition: tileAux.cgpPosAtTileMap SelectedCharacter:charSelectedCharacter]) {
                [marrTilesEnabled addObject: [[gameController mapController] returnTileAtPosition:aux]];
            }
        }
        if (charSelectedCharacter.cgpPosAtTileMap.y != bounds) {
            aux = CGPointMake(charSelectedCharacter.cgpPosAtTileMap.x, charSelectedCharacter.cgpPosAtTileMap.y+i);
            tileAux = [[gameController mapController] returnTileAtPosition: aux];
            if (![gameController checkIfThereIsACharacterAtPosition: tileAux.cgpPosAtTileMap SelectedCharacter:charSelectedCharacter]) {
                [marrTilesEnabled addObject: [[gameController mapController] returnTileAtPosition: aux]];
            }
        }
    }

    
    for (BPTTile * node in marrTilesEnabled) {
        if (node.nbrIsOccupiedByTeam > 0) {
            node.texture = [SKTexture textureWithImageNamed:@"enemyGrass.png"];
        } else {
            node.texture = [SKTexture textureWithImageNamed:@"selectedGrass.png"];
        }

    }
}
- (void) createCharacters {
    
    NSMutableArray *gameCharacters = [[NSMutableArray alloc] init];
    
    [gameCharacters addObjectsFromArray: [gameController getAllCharacters]];
    
    for (BPTCharacter * charNode in gameCharacters) {
        [charNode changePositionWithDifferences:[[gameController mapController] returnTileAtPosition:charNode.cgpPosAtTileMap].position];
        [[gameController mapController] returnTileAtPosition: charNode.cgpPosAtTileMap].nbrIsOccupiedByTeam = charNode.nbrTeam;
        [self addChild: charNode];
    }
}
- (void) selectCharacterToBeMoved: (NSSet *) touches {
    
    for (UITouch* t in touches) {
        CGPoint touchePoint = [t locationInNode:self];
        
        charSelectedCharacter = [gameController checkIfCharacterWasSelectedOnPoint:touchePoint andChildrenArray:self.children];
        if(charSelectedCharacter)
        {
            boolCharacterIsSelected = TRUE;
            [self startShowingMovableTiles];
            [self startShowingVision:charSelectedCharacter team:charSelectedCharacter.nbrTeam];
        }
        else{
            boolCharacterIsSelected = FALSE;
        }
    }
}
- (void) changeCharacterPosition: (NSSet *) touches {
    
    for (UITouch* t in touches) {
        CGPoint touchePoint = [t locationInNode:self];
        
        charSelectedCharacter = [gameController checkCharacterToBeMoved:charSelectedCharacter AndPoint:touchePoint onMovimentArray:marrTilesEnabled andCharacterArray:self.children];
    }
    boolCharacterIsSelected = FALSE;
    
    [self resetAlphas];
    
    for (SKSpriteNode * node in marrTilesEnabled) {
        node.texture = [SKTexture textureWithImageNamed:@"grass.png"];
    }
    
    [marrTilesEnabled removeAllObjects];
    [self resetZPosition];
    
    [self updateAllCharactersVision];
    /**@details trocar para o jogador atual*/
    [self startShowingVision:[gameController playerOne] team:[gameController playerOne].nbrTeam];
}
- (void) addTilesToScene {
    for (SKNode *n in marrTileMatrix) {
        [self addChild:n];
    }
}

-(void)updateAllCharactersVision
{
    for (SKNode *node in self.children) {
        if ([node class] == [BPTCharacter class]) {
            BPTCharacter *character = (BPTCharacter*)node;
            [character updateVision];
        }
    }
}

@end
