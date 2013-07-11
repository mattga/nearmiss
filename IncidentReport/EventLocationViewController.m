//
//  EventLocationViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/27/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "EventLocationViewController.h"
#import "GlobalVars.h"
#import "Incident.h"

@interface EventLocationViewController ()

@end

@implementation EventLocationViewController

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
    [self.locationField setText:[[GlobalVars getVar].currentIncident location]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    Incident *incident = [GlobalVars getVar].currentIncident;
    [incident setLocation:[self.locationField text]];
    NSLog(@"Updating location to %@", [incident location]);
}

#pragma mark Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
