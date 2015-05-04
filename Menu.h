//
//  Menu.h
//  YouSpell
//
//  Created by Francisco F Neto on 18/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Chartboost/Chartboost.h>

@interface Menu : UIViewController <ChartboostDelegate>{
    IBOutlet UILabel *coinsPocket;
    IBOutlet UIButton *storeBtn;
    IBOutlet UIButton *playBtn;
}

@end
