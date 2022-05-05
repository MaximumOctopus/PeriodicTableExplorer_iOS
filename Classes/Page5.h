//
//  Page5.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface Page5 : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UIWebViewDelegate> {

	sqlite3 *db;
	
	NSTimer *swTimer;
	
	NSArray *elementSymbols;
	
	IBOutlet UIWebView *sWebView;
	IBOutlet UIToolbar *p5Toolbar;
	
	IBOutlet UITextField *userEntry;
	
	IBOutlet UILabel *labelSearch;
	
	IBOutlet UIBarButtonItem *bbiPrevious;
	IBOutlet UIBarButtonItem *bbiNext;
	
	IBOutlet UIActivityIndicatorView *pleaseWait;
}

- (void) openSearchPage;

- (IBAction) searchScope;

- (void) waitAnimOn;

- (void) waitAnimOff;

- (int) SymbolToAn: (NSString *)symbol;

- (void) doSearch;

- (IBAction) previousSearch;

- (IBAction) nextSearch;

@end