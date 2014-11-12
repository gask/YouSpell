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
    
    scoresArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Scores"];
    themeData = [NSMutableArray array];
    for (int i = 0; i < [scoresArray[0] count];  i++)
    {
        [themeData addObject:[NSDictionary dictionary]];
        
        
        
        [themeData[i] setObject: [NSString stringWithFormat:@""] forKey:@"themeName"];
        [themeData[i] setObject: [NSNumber numberWithFloat:1.0]forKey:@"easyPercentage"];
        [themeData[i] setObject: [NSNumber numberWithFloat:1.0]forKey:@"mediumPercentage"];
        [themeData[i] setObject: [NSNumber numberWithFloat:1.0]forKey:@"hardPercentage"];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCell" forIndexPath:indexPath];
    
    
    
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
