//
//  Page4.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import "Page4.h"


@implementation Page4

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// ==============================================================================================================================
// ==============================================================================================================================

- (void)viewDidLoad {
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idx_glossary" ofType:@"htm"];
    
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];  
	
    [super viewDidLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)wv {
    
	bbiPrevious.enabled = wv.canGoBack;
	bbiNext.enabled     = wv.canGoForward;
}

- (IBAction) goGlossaryHome {
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idx_glossary" ofType:@"htm"];

	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];  
}

- (IBAction) goBiographyHome {
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idx_biog" ofType:@"htm"];

	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

- (IBAction) goMapHome {

	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idx_map" ofType:@"htm"];
	
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];   	
}

- (IBAction) goListsHome {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idx_lists" ofType:@"htm"];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

- (IBAction) goPrevious {
	
	[webView goBack];	
}

- (IBAction) goNext {
	
	[webView goForward];	
}

// ==============================================================================================================================
// ==============================================================================================================================

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
    [super dealloc];
}


@end
