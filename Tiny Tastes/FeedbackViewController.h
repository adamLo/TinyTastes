//
//  FeedbackViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/22/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController

@property(nonatomic) IBOutlet UILabel *feedbackLabel;
@property(nonatomic) IBOutlet UILabel *goShoppingLabel;
@property(nonatomic) IBOutlet UILabel *mainMenuLabel;
@property(nonatomic) IBOutlet UILabel *coinsNotifLabel;

@property(nonatomic) IBOutlet UIImageView *coinView1;
@property(nonatomic) IBOutlet UIImageView *coinView2;
@property(nonatomic) IBOutlet UIImageView *coinView3;

@property(nonatomic) NSString *feedbackText;
@property(nonatomic) int numCoins;

@end
