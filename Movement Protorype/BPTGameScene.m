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
        
        [self createTerrain];
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
    
    for(SKSpriteNode *node in self.children){
        if ([node isKindOfClass: [SKSpriteNode class]]) {
            node.alpha = 1;
            if ([node isKindOfClass: [BPTCharacter class]]) {
                BPTCharacter *aux = (BPTCharacter *) node;
                aux.texture = [SKTexture textureWithImageNamed: aux.strTextureName];
            }
        }
    }
    
}
- (void) startShowingCharacterVision {
    
    [self resetAlphas];
    [charSelectedCharacter updateCharacterVision];
    
    for(int i = 0; i < marrTileMatrix.count; i++){
        BPTTile *tile1 = [marrTileMatrix objectAtIndex:i];
        BPTTile *tile2 = [charSelectedCharacter.marrCharMapVision objectAtIndex:i];
        if (tile1.nbrIsOccupiedByTeam > 0) {
            for (BPTCharacter * charNode in self.children) {
                if ([charNode isKindOfClass: [BPTCharacter class]] && CGRectContainsPoint (charNode.frame, tile1.position)) {
                    if (charNode.nbrTeam != charSelectedCharacter.nbrTeam && CGPointEqualToPoint(charNode.cgpPosAtTileMap, tile1.cgpPosAtTileMap)) {
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
    
    if (charSelectedCharacter.cgpPosAtTileMap.x != 4) {
        aux = CGPointMake(charSelectedCharacter.cgpPosAtTileMap.x+1, charSelectedCharacter.cgpPosAtTileMap.y);
        tileAux = [self returnTileAtPosition: aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.cgpPosAtTileMap]) {
            [marrTilesEnabled addObject: [self returnTileAtPosition:aux]];
        }
    }
    
    if (charSelectedCharacter.cgpPosAtTileMap.x != 0) {
        aux = CGPointMake(charSelectedCharacter.cgpPosAtTileMap.x-1, charSelectedCharacter.cgpPosAtTileMap.y);
        tileAux = [self returnTileAtPosition:aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.cgpPosAtTileMap]) {
            [marrTilesEnabled addObject: [self returnTileAtPosition:aux]];
        }
    }
    
    if (charSelectedCharacter.cgpPosAtTileMap.y != 4) {
        aux = CGPointMake(charSelectedCharacter.cgpPosAtTileMap.x, charSelectedCharacter.cgpPosAtTileMap.y+1);
        tileAux = [self returnTileAtPosition: aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.cgpPosAtTileMap]) {
            [marrTilesEnabled addObject: [self returnTileAtPosition: aux]];
        }
    }
    
    if (charSelectedCharacter.cgpPosAtTileMap.y != 0) {
        aux = CGPointMake(charSelectedCharacter.cgpPosAtTileMap.x, charSelectedCharacter.cgpPosAtTileMap.y-1);
        tileAux = [self returnTileAtPosition :aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.cgpPosAtTileMap]) {
            [marrTilesEnabled addObject: [self returnTileAtPosition: aux]];
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
- (BPTTile *) returnTileAtPosition: (CGPoint) pointAtMatrix {
    
    return [marrTileMatrix objectAtIndex: 5*pointAtMatrix.x+pointAtMatrix.y];
}
- (CGPoint) getIsoPosition: (CGPoint) pt {
    
    CGPoint isoPos;
    isoPos.x = pt.x - pt.y;
    isoPos.y = (pt.x + pt.y)/2;
    
    isoPos.x += 370;
    isoPos.y += 370;
    
    return isoPos;
}
- (CGPoint) get2DPosition: (CGPoint) pt {
    CGPoint pos;
    pos.x = (2*pt.y+pt.x)/2;
    pos.y = (2*pt.y-pt.x)/2;
    return pos;
}
- (CGPoint) getCoordinates: (CGPoint) pt {
    CGPoint pos;
    pos.x = roundf(pt.x/HEIGHT_TILE);
    pos.y = roundf(pt.y/HEIGHT_TILE);
    return pos;
}
- (void) createCharacters {
    
    NSMutableArray *gameCharacters = [[NSMutableArray alloc] init];
    
    [gameCharacters addObjectsFromArray: [gameController getAllCharacters]];
    
    for (BPTCharacter * charNode in gameCharacters) {
        [charNode changePositionWithDifferences:[self returnTileAtPosition:charNode.cgpPosAtTileMap].position];
        [self returnTileAtPosition: charNode.cgpPosAtTileMap].nbrIsOccupiedByTeam = charNode.nbrTeam;
        [self addChild: charNode];
    }
}

/**@c**/
- (BOOL) checkIfThereIsACharacterAtPosition: (CGPoint) position {
    
    if ([self returnTileAtPosition:position].nbrIsOccupiedByTeam == charSelectedCharacter.nbrTeam) {
        return TRUE;
    }
    
    return FALSE;
}
- (void) selectCharacterToBeMoved: (NSSet *) touches {
    
    for (UITouch* t in touches) {
        CGPoint touchePoint = [t locationInNode:self];
        
        for (SKNode *node in self.children) {
            if (CGRectContainsPoint (node.frame, touchePoint) && [node isKindOfClass: [BPTCharacter class]]) {
                charSelectedCharacter = (BPTCharacter *) node;
                boolCharacterIsSelected = TRUE;
                [self startShowingMovableTiles];
                [self startShowingCharacterVision];
                break;
            }
        }
    }
}
- (void) checkPushMovementForTile: (BPTTile *) tile AndCharacter: (BPTCharacter *) character {
    
    BPTTile* tileAux = [[BPTTile alloc] init];
    CGPoint aux;
    
    if (character.cgpPosAtTileMap.x - charSelectedCharacter.cgpPosAtTileMap.x == 1) {
        if (character.cgpPosAtTileMap.x == 4) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.cgpPosAtTileMap.x+1, character.cgpPosAtTileMap.y);
    } else if (character.cgpPosAtTileMap.x - charSelectedCharacter.cgpPosAtTileMap.x == -1) {
        if (character.cgpPosAtTileMap.x == 0) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.cgpPosAtTileMap.x-1, character.cgpPosAtTileMap.y);
    } else if (character.cgpPosAtTileMap.y - charSelectedCharacter.cgpPosAtTileMap.y == 1) {
        if (character.cgpPosAtTileMap.y == 4) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.cgpPosAtTileMap.x, character.cgpPosAtTileMap.y+1);
    } else if (character.cgpPosAtTileMap.y - charSelectedCharacter.cgpPosAtTileMap.y == -1) {
        if (character.cgpPosAtTileMap.y == 0) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.cgpPosAtTileMap.x, character.cgpPosAtTileMap.y-1);
    }
    
    tileAux = [self returnTileAtPosition: aux];
    [character changePositionWithDifferences:tileAux.position];
    
    character.cgpPosAtTileMap = tileAux.cgpPosAtTileMap;
    tileAux.nbrIsOccupiedByTeam = character.nbrTeam;
}
- (void) changeCharacterPosition: (NSSet *) touches {
    
    for (UITouch* t in touches) {
        CGPoint touchePoint = [t locationInNode:self];
        
        for (BPTTile *node in marrTilesEnabled) {
            if (CGRectContainsPoint (node.frame, touchePoint)) {
                [self returnTileAtPosition:charSelectedCharacter.cgpPosAtTileMap].nbrIsOccupiedByTeam = 0;
                
                if (node.nbrIsOccupiedByTeam > 0) {
                    for (BPTCharacter * charNode in self.children) {
                        if ([charNode isKindOfClass: [BPTCharacter class]] && CGRectContainsPoint (charNode.frame, node.position)) {
                            [self checkPushMovementForTile: node AndCharacter: charNode];
                        }
                    }
                }
                
                [charSelectedCharacter changePositionWithDifferences:node.position];
                charSelectedCharacter.cgpPosAtTileMap = node.cgpPosAtTileMap;
                node.nbrIsOccupiedByTeam = charSelectedCharacter.nbrTeam;
                charSelectedCharacter = nil;
                break;
                
            }
        }
    }
    boolCharacterIsSelected = FALSE;
    
    [self resetAlphas];
    
    for (SKSpriteNode * node in marrTilesEnabled) {
        node.texture = [SKTexture textureWithImageNamed:@"grass.png"];
    }
    
    [marrTilesEnabled removeAllObjects];
    [self resetZPosition];
}

@end
