//
//  DCAppDelegate.m
//  CalendarSearchBar
//
//  Created by Diogo do Carmo on 29/03/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "DCAppDelegate.h"

//View Controllers
#import "DCViewController.h"

@implementation DCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[DCViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
