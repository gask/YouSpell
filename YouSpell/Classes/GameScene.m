//
//  GameScene.m
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "GameScene.h"
#import "LetterButton.h"

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

- (IBAction)keyPressed:(id)sender
{
    UIButton *buttonPressed = (UIButton *) sender;
    
//    NSLog(@"%@",buttonPressed.titleLabel.text);
    
    LetterButton *l = [[LetterButton alloc] initWithFrame: CGRectMake(20+(keysArray.count+1)*50, self.view.center.y, 50, 50) position:keysArray.count+1 andLetter: buttonPressed.titleLabel.text];
    
    [keysArray addObject: l];
    
    [self.view addSubview:l];
    
}

- (IBAction)finishedWord:(id)sender
{
    for (NSInteger i = 0; i < keysArray.count ; i++)
    {
        const char *guessArray = [theWord UTF8String];
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    semanaquevem = 0;
    keysArray = [NSMutableArray array];
    correctionArray = [NSMutableArray array];
    theWord = @"tiara";
    
    
    [self startLoop];
}

- (void) renderFrame
{
    semanaquevem++;
    
    /*if(semanaquevem == 5)
    {
        LetterButton *l = [[LetterButton alloc] initWithFrame: CGRectMake(self.view.center.x, self.view.center.y, 50, 50) andPosition:0];
        
        [self.view addSubview: l];
    }*/
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
