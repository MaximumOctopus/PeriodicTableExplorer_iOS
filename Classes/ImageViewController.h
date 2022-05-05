//
//  Page3.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>

@protocol ImageViewControllerDelegate;

@class MyScrollView;

@interface ImageViewController : UIViewController <UIActionSheetDelegate> {

	IBOutlet UIScrollView *scrollView;
	
	IBOutlet UIBarButtonItem *bbiHelp;
	IBOutlet UIBarButtonItem *bbiPrevious;
	IBOutlet UIBarButtonItem *bbiNext;
	
	IBOutlet UILabel *labelElement;
}

@property (nonatomic, retain) UIView *scrollView;

- (void) addImagesFromAN:(NSInteger) atomicNumber;

- (void) updateImages;

- (IBAction) openInfo;

- (IBAction) previousElement;

- (IBAction) nextElement;

@property (nonatomic, assign) id <ImageViewControllerDelegate> delegate;

- (IBAction) done;

@end

@protocol ImageViewControllerDelegate

- (void) imageViewControllerDidFinish:(ImageViewController *)controller;

@end