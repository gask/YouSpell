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

- (id)initWithFrame:(CGRect)frame position: (NSInteger) pos andLetter: (NSString *) letter
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
        self.selected = YES;

        [self addTarget:self action:@selector(doIt) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) doIt
{
    NSLog(@"yay!");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FlushButtons" object:[NSNumber numberWithInteger:self.position]];
    
    //self.selected = YES;
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
