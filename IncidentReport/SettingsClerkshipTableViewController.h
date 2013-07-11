//
//  SettingsClerkshipTableViewController.h
//  IncidentReport
//
//  Created by Matt Gardner on 6/30/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsClerkshipTableViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *ambulatory;
@property (strong, nonatomic) IBOutlet UITableViewCell *family;
@property (strong, nonatomic) IBOutlet UITableViewCell *surgery;
@property (strong, nonatomic) IBOutlet UITableViewCell *pediatrics;
@property (strong, nonatomic) IBOutlet UITableViewCell *obGyn;
@property (strong, nonatomic) IBOutlet UITableViewCell *psychiatry;
@property (strong, nonatomic) IBOutlet UITableViewCell *neurology;
@property (strong, nonatomic) IBOutlet UITableViewCell *inpatientMed;
@property (strong, nonatomic) IBOutlet UITableViewCell *other;
@property (strong, nonatomic) IBOutlet UITableViewCell *otherCell;
@property (strong, nonatomic) IBOutlet UITextField *otherField;
@property (nonatomic) NSInteger selectedCell;
@property (strong, nonatomic) NSMutableDictionary *dict;

@end
