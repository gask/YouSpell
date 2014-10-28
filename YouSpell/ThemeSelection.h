//
//  ThemeSelection.h
//  YouSpell
//
//  Created by Francisco F Neto on 14/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#include <stdlib.h>
#import "StoreManager.h"

@interface ThemeSelection : UIViewController <UITableViewDelegate, UIAlertViewDelegate>
{
    IBOutlet UITableView *mainTable;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *backBtn;
    
    NSIndexPath *selectedTheme;
    
    NSArray *themes;
    NSMutableArray *tableCells;
    NSArray *coinImages;
    NSArray *wordsArray;
    NSMutableArray *userScore;
    NSMutableArray *themeScores;
    NSMutableArray *themeTotals;
    NSMutableArray *hasTheme;
}

@property (strong, nonatomic) StoreManager *storeManager;

@end
