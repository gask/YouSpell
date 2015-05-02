//
//  AppDelegate.h
//  YouSpell
//
//  Created by Francisco F Neto on 20/08/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InMobi.h"
#import "IMConstants.h"
#import <Chartboost/Chartboost.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, ChartboostDelegate> {
    NSUserDefaults *userDefaults;
}

@property (strong, nonatomic) UIWindow *window;

+(int)returnTimesOpened;

@end
