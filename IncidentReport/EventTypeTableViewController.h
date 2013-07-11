//
//  EventDateTableViewController.h
//  IncidentReport
//
//  Created by Matt Gardner on 6/21/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTypeTableViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *communicationCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *workflowCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *patientSafetyCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *qualityOfCareCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *otherCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *otherFieldCell;
@property (nonatomic) NSInteger selectedCell;
@property (strong, nonatomic) IBOutlet UITextField *otherField;

@end
