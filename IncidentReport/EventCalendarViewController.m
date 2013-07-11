//
//  EventCalendarViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/26/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "EventCalendarViewController.h"
#import "GlobalVars.h"
#import "Incident.h"

@interface EventCalendarViewController ()

@end

@implementation EventCalendarViewController

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
        NSDate *date = [[GlobalVars getVar].currentIncident date];
        if (date != nil)
            selectedDate = date;
        [[self navigationItem] setTitle:@"Event Date"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    Incident *incident = [GlobalVars getVar].currentIncident;
    [incident setDate:[super selectedDate]];
    NSLog(@"Updating date to: %@", [[incident date] description]);
    [super viewWillDisappear:YES];
}

@end
