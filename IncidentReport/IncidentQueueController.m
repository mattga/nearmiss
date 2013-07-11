//
//  IncidentQueueController.m
//  IncidentReport
//
//  Created by App Jam on 11/12/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import "IncidentQueueController.h"
#import "Incident.h"
@implementation IncidentQueueController
@synthesize incidentList;

- (id)init {
    self = [super init];
    if (self != nil) {
        self.incidentList = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}
- (void) addIncidentWithDescription: (NSString *)description{
    Incident *inc = [[Incident alloc] initWithDescription:description];
    NSLog(@"adding incident %@", description);
    [self.incidentList addObject:inc];
}
- (void) addIncident: (Incident *)incident{
    [self.incidentList addObject:incident];
}
- (Incident *)getIndex:(NSUInteger)theIndex {
    return [self.incidentList objectAtIndex:theIndex];
}
- (void) removeIncident:(NSUInteger) theIndex {
    [self.incidentList removeObjectAtIndex:theIndex];
}
- (NSUInteger) size {
    return [self.incidentList count];
}

@end
