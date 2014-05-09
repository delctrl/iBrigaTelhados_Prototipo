//
//  MyScene.m
//  Prototype Tile
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 05/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        characterIsSelected = FALSE;
        [self createTerrain];
        [self createCharacters];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    if (characterIsSelected) {
        for (UITouch* t in touches) {
            CGPoint touchePoint = [t locationInNode:self];
        
            for (SKNode *node in self.children) {
                if (CGRectContainsPoint (node.frame, touchePoint) && ![node isKindOfClass: [Character class]]) {
                    selectedCharacter.position = CGPointMake(node.position.x+DIFF_X, node.position.y+(W*P*S)/2-DIFF_Y);
                }
            }
        }
        characterIsSelected = FALSE;
    } else {
        for (UITouch* t in touches) {
            CGPoint touchePoint = [t locationInNode:self];
            
            for (SKNode *node in self.children) {
                if (CGRectContainsPoint (node.frame, touchePoint) && [node isKindOfClass: [Character class]]) {
                    selectedCharacter = (Character *) node;
                }
            }
        }
        characterIsSelected = TRUE;
    }
}

- (void) createCharacters {
    
    SKTexture *character = [SKTexture textureWithImageNamed:@"hunter.png"];
    self.personagemUm = [[Character alloc] initWithTexture: character];
    self.personagemUm.size = CGSizeMake(W*S, W*P*S);
    self.personagemUm.position = matriz[1][1].position;
    self.personagemUm.position = CGPointMake(self.personagemUm.position.x + DIFF_X, self.personagemUm.position.y+(W*P*S)/2-DIFF_Y);
    [self addChild:self.personagemUm];
    
    character = [SKTexture textureWithImageNamed:@"medic.png"];
    self.personagemDois = [[Character alloc] initWithTexture: character];
    self.personagemDois.size = CGSizeMake(W*S, W*P*S);
    self.personagemDois.position = matriz[1][1].position;
    self.personagemDois.position = CGPointMake(self.personagemDois.position.x + DIFF_X, self.personagemDois.position.y+(W*P*S)/2-DIFF_Y);
    [self addChild:self.personagemDois];
    
}

- (void) createTerrain {
    SKTexture *grassTile = [SKTexture textureWithImageNamed:@"grass.png"];
    
    for (int i=0; i<5; i++) {
        for (int j=0; j <5 ; j++) {
            SKSpriteNode *tileNode = [[SKSpriteNode alloc] initWithTexture:grassTile];
            tileNode.size = CGSizeMake(W, H);
            tileNode.position = [self getIsoPosition:CGPointMake(i*H, j*H)];
            [self addChild:tileNode];
            matriz[i][j] = tileNode;
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(CGPoint) getIsoPosition:(CGPoint)pt
{
    CGPoint isoPos;
    isoPos.x = pt.x - pt.y;
    isoPos.y = (pt.x + pt.y)/2;
    
    isoPos.x += 370;
    isoPos.y += 370;
    
    return isoPos;
}

-(CGPoint) get2DPosition:(CGPoint)pt
{
    CGPoint pos;
    pos.x = (2*pt.y+pt.x)/2;
    pos.y = (2*pt.y-pt.x)/2;
    return pos;
}

-(CGPoint) getCoordinates : (CGPoint)pt
{
    CGPoint pos;
    pos.x = roundf(pt.x/H);
    pos.y = roundf(pt.y/H);
    return pos;
}

@end
