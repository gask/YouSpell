//
//  LetterButton.h
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterButton : UIButton

enum LetterButtonType {typeButton, typeLabel};

- (id)initWithFrame:(CGRect)frame position: (NSInteger) pos andLetter: (NSString *) letter andState: (enum LetterButtonType) state;

- (IBAction)handlePan:(id)recognizer;
- (void) setSelectable;

@property (nonatomic) NSInteger position;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL typeChanged;
@property (nonatomic) enum LetterButtonType isButton;

@end
