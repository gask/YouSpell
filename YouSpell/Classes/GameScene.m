//
//  GameScene.m
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "GameScene.h"
#import "LetterButton.h"
@import AVFoundation;

#define SPACE 300.0f
#define INITIAL_LETTERSIZE 50.0f

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

- (IBAction)keyPressed:(UIButton *)buttonPressed
{
    //NSLog(@"posSel: %i keysCount: %i", positionSelected, keysArray.count);
    if(positionSelected <= (NSInteger)keysArray.count && positionSelected != 0)
    {
//        NSLog(@"editar!");
        
        LetterButton *l = (LetterButton *)[keysArray objectAtIndex:positionSelected-1];
        
        [l setTitle:buttonPressed.titleLabel.text forState: UIControlStateNormal];
        
        [self handleFlushWithPos:keysArray.count+1];
    }
    else
    {
//        NSLog(@"adicionar!");
        
        float lSize = INITIAL_LETTERSIZE;
        float keysSize = INITIAL_LETTERSIZE*(float)(keysArray.count+1);
        
        //NSLog(@"tenta ser um pouco inteligente: %f", keysSize);
        
        lSize = SPACE/(keysArray.count+1);
        
        if(lSize > INITIAL_LETTERSIZE) lSize = INITIAL_LETTERSIZE;
        [self resizeLetters:lSize andNumberOfLetters:(float)keysArray.count+1];
        
        LetterButton *l = [[LetterButton alloc] initWithFrame: [self calculateLetterPositionWithNumberOfLetters:(float)keysArray.count+1 andActualSize:lSize] position:keysArray.count+1 andLetter: buttonPressed.titleLabel.text];
        
        [keysArray addObject: l];
        
        [self.view addSubview:l];
        
        [self handleFlushWithPos:keysArray.count+1];
    }
    
}

- (CGRect) calculateLetterPositionWithNumberOfLetters: (float) numberOfLetters andActualSize: (float)size
{    
    float xPosition = self.view.center.x - (numberOfLetters/2.0f * size) + (numberOfLetters-1) * size;
    
    return CGRectMake(xPosition,self.view.center.y,size,size);
}

- (void) resizeLetters: (float)newSize andNumberOfLetters: (float) numberOfLetters
{
    //NSLog(@"newSize: %f",newSize);
    //NSLog(@"Then newSize: %f",newSize);
    
    for(NSInteger u = 0 ; u < keysArray.count ; u++)
    {
        LetterButton *tButton = (LetterButton *) [keysArray objectAtIndex:u];
//        CGSize nSize = CGSizeMake(newSize, newSize);
        
        float startingXPos = self.view.center.x - (numberOfLetters/2.0f * newSize);
        
        [tButton setFrame:CGRectMake(startingXPos+u*newSize, self.view.center.y, newSize, newSize)];
        
    }
}

- (IBAction)playWord:(id)sender
{
    /* Use this code to play an audio file */
    AudioServicesPlaySystemSound(sound);
}

- (IBAction)finishedWord:(id)sender
{
    const char *wordArray = [self.theWord UTF8String];
    
    NSLog(@"GUESS SIZE: %i WORD SIZE: %lu", keysArray.count, strlen(wordArray));
    
    
    if(strlen(wordArray) >= keysArray.count)
    {
        NSLog(@"guess bigger or equal.");
        for (NSInteger k = 0; k < strlen(wordArray) ; k++) [correctionArray addObject: [NSNumber numberWithBool:NO]];
        
        for (NSInteger i = 0; i < keysArray.count ; i++)
        {
            LetterButton *tGuessedLetter = (LetterButton *) [keysArray objectAtIndex:i];
            NSString* tCorrectLetter = [NSString stringWithFormat:@"%c" , wordArray[i]];
            
            NSLog(@"Guess %i: %@ and Letter %i: %@",i, tGuessedLetter.titleLabel.text, i, tCorrectLetter);
            
            if([tCorrectLetter isEqualToString: tGuessedLetter.titleLabel.text]) correctionArray[i] = [NSNumber numberWithBool:YES];
            
            
        }
    }
    else if(strlen(wordArray) < keysArray.count)
    {
        for (NSInteger k = 0; k < keysArray.count ; k++) [correctionArray addObject: [NSNumber numberWithBool:NO]];
        
        for (NSInteger i = 0; i < strlen(wordArray) ; i++)
        {
            LetterButton *tGuessedLetter = (LetterButton *) [keysArray objectAtIndex:i];
            NSString* tCorrectLetter = [NSString stringWithFormat:@"%c" , wordArray[i]];
            
            NSLog(@"Guess %i: %@ and Letter %i: %@",i, tGuessedLetter.titleLabel.text, i, tCorrectLetter);
            
            if([tCorrectLetter isEqualToString: tGuessedLetter.titleLabel.text]) correctionArray[i] = [NSNumber numberWithBool:YES];
            
            
        }
    }
    
    for (NSInteger k = 0; k < correctionArray.count ; k++) NSLog(@"Answer %i: %i", k, [correctionArray[k] boolValue]);
}

- (void)handleFlush: (NSNotification *) notification
{
    [self handleFlushWithPos:[(NSNumber *)[notification object] integerValue]];
}

- (void)handleFlushWithPos: (NSInteger) pos
{
//    NSLog(@"Posicao selecionada: %i", pos);
    
    for (NSInteger y = 0; y < keysArray.count; y++)
    {
        LetterButton *tButton = (LetterButton *)[keysArray objectAtIndex:y];
        
        [tButton setBackgroundColor:[UIColor blackColor]];
        tButton.selected = NO;
    }
    
    if(pos <= (NSInteger)keysArray.count)
    {
        LetterButton *rButton = (LetterButton *)[keysArray objectAtIndex:pos-1];
        
        [rButton setBackgroundColor:[UIColor redColor]];
        rButton.selected = YES;
    }
    
    positionSelected = pos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFlush:) name:@"FlushButtons" object:nil];
    
    semanaquevem = 0;
    positionSelected = 0;
    keysArray = [NSMutableArray array];
    correctionArray = [NSMutableArray array];
    //self.theWord = @"TIARA";
    NSLog(@"the Word: %@", self.theWord);
    
    
    NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tiara" ofType:@"mp3"]];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &sound);
    
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
