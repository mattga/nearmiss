//
//  Incident.h
//  IncidentReport
//
//  Created by App Jam on 11/12/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Incident : NSObject <NSCoding>
@property (copy, nonatomic) NSDate *timestamp;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *otherType;
@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSDate *date;
@property (nonatomic) NSUInteger reminderPeriod;
@property (nonatomic) BOOL gradualNotification;
- (id)initWithDescription:(NSString *)title;
- (id)initWithReportLater:(NSString *)title withReminderPeriod:(NSUInteger)reminderPeriod;
@end
