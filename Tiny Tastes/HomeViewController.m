//
//  HomeViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:183/255.0f green:239/255.0f blue:243/255.0f alpha:1.0f];
    self.storyModeLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.letsEatLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.letsDrinkLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.tinyShopLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.settingsLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.numCoinsLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
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

@end
