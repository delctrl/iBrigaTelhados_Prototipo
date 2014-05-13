//
//  Character.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "Character.h"

@implementation Character {
    int matrixVision [5][5];
}

- (id) initWithTexture : (SKTexture *) texture {
    self = [super init];
    self.texture = texture;
    return self;
}

@end
