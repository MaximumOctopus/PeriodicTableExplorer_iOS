//
//  Page3.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2010 freshney.org. All rights reserved.
//

#import "pImages.h"
#import "settings.h"

extern settings *pteSettings;

const CGFloat kScrollObjHeight	= 411.0;
const CGFloat kScrollObjWidth	= 320.0;

int p3CurrentElement = -1;
int p3CurrentIndex;

const int imageCount[] = {2,3,2,2,2,3,2,2,3,3, 2,4,3,2,2,2,1,3,3,3, 2,2,3,3,3,3,1,1,2,3, 2,2,1,2,1,3,1,3,2,2, 3,3,1,2,2,2,2,2,2,3,
						  3,2,2,3,2,2,2,2,2,2, 2,2,2,2,2,2,2,2,2,2, 2,1,2,2,2,2,2,2,4,2, 2,3,4,1,1,1,1,2,1,1, 1,1,1,2,1,1};

@implementation Page3

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
		for (int t=subviewsX.count-1; t>=0; t--)
		{
			UIImageView *viewX = [subviewsX objectAtIndex:t];
		
			if ([viewX tag]>0)
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
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = 1;	// tag our images for later use when we place them in serial fashion
		[scrollView addSubview:imageView];
		[imageView release];
	}
	else
	{
		for (int i = 1; i <= imageCount[atomicNumber-1]; i++)
		{
			NSString *imageName = [NSString stringWithFormat:@"%d_%d.jpg", atomicNumber, i];
			UIImage *image = [UIImage imageNamed:imageName];
			UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
			// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
			CGRect rect = imageView.frame;
			rect.size.height = kScrollObjHeight;
			rect.size.width = kScrollObjWidth;
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
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	if (p3CurrentElement > 96)
	{
		[scrollView setContentSize:CGSizeMake(1 * (kScrollObjWidth), kScrollObjHeight)];		
	}
	else
	{
		[scrollView setContentSize:CGSizeMake((imageCount[atomicNumber-1] * (kScrollObjWidth)), kScrollObjHeight)];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	
	p3CurrentElement = pteSettings.sCurrentElementAN;
	p3CurrentIndex = pteSettings.tSelectedRow;
	
	labelElement.text = pteSettings.sCurrentElementName;
	
	[super viewDidAppear:animated];
	
	[self updateImages];

}

- (void)viewDidLoad {
	
	[super viewDidLoad];
    
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	
	[scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;	
	scrollView.pagingEnabled = YES;	
}

- (void) updateImages {
	
	[self addImagesFromAN:p3CurrentElement];
	
}

- (void) openInfo {
	
	CGPoint contentSize = scrollView.contentOffset;
	
	NSInteger imageIndex = (int)((contentSize.x/320)+1);
	
	NSString *fileName = [[NSString alloc] initWithFormat:@"%d_%d", p3CurrentElement, imageIndex];
	NSString *mTitle = [[NSString alloc] initWithFormat:@".: %@ :.", labelElement.text];
	
	NSString *message = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];

    UIAlertView *openAlert = [[UIAlertView alloc] initWithTitle:mTitle message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[openAlert show];
    
	[openAlert release];
	
	[mTitle release];
	[fileName release];
}

- (IBAction) previousElement {
	
	p3CurrentIndex--;
	
	if (p3CurrentIndex == 0)
	{
		bbiPrevious.enabled = NO;
	}
	
	bbiNext.enabled = YES;	
	
	// ==============================================================================
		
	NSDictionary *anElement = (NSDictionary *)[pteSettings.rawElementsArray objectAtIndex:p3CurrentIndex];
	
	p3CurrentElement = [[anElement objectForKey:@"atomicnumber"] intValue];
	labelElement.text = [anElement objectForKey:@"name"];
	
	[self addImagesFromAN:p3CurrentElement];
	
}

- (IBAction) nextElement {
	
	p3CurrentIndex++;
	
	if (p3CurrentIndex == 117)
	{
		bbiNext.enabled = NO;
	}
	
	bbiPrevious.enabled = YES;

	// ==============================================================================	
	
	NSDictionary *anElement = (NSDictionary *)[pteSettings.rawElementsArray objectAtIndex:p3CurrentIndex];
	
	p3CurrentElement = [[anElement objectForKey:@"atomicnumber"] intValue];
	labelElement.text = [anElement objectForKey:@"name"];
	
	[self addImagesFromAN:p3CurrentElement];
}


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
