//
//  IAPHelper.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/28/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <StoreKit/StoreKit.h>
UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
- (void)buyProduct:(SKProduct *)product;
- (BOOL)productPurchased:(NSString *)productIdentifier;
- (void)restoreCompletedTransactions;
- (void)setConsumableProducts: (NSSet *)productIdentifiers;
- (void)setNonConsumableProducts: (NSSet *)productIdentifiers;
- (BOOL)isNonConsumable: (NSString *)productIdentifier;


@end