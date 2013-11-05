//
//  StoryDataViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "StoryDataViewController.h"

@interface StoryDataViewController ()

@end

@implementation StoryDataViewController

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
    
    self.dataLabel.text = [self.dataObject sceneID];
    for (UIImageView *image in self.dataObject.images) {
        [self.view addSubview:image];
    }
    for (UIButton *button in self.dataObject.links) {
        [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    self.dataLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:45];
}

- (void) buttonPressed:(NSString *) label
{
    
}

@end