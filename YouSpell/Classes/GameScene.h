//
//  GameScene.h
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameScene : UIViewController
{
    BOOL running;
    NSTimer *timer;
    NSInteger semanaquevem;
    
    NSMutableArray *keysArray;
}
@end
