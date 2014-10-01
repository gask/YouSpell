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
}

@property (nonatomic) IBOutlet UILabel *feedback;
@property (nonatomic) BOOL didWon;
@property (nonatomic) const char *word;
@property (nonatomic) NSString *stringWord;

@property (nonatomic, strong) TransitionDelegate *transitionController;

@end