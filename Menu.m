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
    
    [coinsPocket setFont:[UIFont fontWithName:@"Delicious-Roman" size:18]];
    [playBtn.titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:25]];
    [storeBtn.titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:25]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back72.png"]]];
    
    NSMutableArray *themesArray = [[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]] mutableCopy];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Scores"] == nil)
    {
        NSMutableArray *scoreArray = [NSMutableArray array];
        
        
        for(NSInteger i = 0 ; i < themesArray.count ; i++)
        {
            [scoreArray addObject: [NSMutableArray array]];
            
            NSMutableArray *wordsArray = themesArray[i];
            
            for (NSInteger k = 0; k < wordsArray.count; k++)
            {
                [scoreArray[i] addObject:[NSNumber numberWithBool:NO]];
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
    
    [coinsPocket setText: [NSString stringWithFormat: @"%i", superCoins]];

    NSLog(@"coins: %i", superCoins);
    [[NSUserDefaults standardUserDefaults] synchronize];
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
