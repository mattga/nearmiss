//
//  ViewController.m
//  IncidentReport
//
//  Created by Matt Gardner on 11/12/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import "ViewController.h"
#import "IncidentQueueController.h"
#import "Incident.h"
#import "GlobalVars.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize incidentTitles, incidentDates;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
	// Do any additional setup after loading the view, typically from a nib.
    [self.incidentTable setEditing:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    incidentTitles = [[NSMutableArray alloc] initWithObjects:@"Description", nil];
    incidentDates = [[NSMutableArray alloc] initWithObjects:@"Date Reported",nil];
    IncidentQueueController *incidentQueue = [GlobalVars getVar].incidentQueue;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, MMM d 'at' HH:mm"];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    for(int i = 0; i < [incidentQueue size]; i++) {
        Incident *incident = [incidentQueue getIndex:i];
        [self.incidentTitles addObject:[incident description]];
        
        NSDate *date = [[incidentQueue getIndex:i] timestamp];
        NSString *theDate = [dateFormat stringFromDate:date];
        [self.incidentDates addObject:theDate];
        //[[incidentQueue getIndex:i].time descriptionWithLocale:[NSLocale currentLocale]]
    }
    NSLog(@"IncidentQueue: %@", [incidentQueue incidentList]);
    [self.incidentTable reloadData];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
	
#pragma mark -
#pragma mark IncidentTable DateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Unreported Incidents:";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.incidentTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if([indexPath row] != 0)
        cell = [tableView dequeueReusableCellWithIdentifier:@"incidentCell"];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    
    
    cell.textLabel.text = [self.incidentTitles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.incidentDates objectAtIndex:indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if ([indexPath row] != 0)
        return YES;
    else
        return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Deleted %@", [[[GlobalVars getVar].incidentQueue getIndex:([indexPath row] - 1)] description]);
        [[GlobalVars getVar].incidentQueue removeIncident:([indexPath row] - 1)];
        [self viewWillAppear:YES];
    }
}

#pragma mark -
#pragma mark IncidentTable Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] > 0) {
        Incident *incident = [[GlobalVars getVar].incidentQueue getIndex:([indexPath row] - 1)];
        
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:incident];
//        NSUserDefaults *infoSaved = [NSUserDefaults standardUserDefaults];
//        [infoSaved setObject:data forKey:@"currentIncident"];
//        [infoSaved synchronize];
        
        [self setCurrentIncident:incident];
        NSLog(@"Current incident: %@", [incident description]);
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([indexPath row] == 0)
//        cell.backgroundColor = [UIColor colorWithRed:0.72225 green:0.72225 blue:0.72225 alpha:1];
//}

#pragma mark end

- (IBAction)reportNow:(Incident *)sender {
    Incident *incident = [[Incident alloc] initWithDescription:@"New near miss"];
    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:incident];
//    NSUserDefaults *infoSaved = [NSUserDefaults standardUserDefaults];
//    [infoSaved setObject:data forKey:@"currentIncident"];
//    [infoSaved synchronize];
//    
    [self setCurrentIncident:incident];
    [[GlobalVars getVar].incidentQueue addIncident:incident];
    NSLog(@"Current incident: %@", [incident description]);
    [self performSegueWithIdentifier:@"reportNow" sender:incident];
}

- (void)setCurrentIncident:(Incident*)incident {
    [GlobalVars getVar].currentIncident = incident;
}

@end
