//
//  WinLose.m
//  YouSpell
//
//  Created by Francisco F Neto on 17/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "WinLose.h"
#import "LetterButton.h"
#import "AppConstants.h"
#import "DefinitionView.h"
#import "GameScene.h"
#import <Chartboost/Chartboost.h>
#import <Chartboost/CBNewsfeed.h>
#import "AppDelegate.h"

static int timesPlayed;

@interface WinLose ()
{
    NSMutableArray *wordsToBeTried;
    float lettersSize;
}

@end

@implementation WinLose

@synthesize feedback;
@synthesize word;
@synthesize transitionController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) resizeLetters: (float)newSize andNumberOfLetters: (float) numberOfLetters
{
    for(NSInteger u = 0 ; u < strlen(self.word) ; u++)
    {
        LetterButton *tButton = (LetterButton *) [rightWordLetters objectAtIndex:u];
        
        float startingXPos = self.view.center.x - (numberOfLetters/2.0f * newSize);
        
        [tButton setFrame:CGRectMake(startingXPos+u*newSize, self.view.center.y, newSize*1.3f, newSize)];
        if(u == strlen(self.word)-1) [tButton setFrame:CGRectMake(startingXPos+u*newSize, self.view.center.y, newSize, newSize)];

        
    }
}

- (IBAction)nextWord:(id)sender
{
    if(wordsToBeTried.count != 0)
    {
        // call next word
        [self performSegueWithIdentifier:@"CallNextWord" sender:self];
    }
    else
    {
        // call theme selection
        NSLog(@"Theme ended. Going to theme selection... reseting current streak");
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:@"currentStreak"];
        [self performSegueWithIdentifier:@"ThemeEnded" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"selectedTheme: %i", selectedTheme);
    
    if ([[segue identifier] isEqualToString:@"CallNextWord"])
    {
        // Get destination view
        GameScene *vc = [segue destinationViewController];
        
        //wordsToBeTried = [[[NSUserDefaults standardUserDefaults] objectForKey:@"wordsToBeTried"] mutableCopy];
        
        if(!self.didWon)
        {
            // reinicia palavras do tema //
            
            wordsToBeTried = [NSMutableArray array];
            for (NSInteger x = 0; x < [[wordsArray objectAtIndex:selectedTheme] count] ; x++)
            {
                [wordsToBeTried addObject:[NSNumber numberWithInt:(int)x]];
            }

        }
        
        //NSLog(@"wtbt: %@", wordsToBeTried);
        
        int r = arc4random_uniform((int)[wordsToBeTried count]);
        
        
        
        NSInteger index = [[wordsToBeTried objectAtIndex:r] integerValue];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:index] forKey:@"selectedWord"];
        NSLog(@"winlose selected Word: %i", (int)index);
        
        vc.theWord = [[[[wordsArray objectAtIndex:selectedTheme] objectAtIndex:index] objectForKey:@"word"] uppercaseString];
        vc.selectedThemeWordCount = (int)[[wordsArray objectAtIndex:selectedTheme] count];
        
        [wordsToBeTried removeObjectAtIndex:r];
        
        //NSLog(@"%@", wordsToBeTried);
        [[NSUserDefaults standardUserDefaults] setObject:wordsToBeTried forKey: @"wordsToBeTried"];
    }
    else if([[segue identifier] isEqualToString:@"BackToMenu"])
    {
        NSLog(@"Back to menu... reseting current streak");
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:@"currentStreak"];
    }
    
    
    //isReseting = YES;
}

- (IBAction)displaySecondVC:(id)sender
{
    
    //NSLog(@"1 2 3");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //NSLog(@"1- 2 3");
    DefinitionView *vc = [storyboard instantiateViewControllerWithIdentifier:@"DefinitionVC"];
    //NSLog(@"1 2- 3");
    vc.word = self.stringWord;
    
    NSInteger selWord = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedWord"] integerValue];
    NSDictionary *td = [[wordsArray objectAtIndex: selectedTheme] objectAtIndex:selWord];
    //NSLog(@"def: %@", [td objectForKey:@"definition"]);
    NSString *selectedDefinition = [td objectForKey:@"definition"];
    //NSLog(@"def: %@", selectedDefinition);
    
    vc.definition = [NSString stringWithFormat: @"%@", selectedDefinition];
    
    vc.view.backgroundColor = [UIColor clearColor];
    //NSLog(@"1 2 3-");
    
    //NSLog(@"word before def: %@", [NSString stringWithUTF8String:self.word]);
    
    
    [vc setTransitioningDelegate:transitionController];
    vc.modalPresentationStyle= UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"wtbt count: %i", (int)wordsToBeTried.count);
    if(wordsToBeTried.count == 0) [self.nextWordBtn setTitle:@"New theme" forState:UIControlStateNormal];
    else [self.nextWordBtn setTitle:@"Next word" forState:UIControlStateNormal];
    
    CGRect oldPlace = self.definitionBtn.frame;
    [self.definitionBtn setFrame:CGRectMake(0, self.view.center.y+lettersSize, oldPlace.size.width, oldPlace.size.height)];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"winLose");
    // Do any additional setup after loading the view.
    timesPlayed++;
    NSLog(@"timesPlayed: %d", timesPlayed);
    int timesPlayedRest = timesPlayed%4;
    NSLog(@"timesPlayedRest: %d", timesPlayedRest);
    if(timesPlayed%4 == 0){
        NSLog(@"showChartboost");
        [Chartboost showInterstitial:CBLocationGameScreen];
    }

    alreadyRated = [[NSUserDefaults standardUserDefaults] boolForKey:@"alreadyRated"];
    NSLog(@"alreadyRated: %d", alreadyRated);
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back72.png"]]];
 
    self.progressPerc.font = [UIFont fontWithName:@"Delicious-Roman" size:10];
    self.themeLabel.font = [UIFont fontWithName:@"Delicious-Roman" size:18];
    gainedCoins.font = [UIFont fontWithName:@"Delicious-Roman" size:25];
    
    wordsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    wordsToBeTried = [[[NSUserDefaults standardUserDefaults] objectForKey:@"wordsToBeTried"] mutableCopy];
    
    selectedTheme = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTheme"] integerValue];
    NSInteger themeWords = [[wordsArray objectAtIndex:selectedTheme] count];
    
    float percentage = 0.0f;
    
    self.view.autoresizesSubviews = NO;
    
    CGRect frame = CGRectMake(40, 66, 240, 8);
    
    if(self.didWon)
    {
        self.feedback.text = @"You WON!! Let's break that record!";
        titleBack.image = [UIImage imageNamed:@"WLTitleGreen.png"];
        
        percentage = (float)(themeWords-wordsToBeTried.count)/themeWords;
        [self.nextWordBtn setTitle:@"Next word" forState:UIControlStateNormal];
        
        
        NSInteger coins = [[NSUserDefaults standardUserDefaults] integerForKey:COINS];
        coins += 5;
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:COINS];
        [gainedCoins setText:@"+5 coins"];
    }
    else
    {
        self.feedback.text = @"Sorry, better luck next time!";
        titleBack.image = [UIImage imageNamed:@"WLTitleRed.png"];
        
        percentage = (float)(themeWords-wordsToBeTried.count-1)/themeWords;
        [self.nextWordBtn setTitle:@"Restart" forState:UIControlStateNormal];
        
        NSInteger coins = [[NSUserDefaults standardUserDefaults] integerForKey:COINS];
        coins += 1;
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:COINS];
        [gainedCoins setText:@"+1 coin"];
    }
    
    self.progressPerc.text = [NSString stringWithFormat:@"%.0f%%", percentage*100];
    frame.size.width *= percentage;
    
    UIView *bar = [[UIView alloc] initWithFrame: frame];
    bar.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:200.0/255.0 blue:135.0/255.0 alpha:1.0];
    //[self.view addSubview:bar];
    
    [self.view insertSubview:bar aboveSubview:self.blueBar];
    
    self.stringWord = [NSString stringWithUTF8String:self.word];
    self.transitionController = [[TransitionDelegate alloc] init];
    
    self.themeLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedThemeName"];
    
    ////// Criação da palavra certa //////
    
    rightWordLetters = [NSMutableArray array];
    lettersSize = INITIAL_LETTERSIZE;
    
    lettersSize = SPACE/(strlen(self.word));
    
    if(lettersSize > INITIAL_LETTERSIZE) lettersSize = INITIAL_LETTERSIZE;
    
    for(NSInteger i = 0 ; i < strlen(self.word) ; i++)
    {
        //NSLog(@"%d",i);
        LetterButton *l = [[LetterButton alloc] initWithFrame: CGRectMake(0,0,0,0) position:i andLetter: [NSString stringWithFormat:@"%c" , self.word[i]] andState:typeLabel];
        
        [rightWordLetters addObject:l];
        
        if(i == 0) [l setBackgroundImage:[UIImage imageNamed:@"First Piece"] forState:UIControlStateNormal];
        else if(i == strlen(self.word)-1) [l setBackgroundImage:[UIImage imageNamed:@"Last Piece"] forState:UIControlStateNormal];
        
        [self.view addSubview:l];
    }
    
    [self resizeLetters:lettersSize andNumberOfLetters:(float)strlen(self.word)];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    int timesOpenedApp = [AppDelegate returnTimesOpened];
    NSLog(@"timesOpenedApp: %d", timesOpenedApp);
    if(!alreadyRated && self.isViewLoaded && timesOpenedApp>=4 && timesPlayed==2){
        NSLog(@"showRatePopUp");
        UIAlertController *ratePopUp = [UIAlertController alertControllerWithTitle:@"Rate us!" message:@"Rate us and spread the spell word!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesRate = [UIAlertAction actionWithTitle:@"Yes!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"YesRate!");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", @"605379719"]]];
            //[[NSUserDefaults standardUserDefaults] boolForKey:@"alreadyRated"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"alreadyRated"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        
        UIAlertAction *noRate = [UIAlertAction actionWithTitle:@"no" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"noRate");
        }];
        
        [ratePopUp addAction:yesRate];
        [ratePopUp addAction:noRate];
        
        [self presentViewController:ratePopUp animated:YES completion:nil];
    }
}

- (CGRect) calculateLetterPositionWithNumberOfLetters: (float) numberOfLetters andActualSize: (float)size
{
    float xPosition = self.view.center.x - (numberOfLetters/2.0f * size) + (numberOfLetters-1) * size;
    
    return CGRectMake(xPosition,self.view.center.y,size,size);
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
