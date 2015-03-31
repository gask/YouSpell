//
//  WinLose.h
//  YouSpell
//
//  Created by Francisco F Neto on 17/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionDelegate.h"

@interface WinLose : UIViewController
{
    NSMutableArray *rightWordLetters;
    NSArray *wordsArray;
    NSInteger selectedTheme;
    IBOutlet UIImageView *titleBack;
    IBOutlet UILabel *gainedCoins;
}

@property (nonatomic) IBOutlet UILabel *feedback;
@property (nonatomic) BOOL didWon;
@property (nonatomic) const char *word;
@property (nonatomic) NSString *stringWord;
@property (nonatomic) IBOutlet UILabel *themeLabel;
@property (strong, nonatomic) IBOutlet UILabel *progressPerc;
@property (strong, nonatomic) IBOutlet UIView *blueBar;
@property (strong, nonatomic) IBOutlet UIButton *definitionBtn;

@property (nonatomic, strong) TransitionDelegate *transitionController;
@property (strong, nonatomic) IBOutlet UIButton *nextWordBtn;

@end
