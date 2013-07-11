//
//  ReportTableViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/15/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "ReportTableViewController.h"
#import "GlobalVars.h"
#import "Incident.h"
#import "NSDateAdditions.h"
#import "NSDateAdditions.m"
#import "UIViewAdditions.h"
#import "UIViewAdditions.m"
#import "EventCalendarViewController.h"
#import "RNEncryptor.h"
#import <Security/SecRandom.h>
#import "NSDataAdditions.h"

@interface ReportTableViewController ()

@end

@implementation ReportTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateEventCellDetails];
    
    NSString *path = [GlobalVars getVar].path;
    //NSLog(@"%@",path);
    self.dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [[self.nameCell detailTextLabel] setText:[self.dict valueForKey:@"Name"]];
    [[self.emailCell detailTextLabel] setText:[self.dict valueForKey:@"Email"]];
    [[self.yearCell detailTextLabel] setText:[self.dict valueForKey:@"Year"]];
    [[self.clerkshipCell detailTextLabel] setText:[self.dict valueForKey:@"Clerkship"]];
    [[self.locationCell detailTextLabel] setText:[self.dict valueForKey:@"Location"]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self performSelectorOnMainThread:@selector(updateEventCellDetails) withObject:nil waitUntilDone:NO];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 1)
        return 5;
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    return self.nameCell;
                case 1:
                    return self.emailCell;
                case 2:
                    return self.anonymizeCell;
                case 3:
                    return self.yearCell;
                case 4:
                    return self.clerkshipCell;
                case 5:
                    return self.locationCell;
                default:
                    NSLog(@"Error for Section %d, Row %d", [indexPath section], [indexPath row]);
                    break;
            }
            
        case 1:
            switch ([indexPath row]) {
                case 0:
                    return self.eventDateCell;
                case 1:
                    return self.eventTimeCell;
                case 2:
                    return self.eventLocationCell;
                case 3:
                    return self.eventTypeCell;
                case 4:
                    return self.eventDescriptionCell;
                default:
                    NSLog(@"Error for Section %d, Row %d", [indexPath section], [indexPath row]);
                    break;
            }
            
        default:
            NSLog(@"Error for Section %d", [indexPath section]);
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    if ([indexPath section] == 1 && [indexPath row] == 0) {
        EventCalendarViewController *calendar = [[EventCalendarViewController alloc] init];
        [self.navigationController pushViewController: calendar animated:YES];
    }
}

#pragma mark - Navigation bar delegate

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    NSLog(@"Just popped: %@", [item description]);
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    NSLog(@"Just pushed: %@", [item description]);
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView title] isEqual:@"Success"]) {
        //remove from incident queue
        [[self navigationController] popViewControllerAnimated:YES];
    }
    else {
        //error dismissed
    }
}

#pragma mark end

- (void) updateEventCellDetails {
    NSLog(@"Updating event cell details");
//    NSUserDefaults *infoSaved = [NSUserDefaults standardUserDefaults];
//    NSData *data = [infoSaved objectForKey:@"currentIncident"];
    Incident *incident = [GlobalVars getVar].currentIncident;//(Incident *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *type = [incident type];
    
    if ([type isEqualToString:@"Other:"])
        type = [type stringByAppendingString:[NSString stringWithFormat:@" %@", [incident otherType]]];
    [[self.eventTypeCell detailTextLabel] setText:type];
    
    [[self.eventDescriptionCell detailTextLabel] setText:[incident description]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormat setDateFormat:@"EEE, MMM d"];
    [[self.eventDateCell detailTextLabel] setText:[dateFormat stringFromDate:[incident date]]];
    
    [dateFormat setDateFormat:@"HH:mm"];
    [[self.eventTimeCell detailTextLabel] setText:[dateFormat stringFromDate:[incident date]]];
    
    [[self.eventLocationCell detailTextLabel] setText:[incident location]];
}

- (IBAction)submitPressed:(id)sender {
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Submitting"
                                           message:@"\n"
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(139.5, 75.5); // .5 so it doesn't blur
    [self.alertView addSubview:spinner];
    [spinner startAnimating];
    [self.alertView show];
    
    Incident *incident = [GlobalVars getVar].currentIncident;
    NSString *path = [GlobalVars getVar].path;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSString *email = [dict valueForKey:@"Email"];
    
    // anonymize email
    if ([self.anonEmail isOn]) {
        [self.alertView setTitle:@"Encrypting email"];
        NSData *data = [email dataUsingEncoding:NSUTF8StringEncoding];
        NSData *cipher = [RNEncryptor encryptData:data withSettings:kRNCryptorAES256Settings password:@"nm4student4928" error:nil];
        NSLog(@"Email cipher: %s", [[cipher description] UTF8String]);
        
        email = [cipher base64Encoding];
    }
    
    // Setup date formatter for incident timestamp and date
    [self.alertView setTitle:@"Creating spreadsheet entry"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormat2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormat3 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormat setDateFormat:@"EEE, MMM d 'at' HH:mm"];
    [dateFormat2 setDateFormat:@"EEE, MMM d"];
    [dateFormat3 setDateFormat:@"HH:mm"];
    
    // Create and set spreadsheet list entry custom elements
    
//    GDataSpreadsheetCustomElement *timestampCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [timestampCell setName:@"Timestamp"];
//    [timestampCell setStringValue:[dateFormat stringFromDate:[incident timestamp]]];
//    
//    GDataSpreadsheetCustomElement *nameCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [nameCell setName:@"Name"];
//    [nameCell setStringValue:[dict valueForKey:@"Name"]];
//    
//    GDataSpreadsheetCustomElement *emailCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [emailCell setName:@"Email"];
//    [emailCell setStringValue:email];
//    
//    GDataSpreadsheetCustomElement *yearCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [yearCell setName:@"Year"];
//    [yearCell setStringValue:[dict valueForKey:@"Year"]];
//    
//    GDataSpreadsheetCustomElement *clerkshipCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [clerkshipCell setName:@"Clerkship"];
//    [clerkshipCell setStringValue:[[NSString alloc] initWithFormat:@"Clerkship: %@ %@", [dict valueForKey:@"Clerkship"], [dict valueForKey:@"OtherClerkship"]]];
//    
//    GDataSpreadsheetCustomElement *locationCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [locationCell setName:@"Location"];
//    [locationCell setStringValue:[[NSString alloc] initWithFormat:@"%@ %@ %@", [dict valueForKey:@"Location"], [dict valueForKey:@"ClinicLocation"], [dict valueForKey:@"OtherLocation"]]];
//    
//    GDataSpreadsheetCustomElement *dateCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [dateCell setName:@"Date"];
//    [dateCell setStringValue:[dateFormat stringFromDate:[incident date]]];
//    
//    GDataSpreadsheetCustomElement *eventLocationCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [eventLocationCell setName:@"Event Location"];
//    [eventLocationCell setStringValue:[incident location]];
//    
//    GDataSpreadsheetCustomElement *typeCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [typeCell setName:@"Type"];
//    [typeCell setStringValue:[incident type]];
//    
//    GDataSpreadsheetCustomElement *descriptionCell = [[GDataSpreadsheetCustomElement alloc] init];
//    [descriptionCell setName:@"Description"];
//    [descriptionCell setStringValue:[incident description]];
    
    
    self.incidentEntry = [[GDataEntrySpreadsheetList alloc] init];
    NSArray *incidentRow = [[NSArray alloc] initWithObjects:
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:timestamp" stringValue:[dateFormat stringFromDate:[incident timestamp]]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:name" stringValue:[dict valueForKey:@"Name"]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:email" stringValue:email] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:year" stringValue:[dict valueForKey:@"Year"]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:clerkship" stringValue:[[NSString alloc] initWithFormat:@"Clerkship: %@ %@", [dict valueForKey:@"Clerkship"], [dict valueForKey:@"OtherClerkship"]]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:location" stringValue:[[NSString alloc] initWithFormat:@"%@ %@ %@", [dict valueForKey:@"Location"], [dict valueForKey:@"ClinicLocation"], [dict valueForKey:@"OtherLocation"]]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:date" stringValue:[dateFormat2 stringFromDate:[incident date]]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:time" stringValue:[dateFormat3 stringFromDate:[incident date]]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:eventlocation" stringValue:[incident location]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:type" stringValue:[incident type]] parent:nil],
                            [[GDataSpreadsheetCustomElement alloc] initWithXMLElement:[GDataXMLElement elementWithName:@"gsx:description" stringValue:[incident description]] parent:nil],
                            nil];
    NSLog(@"Spreadsheet list entry:");
    [self.incidentEntry setCustomElements:incidentRow];
    for (unsigned int i = 0; i < [[self.incidentEntry customElements] count]; i++)
        NSLog(@"   %@", [[[self.incidentEntry customElements] objectAtIndex:i] stringValue]);
    
    // create Google service to communicate with spreadsheet
    self.service = [[GDataServiceGoogleSpreadsheet alloc] init];
    [self.service setUserCredentialsWithUsername:@"ucisafety" password:@"patientsafety"];
    
    // fetch spreadsheet list
    [self.alertView setTitle:@"Loading spreadsheet"];
    self.feedURL = [NSURL URLWithString:kGDataGoogleSpreadsheetsPrivateFullFeed];
    NSLog(@"NearMiss Spreadsheet Feed URL: %@", self.feedURL);
    self.feed = [[GDataFeedSpreadsheet alloc] init];
    [self.service fetchFeedWithURL:self.feedURL delegate:self didFinishSelector:@selector(ticket:finishedWithFeed:error:)];
    
    NSLog(@"Submitting Incident: (");
    NSLog(@"   Description: %@", [incident description]);
    NSLog(@"   Timestamp: %@", [incident timestamp]);
    NSLog(@"   Date: %@", [incident date]);
    NSLog(@"   Type: %@", [incident type]);
    NSLog(@"   Other type: %@", [incident otherType]);
    NSLog(@"   Location: %@", [incident location]);
    NSLog(@"   Name: %@", [dict valueForKey:@"Name"]);
    NSLog(@"   Email: %@", email);
    NSLog(@"   Year: %@", [dict valueForKey:@"Year"]);
    NSLog(@"   Clerkship: %@ %@", [dict valueForKey:@"Clerkship"], [dict valueForKey:@"OtherClerkship"]);
    NSLog(@"   Hospital Location: %@ %@ %@", [dict valueForKey:@"Location"], [dict valueForKey:@"ClinicLocation"], [dict valueForKey:@"OtherLocation"]);
    NSLog(@")");
    
}

// spreadsheet list fetch callback
- (void)ticket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedSpreadsheet *)feed error:(NSError *)error {
    NSLog(@"Fetching spreadsheet list");
    if (error == nil) {
        NSArray *entries = [feed entries];
        if ([entries count] > 0) {
            self.spreadsheet = [entries objectAtIndex:0];
            NSLog(@"Spreadsheet title: %@", [[self.spreadsheet title] stringValue]);
            
            [self.alertView setTitle:@"Loading worksheet"];
            [self fetchWorksheet];
            
        } else {
            NSLog(@"the user has no spreadsheets");
        }
    } else {
        NSLog(@"fetch error: %@", error);
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@" Spreadsheet Fetch Fail" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
}

// fetch worksheet list
- (void)fetchWorksheet {
    NSLog(@"Fetching worksheet list");
    self.feedURL = [self.spreadsheet worksheetsFeedURL];
    NSLog(@"NearMiss Worksheet Feed URL: %@", self.feedURL);
    self.worksheetFeed = [[GDataFeedWorksheet alloc] init];
    [self.service fetchFeedWithURL:self.feedURL delegate:self didFinishSelector:@selector(worksheetTicket:finishedWithFeed:error:)];
}

// worksheet list fetch callback
- (void)worksheetTicket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedWorksheet *)feed error:(NSError *)error {
    if (error == nil) {
        NSArray *entries = [feed entries];
        if ([entries count] > 0) {
            self.worksheet = [entries objectAtIndex:0];
            NSLog(@"Worksheet title: %@", [[self.worksheet title] stringValue]);
            
            [self.alertView setTitle:@"Loading Spreadsheet List"];
            [self fetchSpreadsheetList];
        } else {
            NSLog(@"the user has no worksheets");
        }
    } else {
        NSLog(@"fetch error: %@", error);
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"Worksheet Fetch Fail" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
}

// fetch list-based spreadsheet
- (void)fetchSpreadsheetList {
    NSLog(@"Fetching list-based spreadsheet");
    self.feedURL = [self.worksheet listFeedURL];
    NSLog(@"NearMiss list-based spreadsheet Feed URL: %@", self.feedURL);
    self.listFeed = [[GDataFeedSpreadsheetList alloc] init];
    [self.service fetchFeedWithURL:self.feedURL delegate:self didFinishSelector:@selector(listTicket:finishedWithFeed:error:)];
}

// fetch list-based spreadsheet callback
- (void)listTicket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedSpreadsheetList *)feed error:(NSError *)error {
    if (error == nil) {
        NSArray *entries = [feed entries];
        if ([entries count] > 0) {
            self.listEntry = [entries objectAtIndex:0];
            NSLog(@"Spreadsheet list entry SAMPLE:");
            for (unsigned int i = 0; i < [[self.listEntry customElements] count]; i++)
                NSLog(@"   %@", [[[self.listEntry customElements] objectAtIndex:i] stringValue]);
            
            [self.alertView setTitle:@"Uploading Spreadsheet List Entry"];
            [self insertSpreadsheetListEntry];
        } else {
            NSLog(@"the user has no spreadsheets");
        }
    } else {
        NSLog(@"fetch error: %@", error);
        
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"Spreadsheet List Feed Fail" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fail show];
    }
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

// insert spreadsheet list entry
- (void)insertSpreadsheetListEntry {
    NSLog(@"Inserting entry into list-based spreadsheet");
    NSArray *array = [self.listEntry customElements];
    NSLog(@"%@", [[array objectAtIndex:0] description]);
    GDataSpreadsheetCustomElement *ele = [array objectAtIndex:0];
    NSLog(@"%@",[[ele XMLElement] description]);
//    [array setValue:@"Please work..." forKey:@"Timestamp"];
//    [self.listEntry setCustomElements:array];
//    GDataSpreadsheetCell *cell = [[GDataSpreadsheetCell alloc] init];
//    [GDataXMLElement elementWithName:@"Please work"];
    
    
    NSLog(@"NearMiss list-based spreadsheet Insert URL: %@", self.feedURL);
    [self.service fetchEntryByInsertingEntry:self.incidentEntry forFeedURL:self.feedURL delegate:self didFinishSelector:@selector(listEntryTicket:finishWithEntry:error:)];
}

// insert spreadsheet list entry callback
- (void)listEntryTicket:(GDataServiceTicket *)ticket finishWithEntry:(GDataEntrySpreadsheetList *)entry error:(NSError *)error {
    if (error == nil) {
        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Thank you for your submission, your concern will be evaluated and you will receive a follow-up email shortly." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [success show];
    }
    else {
        NSLog(@"insert error: %@", error);
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"Insert Entry Fail" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fail show];
    }
}


@end
