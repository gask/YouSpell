//
//  Store.m
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 10/28/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "Store.h"
#import <StoreKit/StoreKit.h>
#import "SpellIAP.h"
#import "AppConstants.h"

@interface Store () {
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;
    BOOL waitForIt;
}
@end

@implementation Store

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.view setUserInteractionEnabled: NO];
    waitForIt = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchasedProduct:) name:IAPHelperProductPurchasedNotification object:nil];
    
    [coinLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:18.0]];
    [titleLabel setFont:[UIFont fontWithName:@"Delicious-Roman" size:20.0]];
    [coinLabel setText:[NSString stringWithFormat:@"%i", [[NSUserDefaults standardUserDefaults] integerForKey: COINS]]];
    
    /*self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [mainTable addSubview:self.refreshControl];
    [self reload];
    [self.refreshControl beginRefreshing];*/
    
    [self reload];
    
    displayProducts = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"products" ofType:@"plist"]];
    //NSLog(@"cremosao: %@", displayProducts);
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) purchasedProduct:(NSNotification *)notification
{
    NSLog(@"Entregando produto...");
    NSString *productIdentifier = notification.object;
    NSInteger coins = [[NSUserDefaults standardUserDefaults] integerForKey:COINS];
    
    if([productIdentifier isEqualToString:ONEPACK]) coins+=1000;
    else if ([productIdentifier isEqualToString:TWOHALFPACK]) coins+=2500;
    else if ([productIdentifier isEqualToString:FOURPACK]) coins+=4000;
    else if ([productIdentifier isEqualToString:TENPACK]) coins+=10000;
    
    [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:COINS];
    [coinLabel setText:[NSString stringWithFormat:@"%i", coins]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reload {
    
    [self.view setUserInteractionEnabled: YES];
    _products = nil;
    //[mainTable reloadData];
    [[SpellIAP sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        NSLog(@"WAIT FOR IT NO!");
        waitForIt = NO;
        if (success) {
            _products = products;
            //[mainTable reloadData];
        }
        //[self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return displayProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell" forIndexPath:indexPath];
    
    NSDictionary *product = displayProducts[indexPath.row];
    cell.textLabel.text = [product objectForKey:@"name"];
    
    //[_priceFormatter setLocale:product.priceLocale];
    //cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
    
    if ([[SpellIAP sharedInstance] productPurchased: [product objectForKey: @"productID"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
    } else {
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buyButton.frame = CGRectMake(0, 0, 72, 37);
        [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        buyButton.tag = indexPath.row;
        [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = buyButton;
    }
    
    return cell;
}

- (void)buyButtonTapped:(id)sender {
    
    if(waitForIt)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Spell" message: @"Please wait. Store loading." delegate: nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    
    UIButton *buyButton = (UIButton *)sender;
    NSLog(@"buyButtonTapped");
    if(_products == nil)
    {
        NSLog(@"_products == nil");
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator setFrame: CGRectMake(self.view.center.x, self.view.center.y, 100.0, 100.0)];
        [self.view addSubview:indicator];
        [self.view setUserInteractionEnabled: NO];
        [self.view bringSubviewToFront:indicator];
        [indicator startAnimating];
        
        [[SpellIAP sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            
            [indicator stopAnimating];
            [indicator removeFromSuperview];
            [self.view setUserInteractionEnabled: YES];
            
            if (success)
            {
                _products = products;
                
                NSDictionary *prod = [displayProducts objectAtIndex:buyButton.tag];
                NSString *prodName = [prod objectForKey:@"productID"];
                SKProduct *product = [self productForID:prodName];
                
                NSLog(@"Buying %@...", product.productIdentifier);
                [[SpellIAP sharedInstance] buyProduct:product];
                
            }
            else
            {
                // say internet has a problem.
                NSLog(@"internet error.");
            }
        }];
    }
    else
    {
        NSLog(@"_products != nil");
        NSDictionary *prod = [displayProducts objectAtIndex:buyButton.tag];
        NSString *prodName = [prod objectForKey:@"productID"];
        SKProduct *product = [self productForID:prodName];
    
        NSLog(@"Buying %@...", product.productIdentifier);
        [[SpellIAP sharedInstance] buyProduct:product];
    }
    
}

- (IBAction)restoreTapped:(id)sender {
    [[SpellIAP sharedInstance] restoreCompletedTransactions];
}

- (SKProduct *)productForID: (NSString *)productID
{
    SKProduct *theProduct;
    for (SKProduct * skProduct in _products)
    {
        //NSLog(@"ESQUERDO-MACHO: %@",skProduct.productIdentifier);
        if([skProduct.productIdentifier isEqualToString:productID])
        {
            theProduct = skProduct;
            return theProduct;
        }
    }
    
    return nil;
}

- (void) viewWillDisappear:(BOOL)animated
{
    NSLog(@"chega de listenar Store!");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
