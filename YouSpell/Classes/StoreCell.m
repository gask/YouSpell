//
//  StoreCell.m
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/31/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
