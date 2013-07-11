//
//  EventDescriptionViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/16/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "EventDescriptionViewController.h"
#import "GlobalVars.h"
#import "Incident.h"

@interface EventDescriptionViewController ()

@end

@implementation EventDescriptionViewController

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
    Incident *incident = [GlobalVars getVar].currentIncident;
    if (![[incident description] isEqualToString:@""])
        [self.descriptionField setText:[incident description]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"Saving description to current incident");
    Incident *incident = [GlobalVars getVar].currentIncident;
    NSLog(@"%d",![[incident description] isEqualToString:@"Give a description of the event here."]);
    if (![[incident description] isEqualToString:@"Give a description of the event here."])
        [incident setDescription:[self.descriptionField text]];
}

@end
