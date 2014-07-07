//
//  ShopInteriorViewController.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.07..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "ShopInteriorViewController.h"

@interface ShopInteriorViewController () {
    UIStatusBarStyle statusbarStyle; //retain status bar style to reset when leaving shop
}

@end

@implementation ShopInteriorViewController

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
    
    //Set background
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"shop_interior_background"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //Retain and change status bar style
    statusbarStyle = [[UIApplication sharedApplication] statusBarStyle];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    //Reset status bar style
    [[UIApplication sharedApplication] setStatusBarStyle:statusbarStyle animated:NO];
}

#pragma mark - Carousel


- (IBAction)leftArrowPressed:(id)sender {
}

- (IBAction)rightArrowPressed:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)backButtonPressed:(id)sender {
    //Go back
    [self.navigationController popViewControllerAnimated:YES];
}

@end
