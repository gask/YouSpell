//
//  GameScene.m
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "GameScene.h"
#import "LetterButton.h"
#import "WinLose.h"
#import "AppConstants.h"

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
        //float keysSize = INITIAL_LETTERSIZE*(float)(keysArray.count+1);
        
        //NSLog(@"tenta ser um pouco inteligente: %f", keysSize);
        
        lSize = SPACE/(keysArray.count+1);
        
        if(lSize > INITIAL_LETTERSIZE) lSize = INITIAL_LETTERSIZE;
        [self resizeLetters:lSize andNumberOfLetters:(float)keysArray.count+1];
        
        LetterButton *l = [[LetterButton alloc] initWithFrame: [self calculateLetterPositionWithNumberOfLetters:(float)keysArray.count+1 andActualSize:lSize] position:keysArray.count+1 andLetter: buttonPressed.titleLabel.text andState:typeButton];
        
        [keysArray addObject: l];
        
        [self.view addSubview:l];
        
        [self handleFlushWithPos:keysArray.count+1];
    }
    
}

- (CGRect) calculateLetterPositionWithNumberOfLetters: (float) numberOfLetters andActualSize: (float)size
{    
    float xPosition = self.view.center.x - (numberOfLetters/2.0f * size) + (numberOfLetters-1) * size;
    
    return CGRectMake(xPosition,self.view.center.y,size*1.3f,size);
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
        
        [tButton setFrame:CGRectMake(startingXPos+u*newSize, self.view.center.y, newSize*1.3f, newSize)];
        
    }
}

- (IBAction)playWord:(id)sender
{
    /* Use this code to play an audio file */
    AudioServicesPlaySystemSound(sound);
}

-(void) presentMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Spell" message: message delegate: nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
}


- (IBAction)finishedWord:(id)sender
{
    //[self showHideView:sender];
    
    //return;
    
    if(keysArray.count <= 0)
    {
        [self presentMessage:@"You have to type at least one character"];
        return;
    }
    
    for(NSInteger c = 0 ; c < sceneButtons.count ; c++) [[sceneButtons objectAtIndex:c] setEnabled:NO];
    
    const char *wordArray = [self.theWord UTF8String];
    
    //NSLog(@"GUESS SIZE: %i WORD SIZE: %lu", keysArray.count, strlen(wordArray));
    
    
    if(strlen(wordArray) >= keysArray.count)
    {
        //NSLog(@"guess bigger or equal.");
        for (NSInteger k = 0; k < strlen(wordArray) ; k++) [correctionArray addObject: [NSNumber numberWithBool:NO]];
        
        for (NSInteger i = 0; i < keysArray.count ; i++)
        {
            LetterButton *tGuessedLetter = (LetterButton *) [keysArray objectAtIndex:i];
            NSString* tCorrectLetter = [NSString stringWithFormat:@"%c" , wordArray[i]];
            
            //NSLog(@"Guess %i: %@ and Letter %i: %@",i, tGuessedLetter.titleLabel.text, i, tCorrectLetter);
            
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
            
            //NSLog(@"Guess %i: %@ and Letter %i: %@",i, tGuessedLetter.titleLabel.text, i, tCorrectLetter);
            
            if([tCorrectLetter isEqualToString: tGuessedLetter.titleLabel.text]) correctionArray[i] = [NSNumber numberWithBool:YES];
            
            
        }
    }
    
    for (NSInteger k = 0; k < correctionArray.count ; k++)
    {
        //NSLog(@"Answer %i: %i", k, [correctionArray[k] boolValue]);
        if(![correctionArray[k] boolValue]) gameWon = NO;
    }
    
    
    CGFloat newSize = 0;
    NSInteger letras = 0;
    
    if(self.theWord.length > keysArray.count) letras = self.theWord.length;
    else letras = keysArray.count;
    
    newSize = SPACE/letras;
    
    if(newSize > INITIAL_LETTERSIZE) newSize = INITIAL_LETTERSIZE;
    
    [self resizeLetters:newSize andNumberOfLetters:letras];
    
    LetterButton *firstKey = [keysArray objectAtIndex:0];
    LetterButton *lastKey = [keysArray objectAtIndex:keysArray.count-1];
    
    [firstKey setBackgroundImage:[UIImage imageNamed:@"First Piece"] forState:UIControlStateNormal];
    [lastKey setBackgroundImage:[UIImage imageNamed:@"Last Piece"] forState:UIControlStateNormal];
    
    [lastKey setFrame:CGRectMake(lastKey.frame.origin.x, lastKey.frame.origin.y, lastKey.frame.size.width/1.3f, lastKey.frame.size.height)];
    
    //NSMutableArray *correctKeysArray = [NSMutableArray array];
    float startingXPos = self.view.center.x - (letras/2.0f * newSize);
    
    for (NSInteger j = 0 ; j < self.theWord.length ; j++)
    {
        //LetterButton *key = [keysArray objectAtIndex:j];
        
        CGRect tRect = CGRectMake(startingXPos+j*newSize, self.view.center.y, newSize*1.3f, newSize);
        
        if(j == self.theWord.length-1) tRect = CGRectMake(startingXPos+j*newSize, self.view.center.y, newSize, newSize);
        
        NSLog(@"%f / %f / %f / %f",tRect.origin.x,tRect.origin.y,tRect.size.width, tRect.size.height);
        
        UIButton *jButton = [[UIButton alloc] initWithFrame: tRect];
        
        if([[correctionArray objectAtIndex:j] boolValue])
        {
            if(j == 0)[jButton setBackgroundImage:[UIImage imageNamed:@"First Piece_Correct"] forState:UIControlStateNormal];
            else if(j == self.theWord.length-1) [jButton setBackgroundImage:[UIImage imageNamed:@"Last Piece_Correct"] forState:UIControlStateNormal];
            else [jButton setBackgroundImage:[UIImage imageNamed:@"Mid Piece_Correct"] forState:UIControlStateNormal];
        }
        else
        {
            if(j == 0)[jButton setBackgroundImage:[UIImage imageNamed:@"First Piece_Incorrect"] forState:UIControlStateNormal];
            else if(j == self.theWord.length-1) [jButton setBackgroundImage:[UIImage imageNamed:@"Last Piece_Incorrect"] forState:UIControlStateNormal];
            else [jButton setBackgroundImage:[UIImage imageNamed:@"Mid Piece_Incorrect"] forState:UIControlStateNormal];
        }
        
        [jButton setTitle:[NSString stringWithFormat:@"%c", wordArray[j]] forState:UIControlStateNormal];
        //jButton.titleLabel.text = [NSString stringWithFormat:@"%c", wordArray[j]];
        
        NSLog(@"%@", jButton.titleLabel.text);
        
        [jButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jButton setAlpha:0.0];
        jButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [jButton.titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:15.0]];
        
        [self.view addSubview:jButton];
        
        [correctArrayKeys addObject:jButton];
    }
    
    UIButton *firstCorrectKey = [correctArrayKeys objectAtIndex:0];
    
    // Call the first piece up right away
    [UIView animateWithDuration:0.5
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         firstCorrectKey.frame = CGRectMake(firstCorrectKey.frame.origin.x, firstCorrectKey.frame.origin.y-firstCorrectKey.frame.size.height, firstCorrectKey.frame.size.width, firstCorrectKey.frame.size.height);
                         firstCorrectKey.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                             [self animateCorrectKey];
                     }];
}

- (void) callNextViewController
{
    [self performSegueWithIdentifier:@"CallWinLose" sender:self];
}


- (void) animateCorrectKey
{
    if(correctKeyIndex == self.theWord.length)
    {
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(callNextViewController) userInfo:nil repeats:NO];
    }
    else
    {
        UIButton *key = [correctArrayKeys objectAtIndex:correctKeyIndex];
        correctKeyIndex++;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        key.frame = CGRectMake(key.frame.origin.x, key.frame.origin.y-key.frame.size.height, key.frame.size.width, key.frame.size.height);
        
        key.alpha = 1.0;
        
        [UIView setAnimationDidStopSelector:@selector(animateCorrectKey)];
        [UIView commitAnimations];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"won: %i", gameWon);
    
    if ([[segue identifier] isEqualToString:@"CallWinLose"])
    {
        //NSLog(@"é a segue");
        
        // Get destination view
        WinLose *vc = [segue destinationViewController];
        
        vc.word = [self.theWord cStringUsingEncoding:NSASCIIStringEncoding];
        
        if(gameWon)
        {
            vc.didWon = YES;
            
            NSInteger selectedTheme = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTheme"] intValue];
            NSInteger selectedWord = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedWord"] intValue];
            NSMutableArray *scoreArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Scores"] mutableCopy];
            
            NSMutableArray *subScoreArray = [[scoreArray objectAtIndex: selectedTheme] mutableCopy];
            
            //NSLog(@"1");
            
            [subScoreArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:selectedWord];
//            subScoreArray[selectedWord] = [NSNumber numberWithBool:YES];
            //NSLog(@"2");
            scoreArray[selectedTheme] = subScoreArray;
            
            [[NSUserDefaults standardUserDefaults] setObject:scoreArray forKey:@"Scores"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        else
        {
            vc.didWon = NO;
        }
    }
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
        
        //[tButton setBackgroundColor:[UIColor blackColor]];
        [tButton setBackgroundImage:[UIImage imageNamed:@"Mid Piece"] forState:UIControlStateNormal];
        tButton.selected = NO;
    }
    
    if(pos <= (NSInteger)keysArray.count)
    {
        LetterButton *rButton = (LetterButton *)[keysArray objectAtIndex:pos-1];
        
        //[rButton setBackgroundColor:[UIColor redColor]];
        [rButton setBackgroundImage:[UIImage imageNamed:@"Mid Piece Selected"] forState:UIControlStateNormal];
        rButton.selected = YES;
    }
    
    positionSelected = pos;
}

-(void) removeLetter:(NSNotification *) notification
{
    NSInteger removingButtonIndex = [(NSNumber *)[notification object] integerValue]-1;
    
    [keysArray[removingButtonIndex] removeFromSuperview];
    [keysArray removeObjectAtIndex: removingButtonIndex];
    
    for (NSInteger y = 0; y < keysArray.count; y++)
    {
        LetterButton *tb =(LetterButton *)keysArray[y];
        
        tb.position = y+1;
    }
    
    float lSize = INITIAL_LETTERSIZE;
    
    //NSLog(@"tenta ser um pouco inteligente: %f", keysSize);
    
    lSize = SPACE/(keysArray.count);
    
    if(lSize > INITIAL_LETTERSIZE) lSize = INITIAL_LETTERSIZE;
    [self resizeLetters:lSize andNumberOfLetters:(float)keysArray.count];
    
    /*for (NSInteger y = 0; y < keysArray.count; y++)
    {
        LetterButton *tb =(LetterButton *)keysArray[y];
        NSLog(@"at del: %@",tb.titleLabel.text);
        NSLog(@"at del: %d",tb.position);
    }*/
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back72.png"]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFlush:) name:@"FlushButtons" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLetter:) name:@"RemoveLetter" object:nil];
    
    positionSelected = 0;
    keysArray = [NSMutableArray array];
    correctionArray = [NSMutableArray array];
    //self.theWord = @"TIARA";
    
    gameWon = YES;
    
    //NSLog(@"the Word: %@", self.theWord);
    
    NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.theWord lowercaseString] ofType:@"mp3"]];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &sound);
    
    correctArrayKeys = [NSMutableArray array];
    correctKeyIndex = 1;
    
    NSArray *subviews = [self.view subviews];
    sceneButtons = [NSMutableArray array];
    
    for (NSInteger o = 0; o < subviews.count; o++)
    {
        UIView *object = [subviews objectAtIndex:o];
        if([object isMemberOfClass:[UIButton class]])
        {
            [sceneButtons addObject:object];
        }
    }
    
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
