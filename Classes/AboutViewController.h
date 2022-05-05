//
//  FlipsideViewController.h
//  SquareWordz3
//
//  Created by Paul Freshney on 28/10/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>

@protocol AboutViewControllerDelegate;


@interface AboutViewController : UIViewController <UIActionSheetDelegate> {
	
	id <AboutViewControllerDelegate> delegate;

    IBOutlet UIImageView *background;
}

@property (nonatomic, assign) id <AboutViewControllerDelegate> delegate;

- (IBAction) done;

- (IBAction) sendEmail:(id)sender;
- (IBAction) openWeb:(id)sender;
- (IBAction) openMaximumOctopus:(id)sender;

@end


@protocol AboutViewControllerDelegate

- (void) aboutViewControllerDidFinish:(AboutViewController *)controller;

@end
