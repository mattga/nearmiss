//
//  ReportTableViewController.h
//  IncidentReport
//
//  Created by Matt Gardner on 6/15/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GData.h"

@interface ReportTableViewController : UITableViewController <UINavigationBarDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *yearCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *clerkshipCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *locationCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *anonymizeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *eventDateCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *eventTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *eventLocationCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *eventTypeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *eventDescriptionCell;
@property (strong, nonatomic) IBOutlet UISwitch *anonEmail;
- (IBAction)submitPressed:(id)sender;

@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) UIAlertView *alertView;

@property (strong, nonatomic) GDataServiceGoogleSpreadsheet *service;
@property (strong, nonatomic) NSURL *feedURL;

@property (strong, nonatomic) GDataFeedSpreadsheet *feed;
@property (strong, nonatomic) GDataEntrySpreadsheet *spreadsheet;
- (void)ticket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedSpreadsheet *)feed error:(NSError *)error;

@property (strong, nonatomic) GDataFeedWorksheet *worksheetFeed;
@property (strong, nonatomic) GDataEntryWorksheet *worksheet;
- (void)fetchWorksheet;
- (void)worksheetTicket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedWorksheet *)feed error:(NSError *)error;

@property (strong, nonatomic) GDataFeedSpreadsheetList *listFeed;
@property (strong, nonatomic) GDataEntrySpreadsheetList *listEntry;
@property (strong, nonatomic) GDataEntrySpreadsheetList *incidentEntry;
- (void)fetchSpreadsheetList;
- (void)listTicket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedSpreadsheetList *)feed error:(NSError *)error;

- (void)insertSpreadsheetListEntry;
- (void)listEntryTicket:(GDataServiceTicket *)ticket finishWithEntry:(GDataEntrySpreadsheetList *)entry error:(NSError *)error;

@property (strong, nonatomic) NSError *feedError;

- (void) updateEventCellDetails;

@end
