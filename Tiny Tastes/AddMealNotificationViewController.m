//
//  AddToDoViewController.m
//  LocalNotificationDemo
//
//  Created by Simon on 9/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "AddMealNotificationViewController.h"
#import "SetReminderAlertsViewController.h"
#import "UIFont+TinyTastes.h"

@interface AddMealNotificationViewController ()

@end

@implementation AddMealNotificationViewController

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
    UIColor *backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    self.view.backgroundColor = backgroundColor;
	[self setFonts];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mealLabel setText:[NSString stringWithFormat:@"Meal:   %@", _currentMeal]];
    _datePicker.date = _currentNotificationTime;
}

- (void)setFonts
{
    self.editReminderLabel.font = [UIFont ttFont60];
    self.remindMeAtLabel.font = [UIFont ttFont50];
    self.mealLabel.font = [UIFont ttFont55];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    // Get the current date
    NSDate *pickerDate = [self.datePicker date];
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit | NSMinuteCalendarUnit)
                                                  fromDate: pickerDate];
    
    // Cancel the current notification for that meal
    BOOL canceled = [self cancelDailyNotification:_currentMeal];
    if (canceled) {
        [self scheduleDailyNotification:_currentMeal setHour:[dateComps hour] setMinute:[dateComps minute]];
    }
    
    //Go back
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scheduleDailyNotification:(NSString *)mealName setHour:(NSInteger)hour setMinute:(NSInteger)minute
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

- (BOOL)cancelDailyNotification:(NSString *)mealName
{
    UILocalNotification *notificationToCancel = nil;
    for(UILocalNotification *aNotif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([aNotif.userInfo valueForKey:_currentMeal] != nil) {
            notificationToCancel = aNotif;
            [[UIApplication sharedApplication] cancelLocalNotification:notificationToCancel];
            return TRUE;
        }
    }
    return FALSE;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return NO;
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
