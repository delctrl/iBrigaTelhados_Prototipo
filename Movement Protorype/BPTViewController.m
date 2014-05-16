//
//  ViewController.m
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 08/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//
/** @test @details @note @bug @skip @overload **/


#import "BPTViewController.h"
#import "BPTGameScene.h"

@implementation BPTViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *) self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    BPTGameScene * scene = [BPTGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
}

- (BOOL) shouldAutorotate {
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
