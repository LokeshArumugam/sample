//
//  AppDelegate.h
//  sample
//
//  Created by Lokesh on 7/25/14.
//  Copyright (c) 2014 Vectone. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
