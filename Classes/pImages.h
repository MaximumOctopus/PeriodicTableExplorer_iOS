//
//  Page3.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2010 freshney.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyScrollView;

@interface Page3 : UIViewController <UIActionSheetDelegate> {

	IBOutlet UIScrollView *scrollView;
	
	IBOutlet UIBarButtonItem *bbiHelp;
	IBOutlet UIBarButtonItem *bbiPrevious;
	IBOutlet UIBarButtonItem *bbiNext;
	
	IBOutlet UILabel *labelElement;
}

@property (nonatomic, retain) UIView *scrollView;

- (void) addImagesFromAN:(NSInteger) atomicNumber;

- (void) updateImages;

- (IBAction) openInfo;

- (IBAction) previousElement;

- (IBAction) nextElement;

@end