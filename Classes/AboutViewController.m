//
//  FlipsideViewController.m
//  SquareWordz3
//
//  Created by Paul Freshney on 28/10/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import "AboutViewController.h"
#import "settings.h"
#import "Utility.h"

extern settings *mrSettings;

@implementation AboutViewController

@synthesize delegate;


- (void)viewDidLoad {
	
    [super viewDidLoad];
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
        
        [background setImage:[UIImage imageNamed:[Utility getAboutBackground:screenHeight withHeight:screenWidth]]];
    }
}


- (IBAction)done {

	[self.delegate aboutViewControllerDidFinish:self];
}

- (void)didReceiveMemoryWarning {
    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (IBAction) sendEmail:(id)sender {
    
    NSURL *emailAddress = [NSURL URLWithString:@"mailto:apps@maximumoctopus.com"];
    
    [[UIApplication sharedApplication] openURL:emailAddress];
}

- (IBAction) openWeb:(id)sender {
    
    NSURL *webAddress = [NSURL URLWithString:@"http://www.periodictableexplorer.com"];
    
    [[UIApplication sharedApplication] openURL:webAddress];
}

- (IBAction) openMaximumOctopus:(id)sender {
    
    NSURL *webAddress = [NSURL URLWithString:@"http://maximumoctopus.com"];
    
    [[UIApplication sharedApplication] openURL:webAddress];
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
