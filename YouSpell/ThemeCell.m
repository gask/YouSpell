//
//  ThemeCell.m
//  YouSpell
//
//  Created by Francisco F Neto on 18/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "ThemeCell.h"

@implementation ThemeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    //NSLog(@"isso ta sim sendo chamado..");
    
//    self.coinAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(264,10,20,20)];
//    
//    NSArray *coinImages = [NSArray arrayWithObjects:
//                  [UIImage imageNamed:@"coin1.png"],
//                  [UIImage imageNamed:@"coin2.png"],
//                  [UIImage imageNamed:@"coin3.png"],
//                  [UIImage imageNamed:@"coin4.png"],
//                  nil];
//    
//    self.coinAnimationView.animationImages = coinImages;
//    self.coinAnimationView.animationDuration = 0.5;
//    self.coinAnimationView.animationRepeatCount = 0;
//    [self.coinAnimationView startAnimating];
//    [self addSubview: self.coinAnimationView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    /*self.coinAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(264,10,20,20)];
    
    NSArray *coinImages = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"coin1.png"],
                           [UIImage imageNamed:@"coin2.png"],
                           [UIImage imageNamed:@"coin3.png"],
                           [UIImage imageNamed:@"coin4.png"],
                           nil];
    
    self.coinAnimationView.animationImages = coinImages;
    self.coinAnimationView.animationDuration = 0.5;
    self.coinAnimationView.animationRepeatCount = 0;
    [self.coinAnimationView startAnimating];
    [self addSubview: self.coinAnimationView];*/
}

@end
