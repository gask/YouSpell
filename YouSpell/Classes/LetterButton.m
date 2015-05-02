//
//  LetterButton.m
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "LetterButton.h"

@implementation LetterButton

@synthesize position, selected;



- (id)initWithFrame:(CGRect)frame position: (NSInteger) pos andLetter: (NSString *) letter andState: (enum LetterButtonType) state
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"iPhone-Letter" owner:self options:nil];
        
        self = (LetterButton *)[nib objectAtIndex:0];
        self.frame = frame;
        
        [self setTitle:letter forState:UIControlStateNormal];
        [self setTitle:letter forState:UIControlStateSelected];
        [self setTitle:letter forState:UIControlStateHighlighted];
        self.position = pos;
        self.isSelected = YES;
        self.isButton = state;
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.lineBreakMode = NSLineBreakByClipping;
        
        [self.titleLabel setFont: [UIFont fontWithName:@"Delicious-Roman" size:15.0]];

        if(state == typeButton) [self addTarget:self action:@selector(doIt) forControlEvents:UIControlEventTouchUpInside];
        self.typeChanged = NO;
    }
    return self;
}

- (void) setSelectable
{
    self.isButton = typeButton;
    [self addTarget:self action:@selector(doIt) forControlEvents:UIControlEventTouchUpInside];
    self.typeChanged = YES;
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
{
    if(self.isButton == typeLabel) return;
    if(self.typeChanged) return;
    
    CGPoint translation = [recognizer translationInView:self];
    
    //NSLog(@"tr: %f, %f, %d", translation.x, translation.y, recognizer.state);
    
    if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        
    }
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if(translation.y < -30.0f)
        {
            //confirm remove
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveLetter" object:[NSNumber numberWithInteger:self.position]];
        }
    }
    
    
    //recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    
    //[recognizer setTranslation:CGPointMake(0, 0) inView:self];
}

- (void) doIt
{
    if(self.isButton == typeLabel) return;
//    NSLog(@"yay!");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FlushButtons" object:[NSNumber numberWithInteger:self.position]];
    
    //self.isSelected = YES;
    //[self setBackgroundColor:[UIColor redColor]];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
