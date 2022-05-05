//
//  main.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright freshney.org 2014. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>
#import "settings.h"

settings *pteSettings;

int main(int argc, char *argv[]) {

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// =========================================================================================
    
	pteSettings  = [[settings alloc] init];
	
	pteSettings.sSearchScope = 0;
	pteSettings.sP2Category = 0;
	pteSettings.sP2ElementAN = 1;
	pteSettings.sCurrentElementAN = 1;
	pteSettings.sCurrentElementName = @"Hydrogen";
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	pteSettings.sSortOrder = [prefs integerForKey:@"sortorder"];
	
	NSString *path=[[NSBundle mainBundle] pathForResource:@"PTEName" ofType:@"plist"];	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:path];
	
	NSString *path2=[[NSBundle mainBundle] pathForResource:@"PTEAN" ofType:@"plist"];	
	pteSettings.anNameList = [[NSArray alloc] initWithContentsOfFile:path2];
	
	// =========================================================================================
	
    int retVal = UIApplicationMain(argc, argv, nil, @"PTEAppDelegate");

	// =========================================================================================		
	
	[pteSettings release];
	
    [pool release];
	
    return retVal;
}