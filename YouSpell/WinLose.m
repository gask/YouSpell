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


@interface WinLose ()

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
    //NSLog(@"newSize: %f",newSize);
    //NSLog(@"Then newSize: %f",newSize);
    
    for(NSInteger u = 0 ; u < strlen(self.word) ; u++)
    {
        LetterButton *tButton = (LetterButton *) [rightWordLetters objectAtIndex:u];
        //        CGSize nSize = CGSizeMake(newSize, newSize);
        
        float startingXPos = self.view.center.x - (numberOfLetters/2.0f * newSize);
        
        [tButton setFrame:CGRectMake(startingXPos+u*newSize, self.view.center.y, newSize, newSize)];
        
    }
}

- (IBAction)displaySecondVC:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    DefinitionView *vc = [storyboard instantiateViewControllerWithIdentifier:@"DefinitionVC"];
    vc.view.backgroundColor = [UIColor clearColor];
    [vc setTransitioningDelegate:transitionController];
    vc.modalPresentationStyle= UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self setModalPresentationStyle:UIModalPresentationCurrentContext];
    //[self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    rightWordLetters = [NSMutableArray array];
    //NSLog(@"pernambucano também: %s com tam: %lu", self.word, strlen(self.word));
    float lSize = INITIAL_LETTERSIZE;
    
    lSize = SPACE/(strlen(self.word));
    
    if(lSize > INITIAL_LETTERSIZE) lSize = INITIAL_LETTERSIZE;
    //
    
    for(NSInteger i = 0 ; i < strlen(self.word) ; i++)
    {
        //NSLog(@"%d",i);
        LetterButton *l = [[LetterButton alloc] initWithFrame: CGRectMake(0,0,0,0) position:i andLetter: [NSString stringWithFormat:@"%c" , self.word[i]] andState:typeLabel];
        
        [rightWordLetters addObject:l];
        [self.view addSubview:l];
    }
    [self resizeLetters:lSize andNumberOfLetters:(float)strlen(self.word)];

    
    if(self.didWon) self.feedback.text = @"YAY! You won! :)";
    else self.feedback.text = @"Sorry, better luck next time :(";
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
