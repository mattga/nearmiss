//
//  SettingsLocationTableViewController.h
//  IncidentReport
//
//  Created by Matt Gardner on 6/30/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsLocationTableViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *ucimcCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *lbvaCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *chocCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *millerCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *clinicCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *clinicFieldCell;
@property (strong, nonatomic) IBOutlet UITextField *clinicField;
@property (strong, nonatomic) IBOutlet UITableViewCell *otherCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *otherFieldCell;
@property (strong, nonatomic) IBOutlet UITextField *otherField;
@property (nonatomic) NSInteger selectedCell;
@property (strong, nonatomic) NSMutableDictionary *dict;

@end
