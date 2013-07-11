//
//  SettingsYearTableViewController.h
//  IncidentReport
//
//  Created by Matt Gardner on 6/30/13.
//  Copyright (c) 2013 MedAppJam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsYearTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *ms1;
@property (strong, nonatomic) IBOutlet UITableViewCell *ms2;
@property (strong, nonatomic) IBOutlet UITableViewCell *ms3;
@property (strong, nonatomic) IBOutlet UITableViewCell *ms4;
@property (nonatomic) NSInteger selectedCell;\
@property (strong, nonatomic) NSDictionary *dict;

@end
