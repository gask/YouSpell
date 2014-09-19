//
//  ThemeCell.h
//  YouSpell
//
//  Created by Francisco F Neto on 18/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *themeImage;
@property (strong, nonatomic) IBOutlet UILabel *themeName;
@property (strong, nonatomic) IBOutlet UILabel *themeScore;

@end
