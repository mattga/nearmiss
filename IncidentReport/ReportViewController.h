//
//  ReportViewController.h
//  IncidentReport
//
//  Created by Matt Gardner on 6/8/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *dateField;
@property (strong, nonatomic) IBOutlet UIPickerView *eventTypePicker;
@property (strong, nonatomic) IBOutlet UITextField *eventLocationField;
@property (strong, nonatomic) IBOutlet UITextField *eventTimeField;
@property (strong, nonatomic) IBOutlet UITextView *eventDescriptionField;
@property (strong, nonatomic) IBOutlet UITextField *eventTypeOtherField;
@property (strong, nonatomic) NSDate *eventDate;
@property (strong, nonatomic) NSArray *eventTypeOptions;
@property (nonatomic) NSUInteger eventType;
- (IBAction)buttonPressed:(id)sender;

@end
