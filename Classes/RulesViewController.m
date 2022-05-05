//
//  RulesViewController.m
//  SquareWordz3
//
//  Created by Paul Freshney on 29/10/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import "RulesViewController.h"
#import "settings.h"

extern settings *mrSettings;

@implementation RulesViewController

@synthesize delegate;


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"helppage" ofType:@"htm"];
    
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}


- (IBAction)done {

	[self.delegate rulesViewControllerDidFinish:self];
}

- (void)didReceiveMemoryWarning {
    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void) aboutViewControllerDidFinish: (AboutViewController *)controller {
    
    [[controller presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) about {
	
	AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:controller animated:YES completion:nil];
	
	[controller release];
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
