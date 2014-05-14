//
//  MyScene.m
//  Prototype Tile
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 05/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Jogo.h"

@implementation Jogo


-(id) initWithSize : (CGSize) size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        characterIsSelected = FALSE;
        [self createTerrain];
        [self createCharacters];
        [self compareZPosition];
    }
    return self;
}

- (void) update :(CFTimeInterval) currentTime {
    /* Called before each frame is rendered */
}

- (void) compareZPosition {
    NSMutableArray * allCharacters = [[NSMutableArray alloc] init];
    for (SKNode *node in self.children) {
        if ([node isKindOfClass: [Character class]]) {
            [allCharacters addObject: node];
        }
    }
    
    [allCharacters sortUsingComparator: ^NSComparisonResult(Character *char1, Character *char2) {
        if (char1.position.y < char2.position.y)
            return (NSComparisonResult)NSOrderedAscending;
        if (char1.position.y > char2.position.y)
            return (NSComparisonResult)NSOrderedDescending;
        return (NSComparisonResult)NSOrderedSame;
        
    }];
    
    int z = allCharacters.count;
    for (Character *node in allCharacters) {
        [node setZPosition: z];
        z--;
    }
}

-(void) touchesBegan : (NSSet *) touches withEvent : (UIEvent *) event {
    /* Called when a touch begins */
    if (touches.count != 1) {
        return;
    }
    
    if (characterIsSelected) {
        [self changeCharacterPosition: touches];
    } else {
        [self selectCharacterToBeMoved: touches];
    }
}




- (void) changeCharacterPosition : (NSSet *) touches {
    for (UITouch* t in touches) {
        CGPoint touchePoint = [t locationInNode:self];
        
        for (Tile *node in tilesEnabled) {
            if (CGRectContainsPoint (node.frame, touchePoint)) {
                [self returnTileAtPosition:selectedCharacter.posAtTileMap].isOccupiedByTeam = 0;
                
                if (node.isOccupiedByTeam > 0) {
                    for (Character * charNode in self.children) {
                        if ([charNode isKindOfClass: [Character class]] && CGRectContainsPoint (charNode.frame, node.position)) {
                            [self checkPushMovement : node : charNode];
                        }
                    }
                }
                
                [selectedCharacter changePositionWithDifferences:node.position];
                selectedCharacter.posAtTileMap = node.positionAtTileMap;
                node.isOccupiedByTeam = selectedCharacter.team;
                selectedCharacter = nil;
                break;
                
            }
        }
    }
    characterIsSelected = FALSE;

    [self resetAlphas];

    for (SKSpriteNode * node in tilesEnabled) {
        node.texture = [SKTexture textureWithImageNamed:@"grass.png"];
    }

    [tilesEnabled removeAllObjects];
    [self compareZPosition];
}




- (void) checkPushMovement : (Tile *) tile : (Character *) character {
    Tile* tileAux = [[Tile alloc] init];
    CGPoint aux;
    
    if (character.posAtTileMap.x - selectedCharacter.posAtTileMap.x == 1) {
        if (character.posAtTileMap.x == 4) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.posAtTileMap.x+1, character.posAtTileMap.y);
    } else if (character.posAtTileMap.x - selectedCharacter.posAtTileMap.x == -1) {
        if (character.posAtTileMap.x == 0) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.posAtTileMap.x-1, character.posAtTileMap.y);
    } else if (character.posAtTileMap.y - selectedCharacter.posAtTileMap.y == 1) {
        if (character.posAtTileMap.y == 4) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.posAtTileMap.x, character.posAtTileMap.y+1);
    } else if (character.posAtTileMap.y - selectedCharacter.posAtTileMap.y == -1) {
        if (character.posAtTileMap.y == 0) {
            [character removeFromParent];
            return;
        }
        aux = CGPointMake(character.posAtTileMap.x, character.posAtTileMap.y-1);
    }
    tileAux = [self returnTileAtPosition: aux];
    [character changePositionWithDifferences:tileAux.position];
    character.posAtTileMap = tileAux.positionAtTileMap;
    tileAux.isOccupiedByTeam = character.team;
}



- (void) selectCharacterToBeMoved : (NSSet *) touches {
    for (UITouch* t in touches) {
        CGPoint touchePoint = [t locationInNode:self];
        
        for (SKNode *node in self.children) {
            if (CGRectContainsPoint (node.frame, touchePoint) && [node isKindOfClass: [Character class]]) {
                selectedCharacter = (Character *) node;
                characterIsSelected = TRUE;
                [self startShowingMovableTiles];
                [self startShowingCharacterVision];
                break;
            }
        }
    }
}


- (void) startShowingCharacterVision {
    
    [self resetAlphas];
    [selectedCharacter updateCharacterVision];
    for(int i = 0; i < tileMatrix.count; i++){
        Tile *tile1 = [tileMatrix objectAtIndex:i];
        Tile *tile2 = [selectedCharacter.charMapVision objectAtIndex:i];
        if (tile1.isOccupiedByTeam > 0) {
            for (Character * charNode in self.children) {
                if ([charNode isKindOfClass: [Character class]] && CGRectContainsPoint (charNode.frame, tile1.position)) {
                    if (charNode.team != selectedCharacter.team && CGPointEqualToPoint(charNode.posAtTileMap, tile1.positionAtTileMap)) {
                        if (tile2.visionType == 4) {
                            charNode.alpha = 0;
                        }
                        if (tile2.visionType == 3) {
                            charNode.alpha = 1;
                            charNode.texture = [SKTexture textureWithImageNamed:@"oculto.png"];;
                        }
                        if (tile2.visionType == 2) {
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
    tilesEnabled = [[NSMutableArray alloc] init];
    
    Tile * tileAux;
    CGPoint aux;
    if (selectedCharacter.posAtTileMap.x != 4) {
        aux = CGPointMake(selectedCharacter.posAtTileMap.x+1, selectedCharacter.posAtTileMap.y);
        tileAux = [self returnTileAtPosition: aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.positionAtTileMap]) {
            [tilesEnabled addObject: [self returnTileAtPosition:aux]];
        }
    }
    if (selectedCharacter.posAtTileMap.x != 0) {
        aux = CGPointMake(selectedCharacter.posAtTileMap.x-1, selectedCharacter.posAtTileMap.y);
        tileAux = [self returnTileAtPosition:aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.positionAtTileMap]) {
            [tilesEnabled addObject: [self returnTileAtPosition:aux]];
        }
    }
    if (selectedCharacter.posAtTileMap.y != 4) {
        aux = CGPointMake(selectedCharacter.posAtTileMap.x, selectedCharacter.posAtTileMap.y+1);
        tileAux = [self returnTileAtPosition: aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.positionAtTileMap]) {
            [tilesEnabled addObject: [self returnTileAtPosition: aux]];
        }
    }
    if (selectedCharacter.posAtTileMap.y != 0) {
        aux = CGPointMake(selectedCharacter.posAtTileMap.x, selectedCharacter.posAtTileMap.y-1);
        tileAux = [self returnTileAtPosition :aux];
        if (![self checkIfThereIsACharacterAtPosition: tileAux.positionAtTileMap]) {
            [tilesEnabled addObject: [self returnTileAtPosition: aux]];
        }
    }
    
    for (Tile * node in tilesEnabled) {
        if (node.isOccupiedByTeam > 0) {
            node.texture = [SKTexture textureWithImageNamed:@"enemyGrass.png"];
        } else {
            node.texture = [SKTexture textureWithImageNamed:@"selectedGrass.png"];
        }

    }
}

- (BOOL) checkIfThereIsACharacterAtPosition : (CGPoint) position {
    if ([self returnTileAtPosition:position].isOccupiedByTeam == selectedCharacter.team) {
        return TRUE;
    }
    return FALSE;
}

- (void) createCharacters {
    CGPoint pointAux;
    
    pointAux = CGPointMake(0, 0);
    self.character01 = [[Character alloc] initWithTexture:@"hunter"
                                             nodePosition:[self returnTileAtPosition:pointAux].position
                                            arrayPosition:pointAux
                                                     team:1];
    [self returnTileAtPosition:pointAux].isOccupiedByTeam = self.character01.team;
    [self addChild:self.character01];
    
    
    
    pointAux = CGPointMake(2, 2);
    self.character02 = [[Character alloc] initWithTexture:@"medic"
                                             nodePosition:[self returnTileAtPosition:pointAux].position
                                            arrayPosition:pointAux
                                                     team:2];
    [self returnTileAtPosition:pointAux].isOccupiedByTeam = self.character02.team;
    [self addChild:self.character02];
    
    pointAux = CGPointMake(3, 3);
    self.character02 = [[Character alloc] initWithTexture:@"medic"
                                             nodePosition:[self returnTileAtPosition:pointAux].position
                                            arrayPosition:pointAux
                                                     team:2];
    [self returnTileAtPosition:pointAux].isOccupiedByTeam = self.character02.team;
    [self addChild:self.character02];
}

- (void) createTerrain {
    tileMatrix = [[NSMutableArray alloc] init];
    SKTexture *grassTile = [SKTexture textureWithImageNamed:@"grass.png"];
    
    for (int i=0; i<5; i++) {
        for (int j=0; j <5 ; j++) {
            Tile *tileNode = [[Tile alloc] initWithPos: CGPointMake(i, j) : grassTile];
            tileNode.size = CGSizeMake(WIDTH_TILE, HEIGHT_TILE);
            tileNode.position = [self getIsoPosition:CGPointMake(i*HEIGHT_TILE, j*HEIGHT_TILE)];
            tileNode.isOccupiedByTeam = 0;
            [tileMatrix addObject: tileNode];
            [self addChild:tileNode];
        }
    }
}

- (Tile *) returnTileAtPosition : (CGPoint) pointAtMatrix{
    return [tileMatrix objectAtIndex: 5*pointAtMatrix.x+pointAtMatrix.y];
}

- (CGPoint) getIsoPosition : (CGPoint) pt {
    CGPoint isoPos;
    isoPos.x = pt.x - pt.y;
    isoPos.y = (pt.x + pt.y)/2;
    
    isoPos.x += 370;
    isoPos.y += 370;
    
    return isoPos;
}

- (CGPoint) get2DPosition : (CGPoint) pt {
    CGPoint pos;
    pos.x = (2*pt.y+pt.x)/2;
    pos.y = (2*pt.y-pt.x)/2;
    return pos;
}

- (CGPoint) getCoordinates : (CGPoint) pt {
    CGPoint pos;
    pos.x = roundf(pt.x/HEIGHT_TILE);
    pos.y = roundf(pt.y/HEIGHT_TILE);
    return pos;
}

-(void)resetAlphas{
    
    for(SKSpriteNode *node in self.children){
        if ([node isKindOfClass: [SKSpriteNode class]]) {
            node.alpha = 1;
            if ([node isKindOfClass: [Character class]]) {
                Character *aux = (Character *) node;
                aux.texture = [SKTexture textureWithImageNamed: aux.textureName];
            }
        }
    }
    
}

@end
