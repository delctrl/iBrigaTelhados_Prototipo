//
//  BPTPlayer.m
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import "BPTPlayer.h"

@implementation BPTPlayer

- (NSMutableArray *) getAllCharacters {
    return marrCharacters;
}

- (void) setCharacters: (NSMutableArray *) characters {
    marrCharacters = characters;
    
}

- (id)initWithTeamId: (int) teamId{

    self = [super init];
    
    if(self){
        self.teamId = teamId;
    }
    
    return self;
}
@end
