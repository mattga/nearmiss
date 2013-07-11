//
//  ReminderViewController.m
//  IncidentReport
//
//  Created by App Jam on 11/13/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import "ReminderViewController.h"
#import "GlobalVars.h"
#import "IncidentQueueController.h"
#import "Incident.h"
#import "NSBoolean.h"

@interface ReminderViewController ()

@end

@implementation ReminderViewController
@synthesize reminderPicker, reminderOptions;
@synthesize descriptionField, reminderPeriod;

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
    self.reminderOptions = [[NSArray alloc] initWithObjects:
                            @"5 Seconds (Demo)", @"15 Seconds (Demo)", @"2 Hours", @"4 Hours",
                            @"8 Hours", @"12 Hours", @"24 Hours", @"48 Hours", nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [reminderOptions count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [reminderOptions objectAtIndex:row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.reminderPeriod = row;
}

#pragma mark end

- (IBAction)buttonPressed:(id)sender {
    if([sender tag] == [_doneButton tag]) {
        switch (reminderPeriod) {
            case 0:
                reminderPeriod = 5;
                break;
            case 1:
                reminderPeriod = 15;
                break;
            case 2:
                reminderPeriod = 2*3600;
                break;
            case 3:
                reminderPeriod = 4*3600;
                break;
            case 4:
                reminderPeriod = 8*3600;
                break;
            case 5:
                reminderPeriod = 12*3600;
                break;
            case 6:
                reminderPeriod = 24*3600;
                break;
            case 7:
                reminderPeriod = 48*3600;
                break;
            default:
                break;
        }
        
        NSString *desc = [descriptionField text];
        NSLog(@"new description: %@", desc);
        Incident *incident = [[Incident alloc] initWithDescription:desc];
        NSLog(@"new incident description: %@", [incident description]);
        [[GlobalVars getVar].incidentQueue addIncident:incident];

        UILocalNotification *notification = [[UILocalNotification alloc] init];
        [notification setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
        [notification setFireDate: [NSDate dateWithTimeIntervalSinceNow: reminderPeriod]];
        [notification setAlertAction:@"Launch"];
        
        [notification setAlertBody: desc];
        [notification setHasAction: YES];

        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
        
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:[GlobalVars getVar].path];
        NSBoolean * bo = [dic objectForKey:@"EmailNotifications"];
        if([bo isTrue])
        {
            NSLog(@"sending email");
            NSString *em = [dic objectForKey:@"Email"];
            NSString *url = [@"http://108.66.96.158/email.php?t=" stringByAppendingString: em];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
            [[NSURLConnection alloc] initWithRequest:request delegate:self];
        }
        else{
            
        }
        
    }
    else if (false); //for other buttons
}
@end
