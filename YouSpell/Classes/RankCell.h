//
//  RankCell.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 11/12/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankCell : UITableViewCell

@property IBOutlet UILabel *themeTitle;
@property IBOutlet UIImageView *themeImage;
@property IBOutlet UILabel *easyPercentage;
@property IBOutlet UILabel *mediumPercentage;
@property IBOutlet UILabel *hardPercentage;
@property IBOutlet UIImageView *easyStar;
@property IBOutlet UIImageView *mediumStar;
@property IBOutlet UIImageView *hardStar;
@property IBOutlet UILabel *easyStreak;
@property IBOutlet UILabel *mediumStreak;
@property IBOutlet UILabel *hardStreak;
@property (strong, nonatomic) IBOutlet UIView *easyBlue;
@property (strong, nonatomic) IBOutlet UIView *mediumBlue;
@property (strong, nonatomic) IBOutlet UIView *hardBlue;


@end
