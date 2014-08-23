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

- (id)initWithFrame:(CGRect)frame andPosition: (NSInteger) pos
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"iPhone-Letter" owner:self options:nil];
        
        self = (LetterButton *)[nib objectAtIndex:0];
        
    }
    return self;
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
