//
//  ReportViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 6/8/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.eventTypeOptions = [[NSArray alloc] initWithObjects:@"Communication", @"Workflow", @"Patient Safety", @"Quality of Care", @"Other", nil];
    [self.eventTypeOtherField setEnabled:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.eventTypeOptions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.eventTypeOptions objectAtIndex:row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.eventType = row;
    switch (self.eventType) {
        case 0:
            NSLog(@"%d selected", 0);
            break;
        case 1:
            NSLog(@"%d selected", 1);
            break;
        case 2:
            NSLog(@"%d selected", 2);
            break;
        case 3:
            NSLog(@"%d selected", 3);
            break;
        case 4:
            NSLog(@"%d selected", 4);
            [self.eventTypeOtherField setEnabled:true];
            break;
    }
}

#pragma mark end

- (IBAction)buttonPressed:(id)sender {
    switch (self.eventType) {
        case 0:
            NSLog(@"%d selected", 0);
            break;
        case 1:
            NSLog(@"%d selected", 1);
            break;
        case 2:
            NSLog(@"%d selected", 2);
            break;
        case 3:
            NSLog(@"%d selected", 3);
            break;
        case 4:
            NSLog(@"%d selected", 4);
            [self.eventTypeOtherField setEnabled:true];
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    NSLog(@"textField tag: %d", theTextField.tag);
    [theTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    NSString *answer = ([[formFields objectAtIndex:[textField tag]] text]);
//    [[[incident formQuestions] objectAtIndex:[textField tag]] setAnswer:answer];
    
}
//- (IBAction)submitPressed:(id)sender {
//    for (int i = 0; i < [[[GlobalVars getVar].incidentQueue incidentList] count]; i++) {
//        if ([[[[[GlobalVars getVar].incidentQueue incidentList] objectAtIndex:i] time] isEqualToDate:[[CurrentIncident getIncident].currentIncident time ]]) {
//            [[GlobalVars getVar].incidentQueue removeIncident:i];
//        }
//    }
//    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0] animated:YES];
//}

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    NSLog(@"textField tag: %d", textView.tag);
    [textView resignFirstResponder];
    return YES;
}

@end
