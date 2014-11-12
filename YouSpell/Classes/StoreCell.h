//
//  StoreCell.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/31/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *packName;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet UIImageView *coinImage;

@end
