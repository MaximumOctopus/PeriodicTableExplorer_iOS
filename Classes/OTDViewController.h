//
//  OTDViewController.h
//  SquareWordz3
//
//  Created by Paul Freshney on 27/03/2011.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>

@protocol OTDViewControllerDelegate;


@interface OTDViewController : UIViewController <UIActionSheetDelegate> {
	
	id <OTDViewControllerDelegate> delegate;
	
	IBOutlet UIWebView *otdWebView;
}

@property (nonatomic, assign) id <OTDViewControllerDelegate> delegate;

- (IBAction) done;

@end


@protocol OTDViewControllerDelegate

- (void) otdViewControllerDidFinish:(OTDViewController *)controller;

@end
