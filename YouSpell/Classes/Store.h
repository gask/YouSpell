//
//  Store.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/28/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Store : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *mainTable;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *backBtn;
    NSArray *displayProducts;
    IBOutlet UILabel *coinLabel;
}

@property(nonatomic, retain) UIRefreshControl *refreshControl;

- (IBAction)restoreTapped:(id)sender;

@end
