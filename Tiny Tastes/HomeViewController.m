//
//  HomeViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "HomeViewController.h"
#import <UIKit/UIKit.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"book_cover.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.storyModeLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.letsEatLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.letsDrinkLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.tinyShopLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.settingsLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.numCoinsLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    [self.bookTitleLabel setTextColor:[UIColor whiteColor]];
    [self.storyModeLabel setTextColor:[UIColor whiteColor]];
    [self.letsEatLabel setTextColor:[UIColor whiteColor]];
    [self.letsDrinkLabel setTextColor:[UIColor whiteColor]];
    [self.tinyShopLabel setTextColor:[UIColor whiteColor]];
    [self.settingsLabel setTextColor:[UIColor whiteColor]];
    
    NSInteger myNumCoins = [[NSUserDefaults standardUserDefaults] integerForKey:@"coinsKey"];
    self.numCoinsLabel.text = [NSString stringWithFormat:@"%d", myNumCoins];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedOnce"]) {
        [prefs setBool:YES forKey:@"sound"];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (UIImage *)resizedImageWithSize:(UIImage *)image setSize:(CGSize)size
{
	UIGraphicsBeginImageContext(size);
	[image drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
