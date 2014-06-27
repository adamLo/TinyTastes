//
//  StoryDataViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "StoryDataViewController.h"
#import "StoryViewController.h"
#import "StoryModelController.h"

@interface StoryDataViewController () {
    UIImage *bookmarkImage; //Resizable bookmark image
    UIImageView *bookmarkView; //Bookmark view
    UILabel *bookmarkLabel; //Localized instruction label on bookmark. Displayed on title only when bookmark is set
    UITapGestureRecognizer *bookmarTapGestureRecognizer; //Recognizer for user tap action
}
@property (weak, nonatomic) StoryViewController *viewController;
@property (nonatomic, assign) BOOL loaded;
@end

@implementation StoryDataViewController
@synthesize viewController = _viewController;
@synthesize loaded = _loaded;
@synthesize backButton = _backButton;
@synthesize skipButton = _skipButton;

CGFloat const kStoryBookmarkHeightHidden = 30; //Bookmark height when not displayed
CGFloat const kStoryBookmarkHeightSet = 107; //Bookmark height when set
NSString* const kStoryBookmarkDefaultsKey = @"BookmarkedStorySceneId"; //Key in NSUSerdefaults for bookmark

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLoaded:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.33 green:0.32 blue:0.32 alpha:1.0];
    _loaded = [self loaded];
    
    //Create bookmark image
    bookmarkImage = [[UIImage imageNamed:@"bookmark"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 25, 0)];
    bookmarkView = [[UIImageView alloc] initWithFrame:CGRectMake(750, 45, 47, kStoryBookmarkHeightSet)];
    bookmarkView.image = bookmarkImage;
    [self.view addSubview:bookmarkView];
    
    //Add go label to bookmark
    bookmarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 18, bookmarkView.frame.size.width - 16, bookmarkView.frame.size.height - 35)];
    bookmarkLabel.text = @"bookmark"; //Placeholder
    bookmarkLabel.numberOfLines = 0;
    bookmarkLabel.textColor = [UIColor whiteColor];
    bookmarkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    bookmarkLabel.textAlignment = NSTextAlignmentCenter;
    bookmarkLabel.font = [UIFont systemFontOfSize:10.0];
    [bookmarkView addSubview:bookmarkLabel];
    bookmarkLabel.autoresizingMask = 0;
    
    //Add tap gesture to bookmark
    bookmarTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bookmarkTapped:)];
    [bookmarkView addGestureRecognizer:bookmarTapGestureRecognizer];
    bookmarkView.userInteractionEnabled = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.view.backgroundColor = [UIColor colorWithRed:0.33 green:0.32 blue:0.32 alpha:1.0];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIImageView *image in self.dataObject.images) {
        [self.view addSubview:image];
    }
    
    if (self.dataObject.titlePage == YES) {
        [self displayNarration];
        [_narrationButton addTarget:self action:@selector(toggleNarration) forControlEvents:UIControlEventTouchUpInside];
        [self.view bringSubviewToFront:_narrationButton];
    }
    [self.view bringSubviewToFront:_backButton];
    [self.view bringSubviewToFront:_skipButton];
    
    //Draw animations
    for (UIImageView *imageView in self.dataObject.animations) {
        [self.view addSubview:imageView];
        [imageView startAnimating];
    }
    
    NSInteger tagCount = 0;
    for (UIButton *button in self.dataObject.links) {
        UIButton *buttonCopy = [[UIButton alloc] initWithFrame:button.frame];
        [buttonCopy addTarget:self action:@selector(changeSceneStack:) forControlEvents:UIControlEventTouchUpInside];
        [buttonCopy setTag:tagCount];
        [self.view addSubview:buttonCopy];
        tagCount++;
    }
    
    //Set up bookmark
    [self setupBookmark];
    
}

- (void)viewDidAppear:(BOOL)animated {
    //Start playing narration
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        for (AVAudioPlayer *audioPlayer in self.dataObject.sounds) {
            [audioPlayer setCurrentTime:0.0];
            [audioPlayer play];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    //Stop sounds
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        for (AVAudioPlayer __strong *audioPlayer in self.dataObject.sounds) {
            [audioPlayer stop];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    //Stop all animations
    for (id subview in self.view.subviews) {
        if ([subview respondsToSelector:@selector(stopAnimating)]) {
            //This is an imageview
            [subview performSelector:@selector(stopAnimating) withObject:nil];
        }
    }
}

- (void)displayNarration {
    UIImage *buttonImage;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        buttonImage = [UIImage imageNamed:@"button_sound-on"];
    }
    else {
        buttonImage = [UIImage imageNamed:@"button_sound-off"];
    }
    [_narrationButton setImage:buttonImage forState:UIControlStateNormal];
}

- (void) toggleNarration
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"storyNarration"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"storyNarration"];
    }
    [self displayNarration];
}

- (void) setStoryViewController:(StoryViewController *)controller {
    _viewController = controller;
}

- (IBAction)homeButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*- (void) changeSceneStack:(UIButton*)button
{
    NSInteger buttonId = [button tag];
    [_viewController changeSceneStack:(NSString *) [self.dataObject.linkDestinations objectAtIndex:buttonId]];
}*/

- (void) changeSceneStack
{
    NSInteger r = arc4random()%2;
    [_viewController changeSceneStack:(NSString *) [self.dataObject.linkDestinations objectAtIndex:r]];
}

- (IBAction) changeSceneStack:(id) sender
{
    UIButton* button = (UIButton *) sender;
    NSInteger buttonId = [button tag];
    [_viewController changeSceneStack:(NSString *) [self.dataObject.linkDestinations objectAtIndex:buttonId]];
}

#pragma mark - Bookmark

/**
 *  Toggle bookmark visibility and size
 */
- (void)setupBookmark {
    [self.view bringSubviewToFront:bookmarkView];
    CGRect bookmarkFrame = bookmarkView.frame;
    NSString *bookmarkedId = [[NSUserDefaults standardUserDefaults] objectForKey:kStoryBookmarkDefaultsKey];
    if (self.dataObject.titlePage) {
        //Bookmark on title page: display full size if set otherwise hide
        
        bookmarkLabel.hidden = NO;
        bookmarkLabel.text = NSLocalizedString(@"Go to bookmark", @"Go to bookmark label text");
        if (bookmarkedId) {
            //Display in full size
            bookmarkView.hidden = NO;
            bookmarkFrame.size.height = kStoryBookmarkHeightSet;
            bookmarTapGestureRecognizer.enabled = YES;
        }
        else {
            //Hide bookmark since not set
            bookmarkView.hidden = YES;
            bookmarTapGestureRecognizer.enabled = NO;
        }
        
    }
    else {
        //Bookmark on story pages
        bookmarkView.hidden = NO;
        bookmarTapGestureRecognizer.enabled = YES;
        if (bookmarkedId && [bookmarkedId isEqualToString:self.dataObject.sceneID]) {
            //Display bookmark full size
            bookmarkFrame.size.height = kStoryBookmarkHeightSet;
            bookmarkLabel.hidden = NO;
            bookmarkLabel.text = NSLocalizedString(@"Remove bookmark", @"Clear bookmark label text");
        }
        else {
            bookmarkLabel.hidden = YES;
            bookmarkFrame.size.height = kStoryBookmarkHeightHidden;
        }
    }
    bookmarkView.frame = bookmarkFrame;
}

- (void)bookmarkTapped:(UITapGestureRecognizer*)recognizer {
    
    if (self.dataObject.titlePage) {
        //Tapped on cover page, go to bookmark
        NSString *bookmarkedId = [[NSUserDefaults standardUserDefaults] objectForKey:kStoryBookmarkDefaultsKey];
        if (bookmarkedId) {
            [_viewController gotoSceneWithId:bookmarkedId];
        }
    }
    else {
        //Tapped on a book page
        if (bookmarkView.frame.size.height == kStoryBookmarkHeightSet) {
            //Bookmark already set, clear it
            [self togleBookmarkSet:NO];
        }
        else {
            //Bookmark not set, set it
            [self togleBookmarkSet:YES];
        }
    }
    
}

/**
 *  Toggle bookmark with animation and set in userdefaults
 *
 *  @param bookmarkset YES to set bookmark, NO to clear
 */
- (void)togleBookmarkSet:(BOOL)bookmarkset {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (bookmarkset) {
        [defaults setObject:self.dataObject.sceneID forKey:kStoryBookmarkDefaultsKey];
    }
    else {
        [defaults removeObjectForKey:kStoryBookmarkDefaultsKey];
    }
    [defaults synchronize];
    
    //Set desired height
    CGRect bookmarkFrame = bookmarkView.frame;
    bookmarkFrame.size.height = bookmarkset ? kStoryBookmarkHeightSet : kStoryBookmarkHeightHidden;
    
    if (!bookmarkset) {
        bookmarkLabel.hidden = YES;
    }
    //Animate
    [UIView animateWithDuration:0.6 animations:^{
        bookmarkView.frame = bookmarkFrame;
    } completion:^(BOOL finished) {
        bookmarkLabel.hidden = !bookmarkset;
    }];
    
}

@end