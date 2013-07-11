//
//  SettingsYearTableViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/30/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "SettingsYearTableViewController.h"
#import "GlobalVars.h"

@interface SettingsYearTableViewController ()

@end

@implementation SettingsYearTableViewController

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
    
    NSString *path = [GlobalVars getVar].path;
    self.dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSString *year = [self.dict valueForKey:@"Year"];
    
    if ([year isEqualToString:@"MS1"])
        self.selectedCell = 0;
    else if ([year isEqualToString:@"MS2"])
        self.selectedCell = 1;
    else if ([year isEqualToString:@"MS3"])
        self.selectedCell = 2;
    else if ([year isEqualToString:@"MS4"])
        self.selectedCell = 3;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    switch (row) {
        case 0:
            if (row == self.selectedCell)
                [self.ms1 setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.ms1 setAccessoryType:UITableViewCellAccessoryNone];
            return self.ms1;
        case 1:
            if (row == self.selectedCell)
                [self.ms2 setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.ms2 setAccessoryType:UITableViewCellAccessoryNone];
            return self.ms2;
        case 2:
            if (row == self.selectedCell)
                [self.ms3 setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.ms3 setAccessoryType:UITableViewCellAccessoryNone];
            return self.ms3;
        case 3:
            if (row == self.selectedCell)
                [self.ms4 setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [self.ms4 setAccessoryType:UITableViewCellAccessoryNone];
            return self.ms4;
    }
    // Configure the cell...
    
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    self.selectedCell = [indexPath row];
    [self.tableView reloadData];
    
    NSString *path = [GlobalVars getVar].path;
    NSString *year = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    NSLog(@"Changing year to %@", year);
    [self.dict setValue:year forKey:@"Year"];
    [self.dict writeToFile:path atomically:YES];
}

@end
