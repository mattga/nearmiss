//
//  GlobalVars.m
//  IncidentReport
//
//  Created by Matt Gardner on 11/18/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import "GlobalVars.h"

@implementation GlobalVars
static GlobalVars *instance =nil;

+(GlobalVars *)getVar
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [GlobalVars alloc];
        }
    }
    return instance;
}

@end