//
//  GameScene.h
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface GameScene : UIViewController
{
    NSTimer *timer;
    
    BOOL gameWon;
    
    NSInteger positionSelected;
    NSInteger levelSelected;
    
    NSMutableArray *keysArray;
    NSMutableArray *correctionArray;
    
    SystemSoundID sound;
    
    NSInteger correctKeyIndex;
    NSMutableArray *correctArrayKeys;
    NSMutableArray *sceneButtons;
}

@property NSString *theWord;

- (IBAction)playWord:(id)sender;
- (IBAction)finishedWord:(id)sender;

@end
