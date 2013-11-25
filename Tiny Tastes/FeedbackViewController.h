//
//  FeedbackViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/22/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FeedbackViewController : UIViewController

@property(nonatomic) IBOutlet UILabel *feedbackLabel;
@property(nonatomic) IBOutlet UIButton *goShoppingLabel;
@property(nonatomic) IBOutlet UIButton *mainMenuLabel;
@property(nonatomic) IBOutlet UILabel *coinsNotifLabel;

@property(nonatomic) IBOutlet UIImageView *coinView1;
@property(nonatomic) IBOutlet UIImageView *coinView2;
@property(nonatomic) IBOutlet UIImageView *coinView3;

@property(nonatomic) NSString *feedbackText;
@property(nonatomic) int numCoins;
@property(nonatomic) BOOL eating;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end
