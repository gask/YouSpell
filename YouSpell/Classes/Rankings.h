//
//  Rankings.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 11/12/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankCell.h"

@interface Rankings : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *mainTable;
    NSArray *scoresArray;
    NSMutableArray *themeData;
}
@end
