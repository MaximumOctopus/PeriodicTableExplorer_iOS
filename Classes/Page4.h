//
//  Page4.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>


@interface Page4 : UIViewController <UIWebViewDelegate> {

	IBOutlet UIWebView *webView;

	IBOutlet UIBarButtonItem *bbiGlossaryHome;
	IBOutlet UIBarButtonItem *bbiBiographyHome;
	IBOutlet UIBarButtonItem *bbiMapHome;
    IBOutlet UIBarButtonItem *bbiListsHome;
    
	IBOutlet UIBarButtonItem *bbiPrevious;
	IBOutlet UIBarButtonItem *bbiNext;
	
}

- (void)webViewDidFinishLoad:(UIWebView *)wv;

- (IBAction) goGlossaryHome;
- (IBAction) goBiographyHome;
- (IBAction) goMapHome;
- (IBAction) goListsHome;

- (IBAction) goPrevious;

- (IBAction) goNext;

@end
