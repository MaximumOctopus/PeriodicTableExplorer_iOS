//
//  RulesViewController.h
//  SquareWordz3
//
//  Created by Paul Freshney on 29/10/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>
#import "AboutViewController.h"

@protocol RulesViewControllerDelegate;


@interface RulesViewController : UIViewController <UIActionSheetDelegate, AboutViewControllerDelegate> {
	
	id <RulesViewControllerDelegate> delegate;
    
    IBOutlet UIWebView *webView;
}

@property (nonatomic, assign) id <RulesViewControllerDelegate> delegate;

- (IBAction) done;

- (IBAction) about;

@end


@protocol RulesViewControllerDelegate

- (void) rulesViewControllerDidFinish:(RulesViewController *)controller;

@end
