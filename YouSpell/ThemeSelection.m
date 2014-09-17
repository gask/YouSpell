//
//  ThemeSelection.m
//  YouSpell
//
//  Created by Francisco F Neto on 14/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "ThemeSelection.h"
#import "GameScene.h"

#define WORDS_PER_THEME 3

@interface ThemeSelection ()

@end

@implementation ThemeSelection

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
    
    wordsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    selectedTheme = -1;
    themeNames = [NSArray arrayWithObjects:
                  @"Animals",
                  @"Games",
                  @"Body Parts",
                  @"Cars",
                  @"Colors",
                  @"Countries",
                  @"Enterprises",
                  @"Flowers???",
                  @"Fruits",
                  @"Globe???",
                  @"Case???",
                  @"Movies",
                  @"Bands",
                  @"Utils",
                  @"Soccer Teams",
                  @"Sports",
                  nil];
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (NSIndexPath *) tableView: (UITableView *) tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selecionei o %io botão!", indexPath.row+1);
    selectedTheme = indexPath.row;
    [self performSegueWithIdentifier:@"CallGameScene" sender:self];
    
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"selectedTheme: %i", selectedTheme);
    
    if ([[segue identifier] isEqualToString:@"CallGameScene"])
    {
        // Get destination view
        GameScene *vc = [segue destinationViewController];
        
        int r = arc4random_uniform(WORDS_PER_THEME);
        NSLog(@"selected Word: %i", r);
        
        vc.theWord = [[[wordsArray objectAtIndex:selectedTheme] objectAtIndex:r] uppercaseString];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    //UIImageView *image = nil;
    
    
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
        
        //NSInteger row = indexPath.row+1;
        
        //image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", row]]];
        //cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", row]];
        //[image setFrame:CGRectMake(0,0, 50, 50)];
        //image.tag = 100;
        
        //[cell.contentView addSubview:image];
        
       // NSLog(@"%i",row);
    }
    
    NSInteger row = indexPath.row+1;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"a%i.png", row]];
    cell.textLabel.text = [themeNames objectAtIndex:row-1];
    
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
