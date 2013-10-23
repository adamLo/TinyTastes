//
//  TinyShopViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "TinyShopViewController.h"

@interface TinyShopViewController ()

@end

@implementation TinyShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.coinsNotifLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    NSInteger myNumCoins = [[NSUserDefaults standardUserDefaults] integerForKey:@"coinsKey"];
    self.coinsNotifLabel.text = [NSString stringWithFormat:@"You have %d coins", myNumCoins];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
