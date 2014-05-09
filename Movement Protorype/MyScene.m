//
//  MyScene.m
//  Prototype Tile
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 05/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id) initWithSize : (CGSize) size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        characterIsSelected = FALSE;
        [self createTerrain];
        [self createCharacters];
        
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
        
        for (SKNode *node in self.children) {
            if (CGRectContainsPoint (node.frame, touchePoint) && ![node isKindOfClass: [Character class]]) {
                selectedCharacter.position = CGPointMake(node.position.x+DIFF_X, node.position.y+(W*P*S)/2-DIFF_Y);
                selectedCharacter = nil;
                characterIsSelected = FALSE;
                break;
            }
        }
    }
    [self compareZPosition];
}

- (void) selectCharacterToBeMoved : (NSSet *) touches {
    for (UITouch* t in touches) {
        CGPoint touchePoint = [t locationInNode:self];
        
        for (SKNode *node in self.children) {
            if (CGRectContainsPoint (node.frame, touchePoint) && [node isKindOfClass: [Character class]]) {
                selectedCharacter = (Character *) node;
                characterIsSelected = TRUE;
                [self startShowingMovableTiles];
                break;
            }
        }
    }
}

- (void) startShowingMovableTiles {
    
}

- (void) createCharacters {
    
    SKTexture *character = [SKTexture textureWithImageNamed:@"hunter.png"];
    self.personagemUm = [[Character alloc] initWithTexture: character];
    self.personagemUm.size = CGSizeMake(W*S, W*P*S);
    self.personagemUm.position = [self returnTileAtPosition:0 :0].position;
    self.personagemUm.position = CGPointMake(self.personagemUm.position.x + DIFF_X, self.personagemUm.position.y+(W*P*S)/2-DIFF_Y);
    self.personagemUm.posAtTileMap = CGPointMake(0, 0);
    [self addChild:self.personagemUm];
    
    character = [SKTexture textureWithImageNamed:@"medic.png"];
    self.personagemDois = [[Character alloc] initWithTexture: character];
    self.personagemDois.size = CGSizeMake(W*S, W*P*S);
    self.personagemDois.position = [self returnTileAtPosition:2 :2].position;
    self.personagemDois.position = CGPointMake(self.personagemDois.position.x + DIFF_X, self.personagemDois.position.y+(W*P*S)/2-DIFF_Y);
    self.personagemUm.posAtTileMap = CGPointMake(2, 2);
    [self addChild:self.personagemDois];
    
}

- (void) createTerrain {
    tileMatrix = [[NSMutableArray alloc] init];
    SKTexture *grassTile = [SKTexture textureWithImageNamed:@"grass.png"];
    
    for (int i=0; i<5; i++) {
        for (int j=0; j <5 ; j++) {
            Tile *tileNode = [[Tile alloc] initWithPos: CGPointMake(i, j) : grassTile];
            tileNode.size = CGSizeMake(W, H);
            tileNode.position = [self getIsoPosition:CGPointMake(i*H, j*H)];
            [tileMatrix addObject: tileNode];
            [self addChild:tileNode];
        }
    }
}

- (Tile *) returnTileAtPosition : (int) i : (int) j {
    return [tileMatrix objectAtIndex: 5*i+j];
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
    pos.x = roundf(pt.x/H);
    pos.y = roundf(pt.y/H);
    return pos;
}

@end
