//
//  ThemeSelection.h
//  YouSpell
//
//  Created by Francisco F Neto on 14/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>

@interface ThemeSelection : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *mainTable;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *backBtn;
    
    NSInteger selectedTheme;
    
    NSArray *themes;
    NSArray *coinImages;
    NSArray *wordsArray;
    NSMutableArray *userScore;
    NSMutableArray *themeScores;
    NSMutableArray *themeTotals;
    NSMutableArray *hasTheme;
}



@end
