//
//  StoryDataViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "StoryDataViewController.h"
#import "StoryViewController.h"

@interface StoryDataViewController ()
@property (strong, nonatomic) StoryViewController *viewController;
@end

@implementation StoryDataViewController
@synthesize viewController = _viewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIImageView *image in self.dataObject.images) {
        [self.view addSubview:image];
    }
    NSInteger tagCount = 0;
    for (UIButton *button in self.dataObject.links) {
        [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:tagCount];
        [self.view addSubview:button];
        tagCount++;
    }
    for (UILabel *text in self.dataObject.text) {
        NSLog(@"Text is: %@", text.text);
        [self.view addSubview:text];
    }
}

- (void) changeViewController:(UIButton*)button
{
    NSInteger buttonId = [button tag];
    [_viewController changeViewController:[self.dataObject.linkDestinations objectAtIndex:buttonId]];
}

- (void) addButtons:(id) vc
{
    StoryViewController *vcontroller = (StoryViewController *) vc;
    _viewController = vcontroller;
}

@end