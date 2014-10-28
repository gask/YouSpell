//
//  StoreManager.h
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/27/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

//typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface StoreManager : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    UIActivityIndicatorView *indicator;
}

//- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
//- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@property (strong, nonatomic) SKProduct *product;

-(void)getProductInfo: (NSString *)productID controller: (UIViewController *)viewController;



@end
