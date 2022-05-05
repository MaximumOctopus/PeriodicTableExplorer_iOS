//
//  OTDViewController.h
//  SquareWordz3
//
//  Created by Paul Freshney on 27/03/2011.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import "OTDViewController.h"
#import "settings.h"
#import "Utility.h"


extern settings *mrSettings;

@implementation OTDViewController

@synthesize delegate;


- (void)viewDidLoad {
	
    [super viewDidLoad];
    
	[otdWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[Utility getOnThisDayFileName]]]];
}

- (IBAction)done {

	[self.delegate otdViewControllerDidFinish:self];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc {
	
    [super dealloc];
}


@end
