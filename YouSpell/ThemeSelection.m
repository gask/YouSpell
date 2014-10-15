//
//  ThemeSelection.m
//  YouSpell
//
//  Created by Francisco F Neto on 14/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "ThemeSelection.h"
#import "GameScene.h"
#import "ThemeCell.h"
#import "AppConstants.h"

#define WORDS_PER_THEME 3

@interface ThemeSelection ()

@end

@implementation ThemeSelection

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    coinImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"coin1.png"],
                         [UIImage imageNamed:@"coin2.png"],
                         [UIImage imageNamed:@"coin3.png"],
                         [UIImage imageNamed:@"coin4.png"],
                         nil];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back72.png"]]];
    [titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:25]];
    [backBtn.titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:15]];
    
    
    wordsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    selectedTheme = -1;
    themes = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"themes" ofType:@"plist"]];
    
    
    themeScores = [NSMutableArray array];
    themeTotals = [NSMutableArray array];
    userScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Scores"] mutableCopy];
    
    hasTheme = [[[NSUserDefaults standardUserDefaults] objectForKey:THEMESSTATUS] mutableCopy];
    
    for (NSInteger i = 0 ; i < userScore.count; i++)
    {
        //NSLog(@"tema %i: %@", i+1, themeNames[i]);
        NSMutableArray *themeWords = [[userScore objectAtIndex:i] mutableCopy];
        [themeTotals addObject:[NSNumber numberWithInt:themeWords.count]];
        
        NSInteger themeScore = 0;
        for (NSInteger k = 0; k < themeWords.count; k++)
        {
            BOOL scoreValue = [[themeWords objectAtIndex:k] boolValue];
            //NSLog(@"%i",scoreValue);
            if(scoreValue) themeScore++;
        }
        [themeScores addObject: [NSNumber numberWithInt:themeScore]];
    }
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"selecionei o %io botão!", indexPath.row+1);
    if([[hasTheme objectAtIndex:indexPath.row] boolValue])
    {
        selectedTheme = indexPath.row;
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:selectedTheme] forKey:@"selectedTheme"];
        [[NSUserDefaults standardUserDefaults] setObject: [[themes objectAtIndex:selectedTheme] objectForKey: @"name"] forKey:@"selectedThemeName"];
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self performSegueWithIdentifier:@"CallGameScene" sender:self];
    }
    else
    {
        NSInteger coins = [[NSUserDefaults standardUserDefaults] integerForKey:COINS];
        NSInteger price = [[[themes objectAtIndex:indexPath.row] objectForKey:@"price"] integerValue];
        
        if(coins >= price)
        {
            coins -= price;
            [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:COINS];
            
            [hasTheme replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
            [[NSUserDefaults standardUserDefaults] setObject:hasTheme forKey:THEMESSTATUS];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            selectedTheme = indexPath.row;
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:selectedTheme] forKey:@"selectedTheme"];
            [[NSUserDefaults standardUserDefaults] setObject: [[[themes objectAtIndex:selectedTheme] objectForKey: @"name"] stringValue] forKey:@"selectedThemeName"];
            
            
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            [self performSegueWithIdentifier:@"CallGameScene" sender:self];
            
        }
        else
        {
            [self presentMessage:@"You don't have enough coins!"];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
    }
    
    //return indexPath;
}

-(void) presentMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Spell" message: message delegate: nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"selectedTheme: %i", selectedTheme);
    
    if ([[segue identifier] isEqualToString:@"CallGameScene"])
    {
        // Get destination view
        GameScene *vc = [segue destinationViewController];
        
        int r = arc4random_uniform([[wordsArray objectAtIndex:selectedTheme] count]);
        NSLog(@"selected Word: %i", r);
        
        NSMutableArray *wordsToBeTried = [NSMutableArray array];
        for (NSInteger x = 0; x < [[wordsArray objectAtIndex:selectedTheme] count] ; x++)
        {
            [wordsToBeTried addObject:[NSNumber numberWithInt:x]];
        }
        
        [wordsToBeTried removeObjectAtIndex:r];
        
        [[NSUserDefaults standardUserDefaults] setObject:wordsToBeTried forKey:@"wordsToBeTried"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:r] forKey:@"selectedWord"];
        
        vc.theWord = [[[[wordsArray objectAtIndex:selectedTheme] objectAtIndex:r] objectForKey:@"word"] uppercaseString];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 19;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil)
    {
        cell = [[ThemeCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
    }
    
    NSInteger row = indexPath.row+1;
    cell.themeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", row]];
    UIFont *customFont = [UIFont fontWithName:@"Delicious-Roman" size:15];
    
    cell.themeName.font = customFont;
    cell.themeScore.font = customFont;
    cell.themeName.text = [[themes objectAtIndex:row-1] objectForKey:@"name"];
    cell.coinAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(264,10,20,20)];
    //[cell.coinAnimationView setImage:[UIImage imageNamed:@"coin1.png"]];
    [cell.coinAnimationView setAnimationImages: coinImages];
    [cell.coinAnimationView setAnimationDuration: 0.5];
    [cell.coinAnimationView setAnimationRepeatCount: 0];
    [cell.coinAnimationView startAnimating];
    [cell addSubview:cell.coinAnimationView];
    [cell.themeScore setText:@""];
    
    if([[hasTheme objectAtIndex:indexPath.row] boolValue])
    {
        [cell.coinAnimationView setAlpha:0.0];
        cell.themeScore.text = [NSString stringWithFormat:@"%i/%i",[themeScores[row-1] intValue], [themeTotals[row-1] intValue] ];
        [cell.buyIt setAlpha:0.0];
    }
    else
    {
        [cell.buyIt setAlpha:1.0];
        [cell.coinAnimationView setAlpha:1.0];
        cell.themeScore.text = [[[themes objectAtIndex:indexPath.row] objectForKey:@"price"] stringValue];
    }

    return cell;
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
