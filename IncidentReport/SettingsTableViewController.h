//
//  SettingsTableViewController.h
//  IncidentReport
//
//  Created by Matt Gardner on 6/30/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITableViewCell *yearCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *clerkshipCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *locationCell;

@end
