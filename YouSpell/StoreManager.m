//
//  StoreManager.m
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/27/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "StoreManager.h"
#import "AppConstants.h"

@implementation StoreManager 
/*{
    // 3
    SKProductsRequest * _productsRequest;
    // 4
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}*/


-(void)getProductInfo: (NSString *)productID controller: (UIViewController *)viewController
{
    NSLog(@"PEGA O BANDIDO!!!!");

    if ([SKPaymentQueue canMakePayments])
    {
        NSLog(@"presunto");
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: productID]];
        request.delegate = self;
        
        [request start];
        
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
        indicator.center = viewController.view.center;
        [viewController.view addSubview:indicator];
        [indicator bringSubviewToFront:viewController.view];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    }

}

#pragma mark -
#pragma mark SKProductsRequestDelegate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"mussarela");
    [indicator removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    indicator = nil;
    
    NSArray *products = response.products;
    NSLog(@"prods: %@", products);
    if (products.count != 0)
    {
        _product = products[0];
        //_buyButton.enabled = YES;
        //_productTitle.text = _product.localizedTitle;
        //_productDescription.text = _product.localizedDescription;
        
        SKPayment *payment = [SKPayment paymentWithProduct:_product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else
    {
        // product not found
        
        NSLog(@"Product not found.");
    }
    
    products = response.invalidProductIdentifiers;
    
    for (SKProduct *product in products)
    {
        NSLog(@"Product not found: %@", product);
    }
}

- (void) request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"Fail with error: %@", error);
    [indicator removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    indicator = nil;
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                //[self unlockFeature];
                NSLog(@"Unlock the feature the status is OK!");
                [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                NSLog(@"Transaction Failed");
                [self failedTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}


- (void)provideContentForProductIdentifier:(NSString *)productIdentifier
{
    NSInteger coins = [[NSUserDefaults standardUserDefaults] integerForKey:COINS];
    
    NSLog(@"epa epa %@", productIdentifier);
    
    if([productIdentifier isEqualToString:ONEPACK])
    {coins+=1000; NSLog(@"tumida di gatu");}
    else if ([productIdentifier isEqualToString:TWOHALFPACK]) {coins+=2500;}
    else if ([productIdentifier isEqualToString:FOURPACK]) {coins+=4000;}
    else if ([productIdentifier isEqualToString:TENPACK]) {coins+=10000;}
    else NSLog(@"ACA SUZELA");
    
    [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:COINS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PurchasedProduct" object:productIdentifier userInfo:nil];
    
}

@end
