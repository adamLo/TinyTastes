//
//  StoryPageViewController.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.05..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "StoryPageViewController.h"
#import "XMLDictionary.h"
#import "StoryPageController.h"

@interface StoryPageViewController () {
    NSDictionary *storyBook; //Actual story book
    NSDictionary *currentPage; //Actual page index in the story book
    
    NSMutableDictionary *pageControllerCache; //Cache containing UIViewControllers for already created pages
    
    UIButton *homeButton; //Button to go back to home screen
    UIButton *skipButton; //Button to skip story and go to eating screen
    UIButton *narrationButton; //Button to toggle narration on and off
    
    UIImage *bookmarkImage; //Resizable bookmark image
    UIImageView *bookmarkView; //Bookmark view
    UILabel *bookmarkLabel; //Localized instruction label on bookmark. Displayed on title only when bookmark is set
    UITapGestureRecognizer *bookmarTapGestureRecognizer; //Recognizer for user tap action
}

@end

@implementation StoryPageViewController

//XML dictionary keys
NSString* const kStoryDictionaryKeyScene = @"scene";
NSString* const kStoryDictionaryKeyImage = @"image";
NSString* const kStoryDictionaryKeyX = @"x";
NSString* const kStoryDictionaryKeyY = @"y";
NSString* const kStoryDictionaryKeyW = @"w";
NSString* const kStoryDictionaryKeyH = @"h";
NSString* const kStoryDictionaryKeyPath = @"path";
NSString* const kStoryDictionaryKeyID = @"id";
NSString* const kStoryDictionaryKeyNext = @"next";
NSString* const kStoryDictionaryKeyLink = @"link";
NSString* const kStoryDictionaryKeySound = @"sound";
NSString* const kStoryDictionaryKeyType = @"type";
NSString* const kStoryDictionaryKeyAnimation = @"animation";
NSString* const kStoryDictionaryKeyDuration = @"duration";
NSString* const kStoryDictionaryKeyRepeat = @"repeat";
NSString* const kStoryDictionaryKeySegue = @"segue";
NSString* const kStoryDictionaryKeyTitle = @"title";
NSString* const kStoryDictionaryKeyPrev = @"prev";
NSString* const kStoryDictionaryKeyHideSkip = @"hideskip";
NSString* const kStoryDictionaryKeyTag = @"tag";

//Class-level constants
CGFloat const kStoryBookmarkHeightHidden = 30; //Bookmark height when not displayed
CGFloat const kStoryBookmarkHeightSet = 107; //Bookmark height when set
NSString* const kStoryBookmarkDefaultsKey = @"BookmarkedStorySceneId"; //Key in NSUSerdefaults for bookmark

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
    
    //Set Datasource and delegate for pageviewcontroller
    self.dataSource = self;
    self.delegate = self;
    
    //Set background
    self.view.backgroundColor = [UIColor colorWithRed:89/255.0 green:88/255.0 blue:89/255.0 alpha:1.0];
    
    //Init cache
    pageControllerCache = [[NSMutableDictionary alloc] init];
    
    //Add home button
    homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(12, 16, 135, 95);
    [homeButton setImage:[UIImage imageNamed:@"button_home"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeButton];
    
    //Add skip button
    skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.frame = CGRectMake(838, 16, 152, 107);
    [skipButton setImage:[UIImage imageNamed:@"button_skip-to-eat"] forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipButton];
    
    //Add narration button
    narrationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    narrationButton.frame = CGRectMake(838, 565, 104, 98);
    [narrationButton addTarget:self action:@selector(narrationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:narrationButton];
    
    //Create bookmark
    [self createBookmark];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Load bundled storybook
    [self loadStoryBookWithFilename:@"story.xml"];
    
    //Bring buttons to front
    [self.view bringSubviewToFront:homeButton];
    [self.view bringSubviewToFront:skipButton];
    [self.view bringSubviewToFront:narrationButton];
    [self.view bringSubviewToFront:bookmarkView];
    
    //Toggle narration button
    [self toggleNarrationButton];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    //Free storybook and controls
    storyBook = nil;
    
    [pageControllerCache removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [pageControllerCache removeAllObjects];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadStoryBookWithFilename:(NSString*)xmlFile {
    
    //Load and parse story book
    NSString *path = [[NSBundle mainBundle] pathForResource:xmlFile ofType:nil];
    [XMLDictionaryParser sharedInstance].attributesMode = XMLDictionaryAttributesModeUnprefixed;
    storyBook = [NSDictionary dictionaryWithXMLFile:path];
    
    //get starting page
    currentPage = [[storyBook objectForKey:kStoryDictionaryKeyScene] firstObject];
    
    //Clear cache
    [pageControllerCache removeAllObjects];
    
    //Load first page
    __weak UIButton *_narrationButton = narrationButton;
    [self setViewControllers:@[[self controllerForSceneID:[currentPage objectForKey:kStoryDictionaryKeyID]]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
        //Show narration button
        _narrationButton.hidden = NO;
        
        //Set up bookmark
    }];
    
    [self setupBookmark];
}

#pragma mark Page caching

/**
 *  Get page controller from cache or create if does not exist
 *
 *  @param sceneID Id of page scene
 *
 *  @return Page controller
 */
- (StoryPageController*)controllerForSceneID:(NSString*)sceneID {
    
    //Find in cache
    StoryPageController* controller = [pageControllerCache objectForKey:sceneID];
    
    if (!controller) {
        //Find page description in the story
        for (NSDictionary *pageData in [storyBook objectForKey:kStoryDictionaryKeyScene]) {
            if ([[pageData objectForKey:kStoryDictionaryKeyID] isEqualToString:sceneID]) {
                //Found scene
                
                //Create controller for page
                controller = [[StoryPageController alloc] init];
                controller.view.frame = self.view.frame;
                controller.pageViewController = self;
                [controller loadStoryPage:pageData];
                
                //Add to cache
                [pageControllerCache setObject:controller forKey:sceneID];
                
                return controller;
            }
        }
    }
    
    return controller;
}

- (void)gotoSceneWithID:(NSString *)sceneId {
    StoryPageController *controller = [self controllerForSceneID:sceneId];
    if (controller) {
        
        //Create weak pointers to the objects so they won't cause retain cycle
        __block __weak id _self = self;
        __block __weak UIButton *_narrationButton = narrationButton;
        __block __weak UIButton *_skipButton = skipButton;
        //Load page
        [self setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
            if (finished) {
                //Setup bookmark
                [_self setupBookmark];
                
                //Toggle narration button
                [_narrationButton setHidden:![[controller.pageData objectForKey:kStoryDictionaryKeyTitle] boolValue]];
                
                //Toggle skip button
                [_skipButton setHidden:[[controller.pageData objectForKey:kStoryDictionaryKeyHideSkip] boolValue]];
            }
            
        }];
    }
}

#pragma mark UIPageViewController dataSource

/**
 *  Get Controller of actual page
 *
 *  @return Current page controller
 */
- (StoryPageController*)currentPageController {
    return [self.viewControllers lastObject];
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    //Get current scene id
    NSDictionary *pageData = [(StoryPageController*)viewController pageData];
    NSString *currentSceneId = [pageData objectForKey:kStoryDictionaryKeyID];
    
    //Find previous scene id
    NSString *prevSceneId = [[pageData objectForKey:kStoryDictionaryKeyPrev] objectForKey:kStoryDictionaryKeyID];
    //We don't have an explicit previous scene id
    if (!prevSceneId) {
        for (NSDictionary *pageData in [storyBook objectForKey:kStoryDictionaryKeyScene]) {
            NSDictionary *next = [pageData objectForKey:kStoryDictionaryKeyNext];
            if ([[next objectForKey:kStoryDictionaryKeyID] isEqualToString:currentSceneId]) {
                //We got previous page
                prevSceneId = [pageData objectForKey:kStoryDictionaryKeyID];
                break;
            }
            
            if ([[pageData objectForKey:kStoryDictionaryKeyLink] isKindOfClass:[NSDictionary class]]) {
                //One link only
                if ([[[pageData objectForKey:kStoryDictionaryKeyLink] objectForKey:kStoryDictionaryKeyID] isEqualToString:currentSceneId]) {
                    //Got the link
                    prevSceneId = [pageData objectForKey:kStoryDictionaryKeyID];
                    break;
                }
            }
            else if ([[pageData objectForKey:kStoryDictionaryKeyLink] isKindOfClass:[NSArray class]]) {
                //Search over links
                for (NSDictionary *linkDict in [pageData objectForKey:kStoryDictionaryKeyLink]) {
                    if ([[linkDict objectForKey:kStoryDictionaryKeyID] isEqualToString:currentSceneId]) {
                        //Got the link
                        prevSceneId = [pageData objectForKey:kStoryDictionaryKeyID];
                        break;
                    }
                }
            }
        }
    }
    
    //Get controller from cache
    StoryPageController *prevController;
    if (prevSceneId) {
        prevController = [self controllerForSceneID:prevSceneId];
    }
    
    
    return prevController;
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSDictionary *pageData = [(StoryPageController*)viewController pageData];
    NSDictionary *next = [pageData objectForKey:kStoryDictionaryKeyNext];
    
    if (next) {
        
        if ([next objectForKey:kStoryDictionaryKeyID]) {
            //We have a next scene
            StoryPageController *nextController;
            nextController = [self controllerForSceneID:[next objectForKey:kStoryDictionaryKeyID]];
            
            return nextController;
        }
        else if ([next objectForKey:kStoryDictionaryKeySegue]) {
            //There's a segue to push
            [self performSegueWithIdentifier:[next objectForKey:kStoryDictionaryKeySegue] sender:self];
        }
    }
    
    return nil;
    
}

#pragma mark  PageViewController delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    StoryPageController *controller = [self currentPageController];
    if (finished) {
        if ([[controller.pageData objectForKey:kStoryDictionaryKeyTitle] boolValue]) {
            //Show narration button when turning animation to cover page finished
            narrationButton.hidden = NO;
        }
        else {
            //Hide otherwise
            narrationButton.hidden = YES;
        }
        
        //Set bookmark
        [self setupBookmark];
        
        //Toggle skip button
        [skipButton setHidden:[[controller.pageData objectForKey:kStoryDictionaryKeyHideSkip] boolValue]];
    }
    else {
        if (![[controller.pageData objectForKey:kStoryDictionaryKeyTitle] boolValue]) {
            //Hide otherwise
            narrationButton.hidden = YES;
        }
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
    StoryPageController *controller = [pendingViewControllers lastObject];
    if (![[controller.pageData objectForKey:kStoryDictionaryKeyTitle] boolValue]) {
        //Hide narration button when moving away from title page
        narrationButton.hidden = YES;
    }
    
    bookmarkView.hidden = YES;
}

#pragma mark - Button actions

/**
 *  User pressed home button to go back to home screen
 *
 *  @param sender Button
 */
- (void)homeButtonPressed:(id)sender {
    //Go home
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  User pressed skip button to go to eating screen
 *
 *  @param sender Button
 */
- (void)skipButtonPressed:(id)sender {
    //Go to photo screen (eating)
    [self performSegueWithIdentifier:@"toPhotoView" sender:sender];
    
}

/**
 *  User pressed narration button to toggle narration
 *
 *  @param sender Button
 */
- (void)narrationButtonPressed:(id)sender {
    
    //Toggle setting
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL state = ![defaults boolForKey:@"storyNarration"];
    [defaults setBool:state forKey:@"storyNarration"];
    [defaults synchronize];
    
    //Toggle button image
    [self toggleNarrationButton];
    
    //Tell actual controller to stop narration
    StoryPageController *controller = [self currentPageController];
    [controller toggleNarrationOn:state];
}

/**
 *  Toggle narration button on/off image
 */
- (void)toggleNarrationButton {
    [narrationButton setImage:[UIImage imageNamed:([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] ? @"button_sound-on" : @"button_sound-off")] forState:UIControlStateNormal];
}

#pragma mark - Bookmark

/**
 *  Create bookmark
 */
- (void)createBookmark {
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

/**
 *  Toggle bookmark visibility and size
 */
- (void)setupBookmark {
    
    bookmarkView.hidden = NO;

    CGRect bookmarkFrame = bookmarkView.frame;
    NSString *bookmarkedId = [[NSUserDefaults standardUserDefaults] objectForKey:kStoryBookmarkDefaultsKey];
    if ([[[[self currentPageController] pageData] objectForKey:kStoryDictionaryKeyTitle] boolValue]) {
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
        if (bookmarkedId && [bookmarkedId isEqualToString:[[[self currentPageController] pageData] objectForKey:kStoryDictionaryKeyID]]) {
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

/**
 *  User tapped on bookmark. Three different things could happen: go to bookmark if displaying title page, or set bookmark on story if not set on this page or remove bookmark if already set
 */
- (void)bookmarkTapped:(UITapGestureRecognizer*)recognizer {
    
    if ([[[[self currentPageController] pageData] objectForKey:kStoryDictionaryKeyTitle] boolValue]) {
        //Tapped on cover page, go to bookmark
        NSString *bookmarkedId = [[NSUserDefaults standardUserDefaults] objectForKey:kStoryBookmarkDefaultsKey];
        if (bookmarkedId) {
            [self gotoSceneWithID:bookmarkedId];
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
        [defaults setObject:[[[self currentPageController] pageData] objectForKey:kStoryDictionaryKeyID] forKey:kStoryBookmarkDefaultsKey];
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
        if (bookmarkset) {
            //Set label title if bookmark is set
            bookmarkLabel.text = NSLocalizedString(@"Remove bookmark", @"Clear bookmark label text");
        }
    }];
    
}

@end
