//
//  Page3.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import "ImageViewController.h"
#import "settings.h"

extern settings *pteSettings;

const CGFloat kiScrollObjHeight	= 411.0;
const CGFloat kiScrollObjWidth	= 320.0;

NSInteger currentElement = -1;
NSInteger currentIndex;

const int imagesCount[] = {2,3,2,2,2,3,2,2,3,3, 2,4,3,2,2,2,1,3,3,3, 2,2,3,3,3,3,1,1,2,3, 2,2,1,2,1,3,1,3,2,2,
                           3,3,1,2,2,2,2,2,2,3, 3,2,2,3,2,2,2,2,2,2, 2,2,2,2,2,2,2,2,2,2, 2,1,2,2,2,2,2,2,4,2,
                           2,3,4,1,1,1,1,2,1,1, 1,1,1,2,1,1};

@implementation ImageViewController

@synthesize delegate;
@synthesize scrollView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)addImagesFromAN:(NSInteger) atomicNumber {

	NSArray *subviewsX = [scrollView subviews];
	
	if (subviewsX.count != 0)
	{
		for (NSInteger t = subviewsX.count - 1; t >= 0; t--)
		{
			UIImageView *viewX = [subviewsX objectAtIndex:t];
		
			if ([viewX tag] > 0)
			{
				[viewX removeFromSuperview];
			}
		}
	}
	
	if (atomicNumber > 96)
	{
		NSString *imageName = @"na.jpg";
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = imageView.frame;
		rect.size.height = kiScrollObjHeight;
		rect.size.width = kiScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = 1;	// tag our images for later use when we place them in serial fashion
		[scrollView addSubview:imageView];
		[imageView release];
	}
	else
	{
		for (int i = 1; i <= imagesCount[atomicNumber - 1]; i++)
		{
			NSString *imageName = [NSString stringWithFormat:@"%ld_%d.jpg", (long)atomicNumber, i];
			UIImage *image = [UIImage imageNamed:imageName];
			UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
			// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
			CGRect rect = imageView.frame;
			rect.size.height = kiScrollObjHeight;
			rect.size.width = kiScrollObjWidth;
			imageView.frame = rect;
			imageView.tag = i;	// tag our images for later use when we place them in serial fashion
			[scrollView addSubview:imageView];
			[imageView release];
		}
	}
		
	UIImageView *view = nil;
	NSArray *subviews = [scrollView subviews];
	
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kiScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	if (currentElement > 96)
	{
		[scrollView setContentSize:CGSizeMake(1 * (kiScrollObjWidth), kiScrollObjHeight)];		
	}
	else
	{
		[scrollView setContentSize:CGSizeMake((imagesCount[atomicNumber-1] * (kiScrollObjWidth)), kiScrollObjHeight)];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];

}

- (void)viewDidLoad {
	
	[super viewDidLoad];
    
	self.view.backgroundColor = [UIColor blackColor];
	
	[scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;	
	scrollView.pagingEnabled = YES;	
	
	currentElement = pteSettings.sCurrentElementAN;
	currentIndex   = pteSettings.tSelectedRow;
	
	labelElement.text = pteSettings.sCurrentElementName;
		
	[self updateImages];
	
}

- (void) updateImages {
	
	[self addImagesFromAN:currentElement];
	
}

- (void) openInfo {
	
	CGPoint contentSize = scrollView.contentOffset;
	
	NSInteger imageIndex = (int)((contentSize.x / 320) + 1);
	
	NSString *fileName = [[NSString alloc] initWithFormat:@"%ld_%ld", (long)currentElement, (long)imageIndex];
	NSString *mTitle   = [[NSString alloc] initWithFormat:@".: %@ :.", labelElement.text];
	
	NSString *message  = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];

    UIAlertView *openAlert = [[UIAlertView alloc] initWithTitle:mTitle message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[openAlert show];
    
	[openAlert release];
	
	[mTitle release];
	[fileName release];
}

- (IBAction) previousElement {
	
	currentIndex--;
	
	if (currentIndex == 0)
	{
		bbiPrevious.enabled = NO;
	}
	
	bbiNext.enabled = YES;	
	
	// ==============================================================================
		
	NSDictionary *anElement = (NSDictionary *)[pteSettings.rawElementsArray objectAtIndex:currentIndex];
	
	currentElement = [[anElement objectForKey:@"atomicnumber"] intValue];
	labelElement.text = [anElement objectForKey:@"name"];
	
	[self addImagesFromAN:currentElement];
	
}

- (IBAction) nextElement {
	
	currentIndex++;
	
	if (currentIndex == 117)
	{
		bbiNext.enabled = NO;
	}
	
	bbiPrevious.enabled = YES;

	// ==============================================================================	
	
	NSDictionary *anElement = (NSDictionary *)[pteSettings.rawElementsArray objectAtIndex:currentIndex];
	
	currentElement = [[anElement objectForKey:@"atomicnumber"] intValue];
	labelElement.text = [anElement objectForKey:@"name"];
	
	[self addImagesFromAN:currentElement];
}


- (IBAction) done {
	
	[self.delegate imageViewControllerDidFinish:self];
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
