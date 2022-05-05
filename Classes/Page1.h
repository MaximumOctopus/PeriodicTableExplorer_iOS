//
//  Page1.h
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h> 
#import "RulesViewController.h"
#import "PTViewController.h"
#import "OTDViewController.h"
#import "DataViewController.h"


@interface Page1 : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, DataViewControllerDelegate, RulesViewControllerDelegate, OTDViewControllerDelegate, PTViewControllerDelegate> {
    
	IBOutlet UITableView *tableViewMain;
	
	IBOutlet UIToolbar *p1Toolbar;
		
	IBOutlet UIBarButtonItem *bbiMore;
	IBOutlet UIBarButtonItem *bbiHelp;
	IBOutlet UIBarButtonItem *bbiShowPT;
    IBOutlet UIBarButtonItem *speech;
    
    NSInteger selectedRow;
}

- (void) orderBySelect:(NSInteger) index;

- (void) orderByName;
- (void) orderByAtomicNumber;
- (IBAction) orderByAtomicRadius;
- (void) orderByMeltingPoint;
- (void) orderByBoilingPoint;
- (void) orderByDiscoveryDate;
- (void) orderByASun;
- (void) orderByAUniverse;
- (void) orderByAEarthsCrust;
- (void) orderByEOA;
- (void) orderByEOF;
- (void) orderByEOV;
- (void) orderByHC;
- (void) orderByTC;
- (void) orderByTE;
- (void) orderByVEP;
- (IBAction) orderByNameMore;

- (IBAction) showPT;

- (IBAction) showOnThisDay;

- (IBAction) help;

- (IBAction) playSpeech;

@end
