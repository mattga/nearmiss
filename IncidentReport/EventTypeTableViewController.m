//
//  EventDateTableViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/21/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "EventTypeTableViewController.h"
#import "GlobalVars.h"
#import "Incident.h"

@interface EventTypeTableViewController ()

@end

@implementation EventTypeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedCell = -1;
    [self.otherField setHidden:YES];
    
    Incident *incident = [GlobalVars getVar].currentIncident;
    NSString *type = [incident type];
    
    if ([type isEqualToString:@"Communication"])
        self.selectedCell = 0;
    else if ([type isEqualToString:@"Workflow"])
        self.selectedCell = 1;
    else if ([type isEqualToString:@"Patient Safety"])
        self.selectedCell = 2;
    else if ([type isEqualToString:@"Quality of Care"])
        self.selectedCell = 3;
    else if ([type isEqualToString:@"Other:"]) {
        self.selectedCell = 4;
        [self.otherField setText:[incident otherType]];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"Saving other type '%@' to current incident", [self.otherField text]);
    [[GlobalVars getVar].currentIncident setOtherType:[self.otherField text]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (self.selectedCell == 4)
        return 6;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int row = [indexPath row];

    switch (row) {
        case 0:
            if (row == self.selectedCell)
                [self.communicationCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.communicationCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.communicationCell;
        case 1:
            if (row == self.selectedCell)
                [self.workflowCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.workflowCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.workflowCell;
        case 2:
            if (row == self.selectedCell)
                [self.patientSafetyCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.patientSafetyCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.patientSafetyCell;
        case 3:
            if (row == self.selectedCell)
                [self.qualityOfCareCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.qualityOfCareCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.qualityOfCareCell;
        case 4:
            if (row == self.selectedCell) {
                [self.otherCell setAccessoryType:UITableViewCellAccessoryCheckmark];
                [self.otherField setHidden:NO];
            }
            else
                [self.otherCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.otherCell;
        case 5:
            return self.otherFieldCell;
        default:
            NSLog(@"Error for Section %d, Row %d", [indexPath section], [indexPath row]);
            break;
    }
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    Incident *incident = [GlobalVars getVar].currentIncident;
    NSLog(@"Current incident at report: %@", [incident description]);
    self.selectedCell = [indexPath row];
    [incident setType:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
    NSLog(@"New type: %@", [incident type]);
    [tableView reloadData];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
