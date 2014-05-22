//
//  BPTPlayer.h
//  Movement Protorype
//
//  Created by LEONARDO LEGRADY SALGADO GIGLIOTTI on 15/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPTPlayer : NSObject {
    NSMutableArray *marrCharacters;

}


@property int teamId;

- (void) setCharacters: (NSMutableArray *) characters;
- (NSMutableArray *) getAllCharacters;
- (id)initWithTeamId: (int) teamId;
@end
