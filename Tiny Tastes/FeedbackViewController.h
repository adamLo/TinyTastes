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

@property(nonatomic, weak) IBOutlet UILabel *feedbackLabel;
@property(nonatomic, weak) IBOutlet UIButton *goShoppingLabel;
@property(nonatomic, weak) IBOutlet UIButton *mainMenuLabel;
@property(nonatomic, weak) IBOutlet UILabel *coinsNotifLabel;

@property(nonatomic, weak) IBOutlet UIImageView *coinView1;
@property(nonatomic, weak) IBOutlet UIImageView *coinView2;
@property(nonatomic, weak) IBOutlet UIImageView *coinView3;

@property(nonatomic, weak) NSString *feedbackText;
@property(nonatomic, assign) int numCoins;
@property(nonatomic, assign) BOOL eating;

- (IBAction)homePressed:(id)sender; /** User pressed home button to go back to home screen */
- (IBAction)shopPressed:(id)sender; /** User pressed shop button to go shopping */

@end
