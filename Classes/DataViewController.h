//
//  Page2.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h> 
#import "ImageViewController.h"

@protocol DataViewControllerDelegate;

@interface DataViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate, ImageViewControllerDelegate> {

	id <DataViewControllerDelegate> delegate;
	
	IBOutlet UIWebView *webView;
	
	IBOutlet UIToolbar *p2Toolbar;
	
	IBOutlet UIBarButtonItem *bbiMain;
	IBOutlet UIBarButtonItem *bbiOther;
	IBOutlet UIBarButtonItem *bbiReactions;
	IBOutlet UIBarButtonItem *bbiProduction;
	IBOutlet UIBarButtonItem *bbiMore;
	
	IBOutlet UIBarButtonItem *bbiBack;
	IBOutlet UIBarButtonItem *bbiForward;
	
	IBOutlet UILabel *lTitle;
}

- (void)webViewDidFinishLoad:(UIWebView *)wv;

- (void) changePageTo:(NSInteger) pageCategory;

- (IBAction) goPrevious;
- (IBAction) goNext;

- (IBAction) goMain;
- (IBAction) goOther;
- (IBAction) goReactions;
- (IBAction) goProduction;
- (IBAction) goImages;
- (void) goIsotopes;
- (void) goSpectra;
- (void) goAD;
- (void) goMAC;
- (void) goAllotrope;
- (void) goMore;


@property (nonatomic, assign) id <DataViewControllerDelegate> delegate;

- (IBAction) done;

@end

@protocol DataViewControllerDelegate

- (void) dataViewControllerDidFinish:(DataViewController *)controller;

@end
