//
//  SpellIAP.m
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/28/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "SpellIAP.h"
#import "AppConstants.h"

@implementation SpellIAP

+ (SpellIAP *)sharedInstance {
    static dispatch_once_t once;
    static SpellIAP * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      ONEPACK,
                                      TWOHALFPACK,
                                      FOURPACK,
                                      TENPACK,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    
    [sharedInstance setNonConsumableProducts:[NSSet setWithObjects:
                                              nil]];
    
    [sharedInstance setConsumableProducts:[NSSet setWithObjects:
                                           ONEPACK,
                                           TWOHALFPACK,
                                           FOURPACK,
                                           TENPACK,
                                           nil]];
    
    return sharedInstance;
}

@end
