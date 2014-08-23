//
//  LetterButton.h
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterButton : UIButton

- (id)initWithFrame:(CGRect)frame andPosition: (NSInteger) pos;

@property (nonatomic) NSInteger position;
@property (nonatomic) BOOL selected;


@end
