//
//  TinyShopViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TinyShopViewController : UIViewController

@property(nonatomic) IBOutlet UILabel *coinsNotifLabel;
@property(nonatomic) IBOutlet UILabel *testerLabel;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end
