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
    BOOL running;
    NSTimer *timer;
    NSInteger semanaquevem;
    NSInteger positionSelected;
    
    NSMutableArray *keysArray;
    NSMutableArray *correctionArray;
    NSString *theWord;
    
    SystemSoundID sound;
}

- (IBAction)playWord:(id)sender;
- (IBAction)finishedWord:(id)sender;

@end
