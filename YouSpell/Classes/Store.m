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
}
@end

@implementation Store

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchasedProduct:) name:@"PurchasedProduct" object:nil];
    
    [titleLabel setText: @"Coin Store"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [mainTable addSubview:self.refreshControl];
    [self reload];
    [self.refreshControl beginRefreshing];
    
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) purchasedProduct:(NSNotification *)notification
{
    NSString *productIdentifier = notification.object;
    NSInteger coins = [[NSUserDefaults standardUserDefaults] integerForKey:COINS];
    
    if([productIdentifier isEqualToString:ONEPACK]) coins+=1000;
    else if ([productIdentifier isEqualToString:TWOHALFPACK]) coins+=2500;
    else if ([productIdentifier isEqualToString:FOURPACK]) coins+=4000;
    else if ([productIdentifier isEqualToString:TENPACK]) coins+=10000;
    
    [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:COINS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reload {
    _products = nil;
    [mainTable reloadData];
    [[SpellIAP sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [mainTable reloadData];
        }
        [self.refreshControl endRefreshing];
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
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell" forIndexPath:indexPath];
    
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
    
    [_priceFormatter setLocale:product.priceLocale];
    cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
    
    if ([[SpellIAP sharedInstance] productPurchased:product.productIdentifier]) {
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
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[SpellIAP sharedInstance] buyProduct:product];
    
}

- (void)restoreTapped:(id)sender {
    [[SpellIAP sharedInstance] restoreCompletedTransactions];
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
