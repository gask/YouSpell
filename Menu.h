//
//  Menu.h
//  YouSpell
//
//  Created by Francisco F Neto on 18/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"
#import "IMIncentivisedDelegate.h"
#import "IMNative.h"
#import "IMNativeDelegate.h"
#import "IMError.h"
#import "InMobiAnalytics.h"
#import <Chartboost/Chartboost.h>

@interface Menu : UIViewController <IMBannerDelegate, ChartboostDelegate>{
    IBOutlet UILabel *coinsPocket;
    IBOutlet UIButton *storeBtn;
    IBOutlet UIButton *playBtn;
}
@property (nonatomic, strong) IMBanner *banner;


@end
