//
//  IncidentQueueController.h
//  IncidentReport
//
//  Created by App Jam on 11/12/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Incident;

@interface IncidentQueueController : NSObject
@property (retain, nonatomic) NSMutableArray *incidentList;
-(void) addIncident:(NSString *)name  atTime:(NSDate *)date;
-(void) addIncident:(Incident *)incident;
- (void) removeIncident:(NSUInteger)theIndex;
- (Incident *)getIndex:(NSUInteger)theIndex;
- (NSUInteger) size;
@end
