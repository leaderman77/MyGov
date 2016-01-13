//
//  MGAppDelegate.m
//  MyGov
//
//  Created by Alpha on 26.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGAuthorizationController.h"
#import "MGMainMenuController.h"
#import "TYSingleton.h"

@implementation MGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[MGAuthorizationController alloc] init];
    //self.mainView = [[MGMainMenuController alloc] init];
    
    self.nv = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.nv;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    self.hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [self.hostReach startNotifier];
    [self updateInterfaceWithReachability: self.hostReach];
    
    if ([self.hostReach currentReachabilityStatus]== NotReachable) {
        //     NSLog(@"Not Connection");
        //[self.mainView presentModalViewController:self.viewController animated:NO];
    }
    else
    {
        //[self.mainView presentModalViewController:self.viewController animated:NO];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Default Language is: %@", [NSString stringWithFormat:@"%@", [userDefaults objectForKey:isitFirstLunch]]);
    return YES;
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach {
    self.netStatus = [curReach currentReachabilityStatus];
}

- (void) reachabilityChanged: (NSNotification* )note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
}

// Show the user the logged-out UI
- (void)userLoggedOut:(UINavigationController *)navigationContr
{
    // Set the button title as "Log in with Facebook"
    [self.mainView presentModalViewController:self.viewController animated:NO];
}

// Show the user the logged-in UI
- (void)userLoggedIn:(UINavigationController *)navigationContr
{
    [self.mainView dismissModalViewControllerAnimated:YES];
    // Set the button title as "Log out"
    //    TYMainViewController *MC = [[TYMainViewController alloc] init];
    //    [self.navController pushViewController:MC animated:NO];
    //    // Welcome message
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[TYSingleton getinstance] saveToDictionary];
}

@end
