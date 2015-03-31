//
//  Rankings.m
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 11/12/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "Rankings.h"

@interface Rankings ()

@end

@implementation Rankings

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
    
    
    
    NSMutableArray *scoresArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Scores"];
    NSMutableArray *streakArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Streaks"];
    NSMutableArray *themeNames = [[NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"themes" ofType:@"plist"]] mutableCopy];
    NSMutableArray *easyScore = [scoresArray[0] mutableCopy];
    NSMutableArray *mediumScore = [scoresArray[1] mutableCopy];
    NSMutableArray *hardScore = [scoresArray[2] mutableCopy];
    NSMutableArray *easyStreak = [streakArray[0] mutableCopy];
    NSMutableArray *mediumStreak = [streakArray[1] mutableCopy];
    NSMutableArray *hardStreak = [streakArray[2] mutableCopy];
    
    themeData = [NSMutableArray array];
    for (int i = 0; i < easyScore.count;  i++)
    {
        //[themeData addObject:[NSDictionary dictionary]];
        
        NSString *tName = [themeNames[i] objectForKey:@"name"];
        NSMutableArray *easyWords = [[easyScore objectAtIndex:i] mutableCopy];
        NSMutableArray *mediumWords = [[mediumScore objectAtIndex:i] mutableCopy];
        NSMutableArray *hardWords = [[hardScore objectAtIndex:i] mutableCopy];
        
        NSInteger themeTotal = easyWords.count;
        
        NSInteger easyPoints = 0;
        NSInteger mediumPoints = 0;
        NSInteger hardPoints = 0;
        for (NSInteger k = 0; k < easyWords.count; k++)
        {
            BOOL easyScoreValue = [[easyWords objectAtIndex:k] boolValue];
            BOOL mediumScoreValue = [[mediumWords objectAtIndex:k] boolValue];
            BOOL hardScoreValue = [[hardWords objectAtIndex:k] boolValue];
            
            if(easyScoreValue) easyPoints++;
            if(mediumScoreValue) mediumPoints++;
            if(hardScoreValue) hardPoints++;
        }
        //NSLog(@"6");
        float easyPerc = (float)easyPoints/themeTotal*100.0;
        float mediumPerc = (float)mediumPoints/themeTotal*100.0;
        float hardPerc = (float)hardPoints/themeTotal*100.0;
        float ePercStreak = (float) [easyStreak[i] integerValue]/themeTotal*100;
        float mPercStreak = (float) [mediumStreak[i] integerValue]/themeTotal*100;
        float hPercStreak = (float) [hardStreak[i] integerValue]/themeTotal*100;
        
        NSMutableDictionary *themeDict = [NSMutableDictionary dictionary];
        
        //NSLog(@"taquipariu hein meu %@", tName);
        
        [themeDict setValue: tName forKey:@"themeName"];
        [themeDict setValue: [NSNumber numberWithFloat:easyPerc]forKey:@"easyPercentage"];
        [themeDict setValue: [NSNumber numberWithFloat:mediumPerc]forKey:@"mediumPercentage"];
        [themeDict setValue: [NSNumber numberWithFloat:hardPerc]forKey:@"hardPercentage"];
        [themeDict setValue: [NSNumber numberWithFloat:ePercStreak]forKey:@"easyPercStreak"];
        [themeDict setValue: [NSNumber numberWithFloat:mPercStreak]forKey:@"mediumPercStreak"];
        [themeDict setValue: [NSNumber numberWithFloat:hPercStreak]forKey:@"hardPercStreak"];
        [themeDict setValue: [NSNumber numberWithInt:(int)[easyStreak[i] integerValue]]forKey:@"easyStreak"];
        [themeDict setValue: [NSNumber numberWithInt:(int)[mediumStreak[i] integerValue]]forKey:@"mediumStreak"];
        [themeDict setValue: [NSNumber numberWithInt:(int)[hardStreak[i] integerValue]]forKey:@"hardStreak"];
        
        [themeData setObject:themeDict atIndexedSubscript:i];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return themeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCell" forIndexPath:indexPath];
    
    [cell.themeTitle setText: [themeData[indexPath.row] objectForKey:@"themeName"]];
    [cell.themeImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", (int)indexPath.row+1]]];
    //NSLog(@"%@",[NSString stringWithFormat:@"%.1f%%",[[themeData[indexPath.row] objectForKey:@"easyPercentage"] floatValue]]);
    [cell.easyPercentage setText:[NSString stringWithFormat:@"%.1f%%",[[themeData[indexPath.row] objectForKey:@"easyPercentage"] floatValue]]];
    [cell.mediumPercentage setText:[NSString stringWithFormat:@"%.1f%%",[[themeData[indexPath.row] objectForKey:@"mediumPercentage"] floatValue]]];
    [cell.hardPercentage setText:[NSString stringWithFormat:@"%.1f%%",[[themeData[indexPath.row] objectForKey:@"hardPercentage"]floatValue]]];
    [cell.easyStreak setText:[NSString stringWithFormat:@"%@",[themeData[indexPath.row] objectForKey:@"easyStreak"]]];
    [cell.mediumStreak setText:[NSString stringWithFormat:@"%@",[themeData[indexPath.row] objectForKey:@"mediumStreak"]]];
    [cell.hardStreak setText:[NSString stringWithFormat:@"%@",[themeData[indexPath.row] objectForKey:@"hardStreak"]]];
    
    if([[themeData[indexPath.row] objectForKey:@"easyPercentage"] floatValue] == 100.0)
        [cell.easyStar setImage:[UIImage imageNamed:@"bronzeStar.png"]];
    else [cell.easyStar setImage:[UIImage imageNamed:@"starPlaceholder.png"]];
    if ([[themeData[indexPath.row] objectForKey:@"mediumPercentage"] floatValue] == 100.0)
        [cell.mediumStar setImage:[UIImage imageNamed:@"silverStar.png"]];
    else [cell.mediumStar setImage:[UIImage imageNamed:@"starPlaceholder.png"]];
    if([[themeData[indexPath.row] objectForKey:@"hardPercentage"] floatValue] == 100.0)
        [cell.hardStar setImage:[UIImage imageNamed:@"goldStar.png"]];
    else [cell.hardStar setImage:[UIImage imageNamed:@"starPlaceholder.png"]];
    
    if([cell.contentView viewWithTag:19] != nil)
    {
        UIView *easyBar = [cell.contentView viewWithTag:19];
        UIView *mediumBar = [cell.contentView viewWithTag:20];
        UIView *hardBar = [cell.contentView viewWithTag:21];
        
        [easyBar setFrame:CGRectMake(58, 127, 40* [[themeData[indexPath.row] objectForKey:@"easyPercStreak"] floatValue]/100.0, 6)];
        [mediumBar setFrame:CGRectMake(157, 127, 40* [[themeData[indexPath.row] objectForKey:@"mediumPercStreak"] floatValue]/100.0, 6)];
        [hardBar setFrame:CGRectMake(255, 127, 40* [[themeData[indexPath.row] objectForKey:@"hardPercStreak"] floatValue]/100.0, 6)];
        
    }
    else
    {
        CGRect easyBarFrame = CGRectMake(58, 127, 40, 6);
        CGRect mediumBarFrame = CGRectMake(157, 127, 40, 6);
        CGRect hardBarFrame = CGRectMake(255, 127, 40, 6);
        
        easyBarFrame.size.width *= [[themeData[indexPath.row] objectForKey:@"easyPercStreak"] floatValue]/100.0;
        mediumBarFrame.size.width *= [[themeData[indexPath.row] objectForKey:@"mediumPercStreak"] floatValue]/100.0;
        hardBarFrame.size.width *= [[themeData[indexPath.row] objectForKey:@"hardPercStreak"] floatValue]/100.0;
        
        UIView *easyBar = [[UIView alloc] initWithFrame: easyBarFrame];
        UIView *mediumBar = [[UIView alloc] initWithFrame: mediumBarFrame];
        UIView *hardBar = [[UIView alloc] initWithFrame: hardBarFrame];
        
        easyBar.tag = 19;
        mediumBar.tag = 20;
        hardBar.tag = 21;
        
        easyBar.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:200.0/255.0 blue:135.0/255.0 alpha:1.0];
        mediumBar.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:200.0/255.0 blue:135.0/255.0 alpha:1.0];
        hardBar.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:200.0/255.0 blue:135.0/255.0 alpha:1.0];
        
        [cell.contentView insertSubview:easyBar aboveSubview:cell.easyBlue];
        [cell.contentView insertSubview:mediumBar aboveSubview:cell.mediumBlue];
        [cell.contentView insertSubview:hardBar aboveSubview:cell.hardBlue];
    }
    
    
    
    return cell;
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
