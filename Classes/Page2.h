//
//  Page2.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2010 freshney.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Page2 : UIViewController <UIWebViewDelegate, UIActionSheetDelegate> {

	IBOutlet UIWebView *webView;
	
	IBOutlet UIToolbar *p2Toolbar;
	
	IBOutlet UIBarButtonItem *bbiMain;
	IBOutlet UIBarButtonItem *bbiOther;
	IBOutlet UIBarButtonItem *bbiReactions;
	IBOutlet UIBarButtonItem *bbiProduction;
	IBOutlet UIBarButtonItem *bbiMore;
	
	IBOutlet UIBarButtonItem *bbiBack;
	IBOutlet UIBarButtonItem *bbiForward;
}

- (void)webViewDidFinishLoad:(UIWebView *)wv;

- (int) getElementANFromPage:(NSString *)page;

- (void) changePageTo:(int) pageCategory;

- (IBAction) goPrevious;

- (IBAction) goNext;

- (IBAction) goMain;

- (IBAction) goOther;

- (IBAction) goReactions;

- (IBAction) goProduction;

- (void) goIsotopes;

- (void) goSpectra;

- (void) goAD;

- (void) goMAC;

- (void) goMore;

@end