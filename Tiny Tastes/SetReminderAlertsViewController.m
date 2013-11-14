//
//  SetReminderAlertsViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 11/2/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "SetReminderAlertsViewController.h"
#import "AddMealNotificationViewController.h"

@interface SetReminderAlertsViewController ()

@end

@implementation SetReminderAlertsViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    [self setFonts];
    
    [self displayCurrentSettings];
}

- (void)displayCurrentSettings
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];

    NSDate *time = [self getNotificationFireDate:@"breakfast"];
    if(time != NULL) {
        [breakfastTime setText:[formatter stringFromDate:time]];
    } else {
        [breakfastSwitch setOn:NO animated:YES];
        [breakfastLabel setTextColor:[UIColor grayColor]];
        [breakfastTime setTextColor:[UIColor grayColor]];
        [breakfastEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"morning snack"];
    if(time != NULL) {
        [morningSnackTime setText:[formatter stringFromDate:time]];
    } else {
        [morningSnackSwitch setOn:NO animated:YES];
        [morningSnackLabel setTextColor:[UIColor grayColor]];
        [morningSnackTime setTextColor:[UIColor grayColor]];
        [morningSnackEdit setEnabled:NO];
    }

    time = [self getNotificationFireDate:@"lunch"];
    if(time != NULL) {
        [lunchTime setText:[formatter stringFromDate:time]];
    } else {
        [lunchSwitch setOn:NO animated:YES];
        [lunchLabel setTextColor:[UIColor grayColor]];
        [lunchTime setTextColor:[UIColor grayColor]];
        [lunchEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"afternoon snack"];
    if(time != NULL) {
        [afternoonSnackTime setText:[formatter stringFromDate:time]];
    } else {
        [afternoonSnackSwitch setOn:NO animated:YES];
        [afternoonSnackLabel setTextColor:[UIColor grayColor]];
        [afternoonSnackTime setTextColor:[UIColor grayColor]];
        [afternoonSnackEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"dinner"];
    if(time != NULL) {
        [dinnerTime setText:[formatter stringFromDate:time]];
    } else {
        [dinnerSwitch setOn:NO animated:YES];
        [dinnerLabel setTextColor:[UIColor grayColor]];
        [dinnerTime setTextColor:[UIColor grayColor]];
        [dinnerEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"evening snack"];
    if(time != NULL) {
        [eveningSnackTime setText:[formatter stringFromDate:time]];
    } else {
        [eveningSnackSwitch setOn:NO animated:YES];
        [eveningSnackLabel setTextColor:[UIColor grayColor]];
        [eveningSnackTime setTextColor:[UIColor grayColor]];
        [eveningSnackEdit setEnabled:NO];
    }
}

- (NSDate *)getNotificationFireDate:(NSString *)mealName
{
    for(UILocalNotification *aNotif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([aNotif.userInfo objectForKey:mealName]) {
            return aNotif.fireDate;
        }
    }
    return NULL;
}

- (void)scheduleDefaultNotifications
{
    [self scheduleDailyNotification:@"breakfast" setHour:8 setMinute:0];
    [self scheduleDailyNotification:@"morning snack" setHour:10 setMinute:0];
    [self scheduleDailyNotification:@"lunch" setHour:12 setMinute:0];
    [self scheduleDailyNotification:@"afternoon snack" setHour:14 setMinute:30];
    [self scheduleDailyNotification:@"dinner" setHour:17 setMinute:0];
    [self scheduleDailyNotification:@"evening snack" setHour:19 setMinute:30];
}

- (void)setFonts
{
    setRemindersHeadingLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    backLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
	breakfastLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    morningSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    lunchLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    afternoonSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    dinnerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    eveningSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    breakfastTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    morningSnackTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    lunchTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    afternoonSnackTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    dinnerTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    eveningSnackTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    breakfastEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    morningSnackEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    lunchEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    afternoonSnackEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    dinnerEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    eveningSnackEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
}

- (void)scheduleDailyNotification:(NSString *)mealName setHour:(int)hour setMinute:(int)minute
{
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar] ;
    NSDateComponents *componentsForReferenceDate = [calendar components:(NSDayCalendarUnit
                                                                         | NSYearCalendarUnit
                                                                         | NSMonthCalendarUnit )fromDate:[NSDate date]];
    
    [componentsForReferenceDate setDay:1] ;
    [componentsForReferenceDate setMonth:1] ;
    [componentsForReferenceDate setYear:2013] ;
    
    NSDate *referenceDate = [calendar dateFromComponents:componentsForReferenceDate] ;
    
    // set components for specified time
    NSDateComponents *componentsForFireDate = [calendar components:(NSYearCalendarUnit | NSHourCalendarUnit
                                                                    | NSMinuteCalendarUnit| NSSecondCalendarUnit )
                                                                    fromDate: referenceDate];
    
    [componentsForFireDate setHour:hour] ;
    [componentsForFireDate setMinute:minute] ;
    [componentsForFireDate setSecond:0] ;
    
    NSDate *fireDateOfNotification = [calendar dateFromComponents: componentsForFireDate];
    
    // Create the notification
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;
    notification.fireDate = fireDateOfNotification ;
    notification.timeZone = [NSTimeZone localTimeZone] ;
    notification.alertBody = [NSString stringWithFormat: @"It's time for your %@!", mealName] ;
    notification.alertAction = @"Show me the item";
    notification.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Some information"]
                                                               forKey:mealName];
    notification.repeatInterval = NSDayCalendarUnit ;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)cancelDailyNotification:(NSString *)mealName
{
    UILocalNotification *notificationToCancel = nil;
    for(UILocalNotification *aNotif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([aNotif.userInfo objectForKey:mealName]) {
            notificationToCancel = aNotif;
            [[UIApplication sharedApplication] cancelLocalNotification:notificationToCancel];
            break;
        }
    }
}

- (IBAction)toggleBreakfastAlert:(id)sender
{
    if (![breakfastSwitch isOn]) {
        [self cancelDailyNotification:@"breakfast"];
        [breakfastLabel setTextColor:[UIColor grayColor]];
        [breakfastTime setTextColor:[UIColor grayColor]];
        [breakfastEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"breakfast" setHour:8 setMinute:0];
        [breakfastLabel setTextColor:[UIColor blackColor]];
        [breakfastTime setTextColor:[UIColor blackColor]];
        [breakfastEdit setEnabled:YES];
    }
}

- (IBAction)toggleMorningSnackAlert:(id)sender
{
    if (![morningSnackSwitch isOn]) {
        [self cancelDailyNotification:@"morning snack"];
        [morningSnackLabel setTextColor:[UIColor grayColor]];
        [morningSnackTime setTextColor:[UIColor grayColor]];
        [morningSnackEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"morning snack" setHour:10 setMinute:0];
        [morningSnackLabel setTextColor:[UIColor blackColor]];
        [morningSnackTime setTextColor:[UIColor blackColor]];
        [morningSnackEdit setEnabled:YES];
    }
}

- (IBAction)toggleLunchAlert:(id)sender
{
    if (![lunchSwitch isOn]) {
        [self cancelDailyNotification:@"lunch"];
        [lunchLabel setTextColor:[UIColor grayColor]];
        [lunchTime setTextColor:[UIColor grayColor]];
        [lunchEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"lunch" setHour:12 setMinute:0];
        [lunchLabel setTextColor:[UIColor blackColor]];
        [lunchTime setTextColor:[UIColor blackColor]];
        [lunchEdit setEnabled:YES];
    }
}

- (IBAction)toggleAfternoonSnackAlert:(id)sender
{
    if (![afternoonSnackSwitch isOn]) {
        [self cancelDailyNotification:@"afternoon snack"];
        [afternoonSnackLabel setTextColor:[UIColor grayColor]];
        [afternoonSnackTime setTextColor:[UIColor grayColor]];
        [afternoonSnackEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"afternoon snack" setHour:14 setMinute:30];
        [afternoonSnackLabel setTextColor:[UIColor blackColor]];
        [afternoonSnackTime setTextColor:[UIColor blackColor]];
        [afternoonSnackEdit setEnabled:YES];
    }
}

- (IBAction)toggleDinnerAlert:(id)sender
{
    if (![dinnerSwitch isOn]) {
        [self cancelDailyNotification:@"dinner"];
        [dinnerLabel setTextColor:[UIColor grayColor]];
        [dinnerTime setTextColor:[UIColor grayColor]];
        [dinnerEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"dinner" setHour:7 setMinute:0];
        [dinnerLabel setTextColor:[UIColor blackColor]];
        [dinnerTime setTextColor:[UIColor blackColor]];
        [dinnerEdit setEnabled:YES];
    }
}

- (IBAction)toggleEveningSnackAlert:(id)sender
{
    if (![eveningSnackSwitch isOn]) {
        [self cancelDailyNotification:@"evening snack"];
        [eveningSnackLabel setTextColor:[UIColor grayColor]];
        [eveningSnackTime setTextColor:[UIColor grayColor]];
        [eveningSnackEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"evening snack" setHour:19 setMinute:30];
        [eveningSnackLabel setTextColor:[UIColor blackColor]];
        [eveningSnackTime setTextColor:[UIColor blackColor]];
        [eveningSnackEdit setEnabled:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AddMealNotificationViewController *controller = (AddMealNotificationViewController *)segue.destinationViewController;
    if([segue.identifier isEqualToString:@"breakfastSegue"]){
        controller.currentMeal = @"breakfast";
        controller.currentNotificationTime = [self getNotificationFireDate:@"breakfast"];
    }
    if([segue.identifier isEqualToString:@"morningSnackSegue"]){
        controller.currentMeal = @"morning snack";
        controller.currentNotificationTime = [self getNotificationFireDate:@"morning snack"];
    }
    if([segue.identifier isEqualToString:@"lunchSegue"]){
        controller.currentMeal = @"lunch";
        controller.currentNotificationTime = [self getNotificationFireDate:@"lunch"];
    }
    if([segue.identifier isEqualToString:@"afternoonSnackSegue"]){
        controller.currentMeal = @"afternoon snack";
        controller.currentNotificationTime = [self getNotificationFireDate:@"afternoon snack"];
    }
    if([segue.identifier isEqualToString:@"dinnerSegue"]){
        controller.currentMeal = @"dinner";
        controller.currentNotificationTime = [self getNotificationFireDate:@"dinner"];
    }
    if([segue.identifier isEqualToString:@"eveningSnackSegue"]){
        controller.currentMeal = @"evening snack";
        controller.currentNotificationTime = [self getNotificationFireDate:@"evening snack"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
