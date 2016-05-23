//
//  AppDelegate.m
//  pancho
//
//  Created by Paulo Mendes on 5/16/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "AppDelegate.h"
#import "GPSManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[GPSManager sharedManager] askForPermition];
    return YES;
}

@end
