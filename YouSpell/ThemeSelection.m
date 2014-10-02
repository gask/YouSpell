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

#define WORDS_PER_THEME 3

@interface ThemeSelection ()

@end

@implementation ThemeSelection

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    wordsArray = [[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]] mutableCopy];
    selectedTheme = -1;
    themeNames = [NSMutableArray arrayWithObjects:
                  @"Body Parts",
                  @"Animals",
                  @"Countries",
                  @"Colors",
                  @"Objects",
                  @"Fruits",
                  @"Cars",
                  @"Bands",
                  @"Movies",
                  @"Soccer Teams",
                  @"Other Teams",
                  @"Enterprises",
                  @"Body Parts 2",
                  @"Enterprises 2",
                  @"Countries 2",
                  @"Movies 2",
                  @"Soccer Teams 2",
                  @"Countries 3",
                  @"Animals 2",
                  nil];
    
    themeScores = [NSMutableArray array];
    themeTotals = [NSMutableArray array];
    userScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Scores"] mutableCopy];
    
    
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

- (NSIndexPath *) tableView: (UITableView *) tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"selecionei o %io botão!", indexPath.row+1);
    selectedTheme = indexPath.row;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:selectedTheme] forKey:@"selectedTheme"];
    
    [self performSegueWithIdentifier:@"CallGameScene" sender:self];
    
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"selectedTheme: %i", selectedTheme);
    
    if ([[segue identifier] isEqualToString:@"CallGameScene"])
    {
        // Get destination view
        GameScene *vc = [segue destinationViewController];
        
        int r = arc4random_uniform([[wordsArray objectAtIndex:selectedTheme] count]);
        //NSLog(@"selected Word: %i", r);
        
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
    
    //UIImageView *image = nil;
    
    
    
    if(cell == nil)
    {
        cell = [[ThemeCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
        
        //NSInteger row = indexPath.row+1;
        
        //image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", row]]];
        //cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", row]];
        //[image setFrame:CGRectMake(0,0, 50, 50)];
        //image.tag = 100;
        
        //[cell.contentView addSubview:image];
        
       // NSLog(@"%i",row);
    }
    
    NSInteger row = indexPath.row+1;
    cell.themeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", row]];
    cell.themeName.text = [themeNames objectAtIndex:row-1];
    cell.themeScore.text = [NSString stringWithFormat:@"%i/%i",[themeScores[row-1] intValue], [themeTotals[row-1] intValue] ];
    
//    cell.textLabel.text = 
    /*else
    {
        image = [cell.contentView viewWithTag:100];
        
        NSLog(@"hehehe %i",indexPath.row+1);
    }*/
    
    //cell.textLabel.text = [NSString stringWithFormat:@"meu bilau verde: %d", indexPath.row];

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
