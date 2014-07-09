//
//  StoryPageController.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.05..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "StoryPageController.h"
#import <AVFoundation/AVFoundation.h>

@interface StoryPageController () {
    
    NSTimer *pageDelayTimer; //Delay timer to defer narration and animation
    NSMutableArray *audioPlayers; //Array of audio players for sound files on page
    
    UITapGestureRecognizer *tapGestureRecognizer; //Tap gesture recognizer for the page
    
}

@end

@implementation StoryPageController

NSTimeInterval const kStoryDelayAfterAppear = 0.33; //Postpone animation after page appeared

@synthesize pageData;
@synthesize accessories;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Initialize audio players
    audioPlayers = [[NSMutableArray alloc] init];
    
    //Initializer tap gesture recognizer to detect link taps on page
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageTappedWithRecognizer:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    //Reset animations to first phase
    for (id subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView*)subView;
            if (imageView.animationImages.count) {
                if (imageView.animationRepeatCount > 0) {
                    //Set default image of animation sequence to last frame if animation not continous
                    imageView.image = [imageView.animationImages firstObject];
                }
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    //Schedule narration and animation start
    pageDelayTimer = [NSTimer scheduledTimerWithTimeInterval:kStoryDelayAfterAppear target:self selector:@selector(pageDelayTimerFired:) userInfo:nil repeats:NO];
    
    //Enable tapping
    tapGestureRecognizer.enabled = YES;
    
}

/**
 *  A timer is defined to delay narration and animation after page appeared
 *
 *  @param timer Timer
 */
- (void)pageDelayTimerFired:(NSTimer*)timer {
    
    //Start playing narration
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        for (AVAudioPlayer *audioPlayer in audioPlayers) {
            [audioPlayer setCurrentTime:0.0];
            [audioPlayer play];
        }
    }
    
    //Start animations
    for (id subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView*)subView;
            if (imageView.animationImages.count) {
                if (imageView.animationRepeatCount > 0) {
                    //Set default image of animation sequence to last frame if animation not continous
                    imageView.image = [imageView.animationImages lastObject];
                }
                [imageView startAnimating];
            }
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //Cancel timer if not yet fired
    [pageDelayTimer invalidate];
    pageDelayTimer = nil;
    
    //Stop sounds
    for (AVAudioPlayer *audioPlayer in audioPlayers) {
        [audioPlayer stop];
    }
    
    //Disable taps
    tapGestureRecognizer.enabled = NO;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadStoryPage:(NSDictionary *)storyPage accessories:(NSArray *)pageAccessories {

    //Assign data
    pageData = storyPage;
    
    //Assign accessories
    accessories = pageAccessories;
    
    //Build page
    [self buildPageImages];
    
    //Load sounds
    [self buildSoundPlayers];

}

#pragma mark - Images

/**
 *  Construct an imageview from dictionary. Add animation if there's any
 *
 *  @param imageDict Dictionary describing image
 *  @param sequence Sequence order in processing. Will be added as tag if tag property not set
 *
 *  @return Imageview
 */
- (UIImageView*)imageViewFromDictionary:(NSDictionary*)imageDict sequence:(NSInteger)sequence {

    //Construct imageview
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([[imageDict objectForKey:kStoryDictionaryKeyX] floatValue], [[imageDict objectForKey:kStoryDictionaryKeyY]floatValue], [[imageDict objectForKey:kStoryDictionaryKeyW] floatValue], [[imageDict objectForKey:kStoryDictionaryKeyH] floatValue])];
    
    //Add image if exists
    if ([imageDict objectForKey:kStoryDictionaryKeyPath]) {
        imageView.image = [UIImage imageNamed:[imageDict objectForKey:kStoryDictionaryKeyPath]];
    }
    
    //Set tag, this will help layering
    imageView.tag = ([imageDict objectForKey:kStoryDictionaryKeyTag] != nil) ? [[imageDict objectForKey:kStoryDictionaryKeyTag] integerValue] : sequence;
    
    //Add animations if there are
    if ([[imageDict objectForKey:kStoryDictionaryKeyAnimation] isKindOfClass:[NSArray class]]) {
        //We have animation images
        
        //Add animation phase images
        NSMutableArray *animationImages = [[NSMutableArray alloc] init];
        for (NSString *imgName in [imageDict objectForKey:kStoryDictionaryKeyAnimation]) {
            UIImage *image = [UIImage imageNamed:imgName];
            if (image) {
                [animationImages addObject:image];
            }
        }
        imageView.animationImages = [NSArray arrayWithArray:animationImages];
        
        //Set animation properties
        imageView.animationDuration = [[imageDict objectForKey:kStoryDictionaryKeyDuration] floatValue];
        imageView.animationRepeatCount = [[imageDict objectForKey:kStoryDictionaryKeyRepeat] integerValue];
        
        //set first image if not set
        if (!imageView.image) {
            imageView.image = [imageView.animationImages firstObject];
        }
    }
    
    return imageView;
    
}

/**
 *  Constructs page views
 */
- (void)buildPageImages {
    
    //Add images
    if ([[self.pageData objectForKey:kStoryDictionaryKeyImage] isKindOfClass:[NSDictionary class]]) {
        //Single image
        [self.view addSubview:[self imageViewFromDictionary:[self.pageData objectForKey:kStoryDictionaryKeyImage] sequence:0]];
    }
    else if ([[self.pageData objectForKey:kStoryDictionaryKeyImage] isKindOfClass:[NSArray class]]) {
        //Multiple images
        
        //Add imageview
        NSInteger sequence = 0;
        for (NSDictionary *imageDict in [self.pageData objectForKey:kStoryDictionaryKeyImage]) {
            [self.view addSubview:[self imageViewFromDictionary:imageDict sequence:sequence]];
            sequence++;
        }
    }
    
}

#pragma mark - Sounds

/**
 *  Construct an Audio player from the dictionary
 *
 *  @param audioDict Dictionary describing sound
 *
 *  @return Audio player
 */
- (AVAudioPlayer*)audioPlayerFromDictionary:(NSDictionary*)audioDict {
    
    //Get file
    NSString *path = [[NSBundle mainBundle] pathForResource:[audioDict objectForKey:kStoryDictionaryKeyPath] ofType:[audioDict objectForKey:kStoryDictionaryKeyType]];
    
    if (path) {
        //Load sound data
        NSData *soundData = [NSData dataWithContentsOfFile:path];
        
        if (soundData) {
            //Construct player
            NSError *error = nil;
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:soundData error:&error];
            
            if (!error) {
                return player;
            }
            else {
                NSLog(@"Failed to constructg audio player for sound dict %@ error: %@", audioDict, error);
            }
        }
    }
    
    return nil;
}

/**
 *  Build up sound players for page
 */
- (void)buildSoundPlayers {
    
    if ([[self.pageData objectForKey:kStoryDictionaryKeySound] isKindOfClass:[NSDictionary class]]) {
        AVAudioPlayer *player = [self audioPlayerFromDictionary:[self.pageData objectForKey:kStoryDictionaryKeySound]];
        if (player) {
            [audioPlayers addObject:player];
        }
    }
    else if ([[self.pageData objectForKey:kStoryDictionaryKeySound] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *audioDict in [self.pageData objectForKey:kStoryDictionaryKeySound]) {
            AVAudioPlayer *player = [self audioPlayerFromDictionary:audioDict];
            if (player) {
                [audioPlayers addObject:player];
            }
        }
    }
    
}

- (void)toggleNarrationOn:(BOOL)narrationOn {
    
    for (AVAudioPlayer *player in audioPlayers) {
        if (narrationOn) {
            [player play];
        }
        else {
            [player stop];
        }
    }
    
}

#pragma mark - Tap gesture

/**
 *  Constructs a CGRect frame from a dictionary data for comparision
 *
 *  @param linkDict Dictionary describing area
 *
 *  @return Frame
 */
- (CGRect)frameFromLinkDictionary:(NSDictionary*)linkDict {
    return CGRectMake([[linkDict objectForKey:kStoryDictionaryKeyX] floatValue], [[linkDict objectForKey:kStoryDictionaryKeyY] floatValue], [[linkDict objectForKey:kStoryDictionaryKeyW] floatValue], [[linkDict objectForKey:kStoryDictionaryKeyH] floatValue]);
}

/**
 *  Handle tapping a hot area
 *
 *  @param linkData Data describes what to to
 */
- (void)handleTapWithData:(NSDictionary*)linkData {
    
    if ([linkData objectForKey:kStoryDictionaryKeyID]) {
        //Go to scene
        [self.pageViewController gotoSceneWithID:[linkData objectForKey:kStoryDictionaryKeyID]];
    }
    else if ([linkData objectForKey:kStoryDictionaryKeySegue]) {
        //There's a segue to push
        [self.pageViewController performSegueWithIdentifier:[linkData objectForKey:kStoryDictionaryKeySegue] sender:self.pageViewController];
    }
}

/**
 *  Tap gesture recognizer delegate handle method. Will check if there's a hot area defined in the story in section "links"
 *
 *  @param recognizer Tap gesture recognizer
 */
- (void)pageTappedWithRecognizer:(UITapGestureRecognizer*)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint touchPoint = [recognizer locationInView:self.view];

        if ([[self.pageData objectForKey:kStoryDictionaryKeyLink] isKindOfClass:[NSDictionary class]]) {
            //We have one link
            
            NSDictionary *linkData = [self.pageData objectForKey:kStoryDictionaryKeyLink];
            //Get link frame
            CGRect linkFrame = [self frameFromLinkDictionary:linkData];
            
            //Check touch
            if (CGRectContainsPoint(linkFrame, touchPoint)) {
                //Touchdown
                [self handleTapWithData:linkData];
            }
        }
        else if ([[self.pageData objectForKey:kStoryDictionaryKeyLink] isKindOfClass:[NSArray class]]) {
            //Multiple links on page
            
            for (NSDictionary *linkData in [self.pageData objectForKey:kStoryDictionaryKeyLink]) {
                //Get link frame
                CGRect linkFrame = [self frameFromLinkDictionary:linkData];
                
                //Check touch
                if (CGRectContainsPoint(linkFrame, touchPoint)) {
                    //Touchdown
                    [self handleTapWithData:linkData];
                    break;
                }
            }
        }
    }
}


@end
