//
//  Incident.m
//  IncidentReport
//
//  Created by App Jam on 11/12/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import "Incident.h"

@implementation Incident
@synthesize gradualNotification, date, description, location, otherType;

- (id) initWithDescription:(NSString *)desc {
    self = [super init];
    if (self){
        self.description = desc;
        gradualNotification = NO;
        self.timestamp = [NSDate date];
        self.location = @"";
        self.type = @"";
        self.otherType = @"";
        self.date = nil;
        NSLog(@"creating incident with description: %@", desc);
        return self;
    }
    return nil;
}

//- (id)initWithReportLater:(NSString *)desc withReminderPeriod:(NSUInteger)reminderPeriod {
//    self = [super init];
//    if (self) {
//        self.description = desc;
//        self.timestamp = [NSDate date];
//        self.gradualNotification = NO;
//        self.location = @"";
//        self.type = @"";
//        self.otherType = @"";
//        NSLog(@"creating incident with description: %@", desc);
//    }
//    return nil;
//}

#pragma IncidentQueueController NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.description forKey:@"Title"];
    [aCoder encodeObject:self.timestamp forKey:@"Time"];
    [aCoder encodeObject:self.date forKey:@"Date"];
    [aCoder encodeObject:self.location forKey:@"Location"];
    [aCoder encodeObject:self.type forKey:@"Type"];
    [aCoder encodeObject:self.otherType forKey:@"OtherType"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.description = [aDecoder decodeObjectForKey:@"Title"];
        self.timestamp = [aDecoder decodeObjectForKey:@"Time"];
        self.date = [aDecoder decodeObjectForKey:@"Date"];
        self.location = [aDecoder decodeObjectForKey:@"Location"];
        self.type = [aDecoder decodeObjectForKey:@"Type"];
        self.otherType = [aDecoder decodeObjectForKey:@"OtherType"];
    }
    return self;
}

@end
