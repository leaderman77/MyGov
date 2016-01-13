//
//  MGAppDelegate.h
//  MyGov
//
//  Created by Alpha on 26.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MGAuthorizationController.h"
#import "MGMainMenuController.h"


@interface MGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController* nv;
@property (strong, nonatomic) MGAuthorizationController *viewController;
@property (strong, nonatomic) MGMainMenuController *mainView;


- (void)userLoggedIn:(UINavigationController *) navigationContr;
- (void)userLoggedOut:(UINavigationController *) navigationContr;

@property (assign, nonatomic) NetworkStatus netStatus;
@property (strong, nonatomic) Reachability  *hostReach;
- (void) updateInterfaceWithReachability: (Reachability*) curReach;

@end
