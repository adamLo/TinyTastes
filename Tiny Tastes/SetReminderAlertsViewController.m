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
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self displayCurrentSettings];
}

- (void)displayCurrentSettings
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];

    NSDate *time = [self getNotificationFireDate:@"breakfast"];
    if(time != NULL) {
        [self.breakfastTime setText:[formatter stringFromDate:time]];
    } else {
        [self.breakfastSwitch setOn:NO animated:YES];
        [self.breakfastLabel setTextColor:[UIColor grayColor]];
        [self.breakfastTime setTextColor:[UIColor grayColor]];
        [self.breakfastEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"morning snack"];
    if(time != NULL) {
        [self.morningSnackTime setText:[formatter stringFromDate:time]];
    } else {
        [self.morningSnackSwitch setOn:NO animated:YES];
        [self.morningSnackLabel setTextColor:[UIColor grayColor]];
        [self.morningSnackTime setTextColor:[UIColor grayColor]];
        [self.morningSnackEdit setEnabled:NO];
    }

    time = [self getNotificationFireDate:@"lunch"];
    if(time != NULL) {
        [self.lunchTime setText:[formatter stringFromDate:time]];
    } else {
        [self.lunchSwitch setOn:NO animated:YES];
        [self.lunchLabel setTextColor:[UIColor grayColor]];
        [self.lunchTime setTextColor:[UIColor grayColor]];
        [self.lunchEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"afternoon snack"];
    if(time != NULL) {
        [self.afternoonSnackTime setText:[formatter stringFromDate:time]];
    } else {
        [self.afternoonSnackSwitch setOn:NO animated:YES];
        [self.afternoonSnackLabel setTextColor:[UIColor grayColor]];
        [self.afternoonSnackTime setTextColor:[UIColor grayColor]];
        [self.afternoonSnackEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"dinner"];
    if(time != NULL) {
        [self.dinnerTime setText:[formatter stringFromDate:time]];
    } else {
        [self.dinnerSwitch setOn:NO animated:YES];
        [self.dinnerLabel setTextColor:[UIColor grayColor]];
        [self.dinnerTime setTextColor:[UIColor grayColor]];
        [self.dinnerEdit setEnabled:NO];
    }
    
    time = [self getNotificationFireDate:@"evening snack"];
    if(time != NULL) {
        [self.eveningSnackTime setText:[formatter stringFromDate:time]];
    } else {
        [self.eveningSnackSwitch setOn:NO animated:YES];
        [self.eveningSnackLabel setTextColor:[UIColor grayColor]];
        [self.eveningSnackTime setTextColor:[UIColor grayColor]];
        [self.eveningSnackEdit setEnabled:NO];
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
    self.setRemindersHeadingLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
	self.breakfastLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.morningSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.lunchLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.afternoonSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.dinnerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.eveningSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.breakfastTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.morningSnackTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.lunchTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.afternoonSnackTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.dinnerTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.eveningSnackTime.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.breakfastEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.morningSnackEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.lunchEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.afternoonSnackEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.dinnerEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.eveningSnackEdit.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
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
    if (![self.breakfastSwitch isOn]) {
        [self cancelDailyNotification:@"breakfast"];
        [self.breakfastLabel setTextColor:[UIColor grayColor]];
        [self.breakfastTime setTextColor:[UIColor grayColor]];
        [self.breakfastEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"breakfast" setHour:8 setMinute:0];
        [self.breakfastLabel setTextColor:[UIColor blackColor]];
        [self.breakfastTime setTextColor:[UIColor blackColor]];
        [self.breakfastEdit setEnabled:YES];
    }
}

- (IBAction)toggleMorningSnackAlert:(id)sender
{
    if (![self.morningSnackSwitch isOn]) {
        [self cancelDailyNotification:@"morning snack"];
        [self.morningSnackLabel setTextColor:[UIColor grayColor]];
        [self.morningSnackTime setTextColor:[UIColor grayColor]];
        [self.morningSnackEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"morning snack" setHour:10 setMinute:0];
        [self.morningSnackLabel setTextColor:[UIColor blackColor]];
        [self.morningSnackTime setTextColor:[UIColor blackColor]];
        [self.morningSnackEdit setEnabled:YES];
    }
}

- (IBAction)toggleLunchAlert:(id)sender
{
    if (![self.lunchSwitch isOn]) {
        [self cancelDailyNotification:@"lunch"];
        [self.lunchLabel setTextColor:[UIColor grayColor]];
        [self.lunchTime setTextColor:[UIColor grayColor]];
        [self.lunchEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"lunch" setHour:12 setMinute:0];
        [self.lunchLabel setTextColor:[UIColor blackColor]];
        [self.lunchTime setTextColor:[UIColor blackColor]];
        [self.lunchEdit setEnabled:YES];
    }
}

- (IBAction)toggleAfternoonSnackAlert:(id)sender
{
    if (![self.afternoonSnackSwitch isOn]) {
        [self cancelDailyNotification:@"afternoon snack"];
        [self.afternoonSnackLabel setTextColor:[UIColor grayColor]];
        [self.afternoonSnackTime setTextColor:[UIColor grayColor]];
        [self.afternoonSnackEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"afternoon snack" setHour:14 setMinute:30];
        [self.afternoonSnackLabel setTextColor:[UIColor blackColor]];
        [self.afternoonSnackTime setTextColor:[UIColor blackColor]];
        [self.afternoonSnackEdit setEnabled:YES];
    }
}

- (IBAction)toggleDinnerAlert:(id)sender
{
    if (![self.dinnerSwitch isOn]) {
        [self cancelDailyNotification:@"dinner"];
        [self.dinnerLabel setTextColor:[UIColor grayColor]];
        [self.dinnerTime setTextColor:[UIColor grayColor]];
        [self.dinnerEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"dinner" setHour:7 setMinute:0];
        [self.dinnerLabel setTextColor:[UIColor blackColor]];
        [self.dinnerTime setTextColor:[UIColor blackColor]];
        [self.dinnerEdit setEnabled:YES];
    }
}

- (IBAction)toggleEveningSnackAlert:(id)sender
{
    if (![self.eveningSnackSwitch isOn]) {
        [self cancelDailyNotification:@"evening snack"];
        [self.eveningSnackLabel setTextColor:[UIColor grayColor]];
        [self.eveningSnackTime setTextColor:[UIColor grayColor]];
        [self.eveningSnackEdit setEnabled:NO];
    } else {
        [self scheduleDailyNotification:@"evening snack" setHour:19 setMinute:30];
        [self.eveningSnackLabel setTextColor:[UIColor blackColor]];
        [self.eveningSnackTime setTextColor:[UIColor blackColor]];
        [self.eveningSnackEdit setEnabled:YES];
    }
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
