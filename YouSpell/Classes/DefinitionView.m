//
//  DefinitionView.m
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 9/25/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "DefinitionView.h"
#import "WinLose.h"

@interface DefinitionView ()

@end

@implementation DefinitionView

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
    //NSLog(@"4 5 6");
    self.definitionLabel.text = self.definition;
    self.wordLabel.text = self.word;
    //[self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissDefinitionVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
