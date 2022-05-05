//
//  PTEAppDelegate.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright Paul A Freshney 2014. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>

@interface PTEAppDelegate : NSObject <UIApplicationDelegate> {
	
    UIWindow *window;
	
	UITabBarController *rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@end

