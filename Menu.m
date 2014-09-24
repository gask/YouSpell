//
//  Menu.m
//  YouSpell
//
//  Created by Francisco F Neto on 18/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "Menu.h"

@interface Menu ()

@end

@implementation Menu


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
