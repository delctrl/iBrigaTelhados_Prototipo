//
//  BPTObjectWithVision.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 23/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BPTObjectWithVision <NSObject>

@property NSMutableArray* marrMapVision;

-(void)initVision;
-(void)updateVision;

@end
