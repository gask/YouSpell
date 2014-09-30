//
//  DefinitionView.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 9/25/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefinitionView : UIViewController

@property (strong, nonatomic) NSString *word;
@property (strong, nonatomic) NSString *definition;
@property (strong, nonatomic) IBOutlet UILabel *definitionLabel;
@property (strong, nonatomic) IBOutlet UILabel *wordLabel;

@end
