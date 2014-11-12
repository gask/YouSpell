//
//  RankCell.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 11/12/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankCell : UITableViewCell
{
    IBOutlet UILabel *themeTitle;
    IBOutlet UIImageView *themeImage;
    IBOutlet UILabel *easyPercentage;
    IBOutlet UILabel *mediumPercentage;
    IBOutlet UILabel *hardPercentage;
    IBOutlet UIImageView *easyStar;
    IBOutlet UIImageView *mediumStar;
    IBOutlet UIImageView *hardStar;
}
@end
