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

    UIImage *image = [UIImage imageNamed:@"menu_page.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    storyModeLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    letsEatLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    letsDrinkLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    tinyShopLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    settingsLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
    [storyModeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsEatLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsDrinkLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tinyShopLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingsLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
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
