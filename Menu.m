//
//  Menu.m
//  YouSpell
//
//  Created by Francisco F Neto on 18/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "Menu.h"
#import "AppConstants.h"

@interface Menu ()

@end

@implementation Menu


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[Chartboost showInterstitial:CBLocationMainMenu];
    /*if([ALInterstitialAd isReadyForDisplay]){
        NSLog(@"appLovinReady");
        [ALInterstitialAd show];
    }else NSLog(@"appLovingNotReady");*/
    
    [coinsPocket setFont:[UIFont fontWithName:@"Delicious-Roman" size:18]];
    [playBtn.titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:25]];
    [storeBtn.titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:25]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back72.png"]]];
    
    // setando a variável de streak atual para 0, pois não estamos em jogo...
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:@"currentStreak"];
    
    NSMutableArray *themesArray = [[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]] mutableCopy];
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Streaks"] == nil)
    {
        NSMutableArray *streakArray = [NSMutableArray array];
        
        for(int y = 0 ; y < 3 ; y++)
        {
            [streakArray addObject:[NSMutableArray array]];
            
            for(int u = 0 ; u < themesArray.count; u++)
            {
                [streakArray[y] addObject:[NSNumber numberWithInt: 0]];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[streakArray mutableCopy] forKey:@"Streaks"];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Scores"] == nil)
    {
        NSMutableArray *scoreArray = [NSMutableArray array];
        
        for (NSInteger j = 0; j < 3; j++)
        {
            //NSLog(@"level: %i",j);
            [scoreArray addObject:[NSMutableArray array]];
            
            for(NSInteger i = 0 ; i < themesArray.count ; i++)
            {
                //NSLog(@"tema: %i",i);
                [scoreArray[j] addObject: [NSMutableArray array]];
                
                for (NSInteger k = 0; k < [themesArray[i] count]; k++)
                {
                    //NSLog(@"palavra: %i",k);
                    [scoreArray[j][i] addObject:[NSNumber numberWithBool:NO]];
                }
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[scoreArray mutableCopy] forKey:@"Scores"];
    }

    if([[NSUserDefaults standardUserDefaults] objectForKey:THEMESSTATUS] == nil)
    {
        NSMutableArray *array = [NSMutableArray array];
        for (int j = 0; j < 9 ; j++)
        {
            [array addObject:[NSNumber numberWithBool:YES]];
        }
        for (int n = 9; n < 20 ; n++)
        {
            [array addObject:[NSNumber numberWithBool:NO]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:THEMESSTATUS];
    }
    
    NSInteger superCoins = [[NSUserDefaults standardUserDefaults] integerForKey: COINS];
    
    [coinsPocket setText: [NSString stringWithFormat: @"%i", (int)superCoins]];

    NSLog(@"coins: %i", (int)superCoins);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //[self showInMobiBanner];
}

-(void)showInMobiBanner{
    self.banner = [[IMBanner alloc] initWithFrame:CGRectMake(0, 0, 320, 50) appId:@"6708b781839d47c29dadd2a3bc934e57" adSize:IM_UNIT_320x50];
    self.banner.delegate = self;
    [self.view addSubview:self.banner];
    [self.banner loadBanner];
    self.banner.refreshInterval = 90;
}

-(void)dealloc {
    self.banner.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"EasyClicked"])
    {
        NSLog(@"easy");
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"LevelSelected"];
    }
    else if([segue.identifier isEqualToString:@"MediumClicked"])
    {
        NSLog(@"medium");
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"LevelSelected"];
    }
    else if([segue.identifier isEqualToString:@"HardClicked"])
    {
        NSLog(@"hard");
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"LevelSelected"];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void)bannerDidReceiveAd:(IMBanner *)banner{
    NSLog(@"finishedLoadingBanner");
}

- (void)banner:(IMBanner *)banner didFailToReceiveAdWithError:(IMError *)error {
    NSString *errorMessage = [NSString stringWithFormat:@"Loading banner ad failed. Error code: %d, message: %@", [error code], [error localizedDescription]];
    NSLog(@"%@", errorMessage);
}

@end
