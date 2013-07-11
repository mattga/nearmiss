//
//  SettingsClerkshipTableViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/30/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "SettingsClerkshipTableViewController.h"
#import "GlobalVars.h"

@interface SettingsClerkshipTableViewController ()

@end

@implementation SettingsClerkshipTableViewController

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
    NSString *clerkship = [self.dict valueForKey:@"Clerkship"];
    NSLog(@"OtherField: %@", [self.dict valueForKey:@"OtherField"]);
    
    if ([clerkship isEqualToString:@"Ambulatory"])
        self.selectedCell = 0;
    else if ([clerkship isEqualToString:@"Family"])
        self.selectedCell = 1;
    else if ([clerkship isEqualToString:@"Surgery"])
        self.selectedCell = 2;
    else if ([clerkship isEqualToString:@"Pediatrics"])
        self.selectedCell = 3;
    else if ([clerkship isEqualToString:@"OB/Gyn"])
        self.selectedCell = 4;
    else if ([clerkship isEqualToString:@"Psychiatry"])
        self.selectedCell = 5;
    else if ([clerkship isEqualToString:@"Neurology"])
        self.selectedCell = 6;
    else if ([clerkship isEqualToString:@"Inpatient Medicine"])
        self.selectedCell = 7;
    else if ([clerkship isEqualToString:@"Other:"]) {
        self.selectedCell = 8;
        [self.otherField setText:[self.dict valueForKey:@"OtherClerkship"]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSString *path = [GlobalVars getVar].path;
    [self.dict setValue:[self.otherField text] forKey:@"OtherClerkship"];
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
    if (self.selectedCell == 8)
        return 10;
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int row = [indexPath row];
    
    switch (row) {
        case 0:
            if (row == self.selectedCell)
                [self.ambulatory setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.ambulatory setAccessoryType:UITableViewCellAccessoryNone];
            return self.ambulatory;
        case 1:
            if (row == self.selectedCell)
                [self.family setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.family setAccessoryType:UITableViewCellAccessoryNone];
            return self.family;
        case 2:
            if (row == self.selectedCell)
                [self.surgery setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.surgery setAccessoryType:UITableViewCellAccessoryNone];
            return self.surgery;
        case 3:
            if (row == self.selectedCell)
                [self.pediatrics setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.pediatrics setAccessoryType:UITableViewCellAccessoryNone];
            return self.pediatrics;
        case 4:
            if (row == self.selectedCell)
                [self.obGyn setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.obGyn setAccessoryType:UITableViewCellAccessoryNone];
            return self.obGyn;
        case 5:
            if (row == self.selectedCell)
                [self.psychiatry setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.psychiatry setAccessoryType:UITableViewCellAccessoryNone];
            return self.psychiatry;
        case 6:
            if (row == self.selectedCell)
                [self.neurology setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.neurology setAccessoryType:UITableViewCellAccessoryNone];
            return self.neurology;
        case 7:
            if (row == self.selectedCell)
                [self.inpatientMed setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.inpatientMed setAccessoryType:UITableViewCellAccessoryNone];
            return self.inpatientMed;
        case 8:
            if (row == self.selectedCell) {
                [self.other setAccessoryType:UITableViewCellAccessoryCheckmark];
                [self.otherField setHidden:NO];
            }
            else
                [self.other setAccessoryType:UITableViewCellAccessoryNone];
            return self.other;
        case 9:
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
    NSLog(@"Changing clerkship to '%@'", clerkship);
    [self.dict setValue:clerkship forKey:@"Clerkship"];
    [self.dict writeToFile:path atomically:YES];
    
    [self.tableView reloadData];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
