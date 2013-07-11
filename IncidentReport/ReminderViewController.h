//
//  ReminderViewController.h
//  IncidentReport
//
//  Created by App Jam on 11/13/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *descriptionField;
@property (strong, nonatomic) NSArray *reminderOptions;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIPickerView *reminderPicker;
@property (nonatomic) NSUInteger reminderPeriod;
- (IBAction)buttonPressed:(id)sender;

@end