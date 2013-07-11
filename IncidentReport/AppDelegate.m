//
//  AppDelegate.m
//  IncidentReport
//
//  Created by Matt Gardner on 11/12/12.
//  Copyright (c) 2012 MedAppJam. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalVars.h"
#import "IncidentQueueController.h"
#import "Incident.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //Gets the bundle and saves the settings in GlobalVars>Path.
    NSString *dest = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *docPath = [dest stringByAppendingPathComponent:@"nmsettings.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"settings" ofType: @"plist"];
    [fileManager copyItemAtPath:bundlePath toPath:docPath error:nil];
    NSLog(@"File copied!");
    
    GlobalVars *vars = [GlobalVars getVar];
    vars.path = docPath;
    //NSLog(@"%@",path);
    
    vars.incidentQueue = [[IncidentQueueController alloc] init];
    
    NSString *arrayPath = [dest stringByAppendingPathComponent:@"incidentArray.plist"];
    if ([fileManager fileExistsAtPath:arrayPath]) {
    
        NSData *data = [[NSData alloc] initWithContentsOfFile:arrayPath];
        NSKeyedUnarchiver *decode = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableArray *array = [decode decodeObjectForKey:@"incidentArray"];
        [[GlobalVars getVar].incidentQueue setIncidentList:array];
    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *appDir = [[NSBundle mainBundle] resourcePath];
    NSString *src = [appDir stringByAppendingPathComponent: @"new.plist"];
    IncidentQueueController *incidentQueue = [GlobalVars getVar].incidentQueue;
    NSMutableArray *incidentArray = [incidentQueue incidentList];
    NSString *dest = [docsDir stringByAppendingPathComponent: (@"incidentArray.plist")];
    
    NSMutableData *tmp = [NSMutableData data];
    NSKeyedArchiver *encode = [[NSKeyedArchiver alloc] initForWritingWithMutableData:tmp];
    
    [encode encodeObject:incidentArray forKey:@"incidentArray"];
    [encode finishEncoding];
    
    if ([fileManager fileExistsAtPath:dest]) {
        [tmp writeToFile:dest atomically: YES];
        NSLog(@"Services array(Overwritten): %@", incidentArray);
    }else {
        [fileManager copyItemAtPath: src toPath: dest error: &error];
        [tmp writeToFile:dest atomically: YES];
        NSLog(@"Services array(New): %@", incidentArray);
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
    //[encode finalize];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[GlobalVars getVar].incidentQueue size]];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
