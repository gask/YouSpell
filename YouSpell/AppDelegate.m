//
//  AppDelegate.m
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "AppDelegate.h"
#import "SpellIAP.h"
#import <CoreLocation/CoreLocation.h>
#import <Chartboost/Chartboost.h>
#import <Chartboost/CBNewsfeed.h>
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>

@implementation AppDelegate
static timesOpened;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [SpellIAP sharedInstance];
    [Chartboost startWithAppId:@"55215d0f04b016709b0bb0e3" appSignature:@"b5ab27b15b0bcbb9e51177a246c0a6e70db3418f" delegate:self];
    [InMobi initialize:@"6708b781839d47c29dadd2a3bc934e57"];
    CLLocationManager *mgr = [[CLLocationManager alloc] init];
    CLLocation *loc = mgr.location;
    [InMobi setLocationWithLatitude:loc.coordinate.latitude longitude:loc.coordinate.longitude accuracy:loc.horizontalAccuracy];
    [mgr startUpdatingLocation];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    timesOpened = [userDefaults integerForKey:@"timesOpened"];
    [self updateTimesOpened];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    [self updateTimesOpened];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

-(void)updateTimesOpened{
    timesOpened++;
    NSLog(@"timesOpened: %d", timesOpened);
    [userDefaults setInteger:timesOpened forKey:@"timesOpened"];
    [userDefaults synchronize];
}

+(int)returnTimesOpened{
    return timesOpened;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Called before requesting an interstitial via the Chartboost API server.
- (BOOL)shouldRequestInterstitial:(CBLocation)location{
    NSLog(@"1a");
    return true;
}

// Called before an interstitial will be displayed on the screen.
- (BOOL)shouldDisplayInterstitial:(CBLocation)location{
    NSLog(@"2a");
    return true;
}

// Called after an interstitial has been displayed on the screen.
- (void)didDisplayInterstitial:(CBLocation)location{
    NSLog(@"3a");
}

// Called after an interstitial has been loaded from the Chartboost API
// servers and cached locally.
- (void)didCacheInterstitial:(CBLocation)location{
    NSLog(@"4a");
}

// Called after an interstitial has attempted to load from the Chartboost API
// servers but failed.
- (void)didFailToLoadInterstitial:(CBLocation)location withError:(CBLoadError)error{
    NSLog(@"chartBoostFailedsfafsdf: %u", error);
    // TODO: chamar InMobi em caso de falha
}

@end
