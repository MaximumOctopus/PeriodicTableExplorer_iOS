//
//  Page2.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import "DataViewController.h"
#import "constants.h"
#import "settings.h"
#import "Utility.h"

extern settings *pteSettings;

int haveAllotrope = 0;

@implementation DataViewController

@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return sbelf;
}
*/

// ==============================================================================================================================
// ==============================================================================================================================

- (void)viewDidLoad {
	  
    [super viewDidLoad];
 
	lTitle.text = pteSettings.sCurrentElementName;
 
	[self changePageTo:pteSettings.sP2Category];

}

- (void)viewDidAppear:(BOOL)animated {
	
	extern settings *pteSettings;
	
}

- (void) webViewDidFinishLoad:(UIWebView *)wv {
    
	bbiForward.enabled = webView.canGoForward;
	bbiBack.enabled = webView.canGoBack;
	
	if ([Utility getElementANFromPage:webView.request.URL.absoluteString] != -1)
	{
		pteSettings.sP2ElementAN = [Utility getElementANFromPage:webView.request.URL.absoluteString];
		
		if (pteSettings.sP2ElementAN!=pteSettings.sCurrentElementAN)
		{
			NSDictionary *anElement = (NSDictionary *)[pteSettings.anNameList objectAtIndex:pteSettings.sP2ElementAN-1];
			
			pteSettings.sCurrentElementAN = pteSettings.sP2ElementAN;
			lTitle.text      = [anElement objectForKey:@"name"];
		}
	}
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[request.mainDocumentURL absoluteString] rangeOfString:@"sfx:"].location == NSNotFound)
    {
        return YES;
    }
    else
    {
        [Utility playSpeech:pteSettings.sP2ElementAN];
        
        return NO;
    }
}

- (void) changePageTo:(NSInteger) pageCategory {
	
	pteSettings.sP2Category = pageCategory;
	
    NSString *filePath = [Utility getFilePathFromCategory:(NSInteger)pageCategory withElementAN:(NSInteger)pteSettings.sP2ElementAN];
	
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];  	
}

- (IBAction) goMain {

	[self changePageTo:0];
}

- (IBAction) goOther {
	
	[self changePageTo:1];
}

- (IBAction) goReactions {

	[self changePageTo:2];
}

- (IBAction) goProduction {
	
	[self changePageTo:3];	
}

- (void) goCompounds {
	
	[self changePageTo:4];	
}

- (void) goIsotopes {
	
	[self changePageTo:5];
}

- (void) goSpectra {
	
	[self changePageTo:6];
}

- (void) goAD {
	
	[self changePageTo:7];
}

- (void) goMAC {
	
	[self changePageTo:8];
}

- (void) goAllotrope {
	
	if (haveAllotrope == 1)
	{
		[self changePageTo:9];
	}
}

- (void) goMore {
	
	int allotropez[11] = {5, 6, 8, 15, 16, 33, 34, 50, 70, 92, 94};
	
	haveAllotrope = 0;
	
	for (int t = 0; t < CAllotropeCount; t++)
	{
		if (allotropez[t] == pteSettings.sP2ElementAN)
		{
			haveAllotrope = 1;
		}
	}
	
	if (haveAllotrope == 0)
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Atomic Reference", @"Compounds", @"Isotopes", @"Mass Attenuation", @"Spectra", NULL];
	
		[actionSheet showFromToolbar: p2Toolbar];
	
		[actionSheet release];
	}
	else
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Atomic Reference", @"Compounds", @"Isotopes", @"Mass Attenuation", @"Spectra", @"Allotrope", NULL];
		
		[actionSheet showFromToolbar: p2Toolbar];
		
		[actionSheet release];
	}

}

- (IBAction) goImages {
	
	ImageViewController *controller = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:controller animated:YES completion:nil];
	
	[controller release];
	
}

- (void)actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	switch (buttonIndex)
	{
		case 0:
			[self goAD];
			break;
		case 1:
			[self goCompounds];
			break;
		case 2:
			[self goIsotopes];
			break;
		case 3:
			[self goMAC];
			break;		
		case 4:
			[self goSpectra];
			break;
		case 5:
			[self goAllotrope];
			break;
	}
}


- (IBAction) goPrevious {

	[webView goBack];
}

- (IBAction) goNext {
	
	[webView goForward];	
}

- (IBAction) done {
	
	[self.delegate dataViewControllerDidFinish:self];
}

- (void) imageViewControllerDidFinish: (ImageViewController *)controller {
    
	[[controller presentingViewController] dismissViewControllerAnimated:YES completion:nil];
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

- (BOOL)prefersStatusBarHidden {
    return YES;
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


- (void)dealloc {
    [super dealloc];
}


@end
