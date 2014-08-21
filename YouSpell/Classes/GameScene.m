//
//  GameScene.m
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@end

@implementation GameScene

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self startLoop];
}

- (void) renderFrame
{
    
}


- (void) gameLoop
{
    while (running)
    {
        [self renderFrame];
    }
}

- (void) startLoop
{
    running = YES;
#ifdef THREADED_ANIMATION
    [NSThread detachNewThreadSelector:@selector(gameLoop)
                             toTarget:self withObject:nil];
#else
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60
                                             target:self selector:@selector(renderFrame) userInfo:nil repeats:YES];
#endif
}

- (void) stopLoop
{
    [timer invalidate];
    running = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
