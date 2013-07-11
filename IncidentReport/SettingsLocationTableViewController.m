//
//  SettingsLocationTableViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/30/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "SettingsLocationTableViewController.h"
#import "GlobalVars.h"

@interface SettingsLocationTableViewController ()

@end

@implementation SettingsLocationTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.selectedCell = -1;
    [self.otherField setHidden:YES];
    
    NSString *path = [GlobalVars getVar].path;
    self.dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSString *location = [self.dict valueForKey:@"Location"];
    
    if ([location isEqualToString:@"UCIMC"])
        self.selectedCell = 0;
    else if ([location isEqualToString:@"LBVA"])
        self.selectedCell = 1;
    else if ([location isEqualToString:@"CHOC"])
        self.selectedCell = 2;
    else if ([location isEqualToString:@"Miller"])
        self.selectedCell = 3;
    else if ([location isEqualToString:@"Clinic:"]) {
        self.selectedCell = 4;
        [self.clinicField setText:[self.dict valueForKey:@"ClinicLocation"]];
    }
    else if ([location isEqualToString:@"Other:"]) {
        self.selectedCell = 6;
        [self.otherField setText:[self.dict valueForKey:@"OtherLocation"]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSString *path = [GlobalVars getVar].path;
    [self.dict setValue:[self.clinicField text] forKey:@"ClinicLocation"];
    [self.dict setValue:[self.otherField text] forKey:@"OtherLocation"];
    [self.dict writeToFile:path atomically:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (self.selectedCell == 4 || self.selectedCell == 5)
        return 7;
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    
    switch (row) {
        case 0:
            if (row == self.selectedCell)
                [self.ucimcCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.ucimcCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.ucimcCell;
        case 1:
            if (row == self.selectedCell)
                [self.lbvaCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.lbvaCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.lbvaCell;
        case 2:
            if (row == self.selectedCell)
                [self.chocCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.chocCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.chocCell;
        case 3:
            if (row == self.selectedCell)
                [self.millerCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.millerCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.millerCell;
        case 4:
            if (row == self.selectedCell) {
                [self.clinicCell setAccessoryType:UITableViewCellAccessoryCheckmark];
                [self.clinicField setHidden:NO];
            }
            else
                [self.clinicCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.clinicCell;
        case 5:
            if (self.selectedCell == 4)
                return self.clinicFieldCell;
            if (row == self.selectedCell) {
                [self.otherCell setAccessoryType:UITableViewCellAccessoryCheckmark];
                [self.otherField setHidden:NO];
            }
            else
                [self.otherCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.otherCell;
        case 6:
            if (self.selectedCell == 5)
                return self.otherFieldCell;
            if (row == self.selectedCell) {
                [self.otherCell setAccessoryType:UITableViewCellAccessoryCheckmark];
                [self.otherField setHidden:NO];
            }
            else
                [self.otherCell setAccessoryType:UITableViewCellAccessoryNone];
            return self.otherCell;
        default:
            NSLog(@"Error for Section %d, Row %d", [indexPath section], [indexPath row]);
            break;
    }

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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    self.selectedCell = [indexPath row];
    [self.tableView reloadData];
    
    NSString *path = [GlobalVars getVar].path;
    NSString *clerkship = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    NSLog(@"Changing location to '%@'", clerkship);
    [self.dict setValue:clerkship forKey:@"Location"];
    [self.dict writeToFile:path atomically:YES];
    
    [self.tableView reloadData];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
