//
//  PTEAppDelegate.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright Paul A Freshney 2014. All rights reserved.
//  April 18th 2016

#import "PTEAppDelegate.h"
#import "Flurry.h"

@implementation PTEAppDelegate

@synthesize window;
@synthesize rootController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    [Flurry startSession:@"X2HQC8258KJTD5GKXQKB"];
    
    // Override point for customization after application launch
    //	[window addSubview:rootController.view];
    [window setRootViewController:rootController];
	
    [window makeKeyAndVisible];
}


- (void)dealloc {
	
	[rootController release];
    [window release];
    [super dealloc];
}

@end
