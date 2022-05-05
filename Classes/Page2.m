//
//  Page2.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2010 freshney.org. All rights reserved.
//

#import "Page2.h"
#import "settings.h"

extern settings *pteSettings;

@implementation Page2

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
/*
- (void)viewDidLoad {
	  
    [super viewDidLoad];

}*/

- (void)viewDidAppear:(BOOL)animated {
	
	extern settings *pteSettings;
	
	[self changePageTo:pteSettings.sP2Category];
	
}

- (void) webViewDidFinishLoad:(UIWebView *)wv {
    
	bbiForward.enabled = webView.canGoForward;
	bbiBack.enabled = webView.canGoBack;
	
	if ([self getElementANFromPage:webView.request.URL.absoluteString] >0 -1)
	{
		pteSettings.sP2ElementAN = [self getElementANFromPage:webView.request.URL.absoluteString];
	}
}

- (int) getElementANFromPage:(NSString *)page {

	if ([page length] != 0)
	{
		page = [page lastPathComponent];
	
		NSCharacterSet *wildCardSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz."];
	
		NSString *eAN = [page stringByTrimmingCharactersInSet:wildCardSet];
		
		if ([eAN length] == 0)
		{
			return -1;
		}
		else
		{
			return [eAN intValue];
		}
	}
	else
	{
		return -1;
	}
}

- (void) changePageTo:(int) pageCategory {
	
	pteSettings.sP2Category = pageCategory;
	
	NSString *filePath = @"";

	switch (pageCategory)
	{
		case 0:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", pteSettings.sP2ElementAN] ofType:@"htm"];
			break;
		case 1:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"o%d", pteSettings.sP2ElementAN] ofType:@"htm"];  
			break;
		case 2:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"r%d", pteSettings.sP2ElementAN] ofType:@"htm"];  
			break;
		case 3:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"p%d", pteSettings.sP2ElementAN] ofType:@"htm"];
			break;
		case 4:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"c%d", pteSettings.sP2ElementAN] ofType:@"htm"];			
			break;
		case 5:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"i%d", pteSettings.sP2ElementAN] ofType:@"htm"];
			break;
		case 6:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"s%d", pteSettings.sP2ElementAN] ofType:@"htm"];
			break;
		case 7:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"ad%d", pteSettings.sP2ElementAN] ofType:@"htm"];
			break;
		case 8:
			filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"mac%d", pteSettings.sP2ElementAN] ofType:@"htm"];
			break;
	}
	
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

- (void) goMore {
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Atomic Reference", @"Compounds", @"Isotopes", @"Mass Attenuation", @"Spectra", NULL];
	
	[actionSheet showFromToolbar: p2Toolbar];
	
	[actionSheet release];
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
	}
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
