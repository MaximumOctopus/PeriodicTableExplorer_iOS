//
//  RulesViewController.h
//  SquareWordz3
//
//  Created by Paul Freshney on 31/10/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h> 

@protocol PTViewControllerDelegate;


@interface PTViewController : UIViewController <UIActionSheetDelegate> {
	
	id <PTViewControllerDelegate> delegate;
	
	IBOutlet UIButton *info;
    IBOutlet UIButton *speech;
	
	IBOutlet UILabel *eName;
	IBOutlet UILabel *eZ;
	IBOutlet UILabel *eM;
	IBOutlet UILabel *eBP;
	IBOutlet UILabel *eMP;
	IBOutlet UILabel *eGroup;
	IBOutlet UILabel *eState;
	IBOutlet UILabel *eENPS;
	
	IBOutlet UIButton *bSpectra;
	
	IBOutlet UIButton *e1;	IBOutlet UIButton *e2;	IBOutlet UIButton *e3;	IBOutlet UIButton *e4;	IBOutlet UIButton *e5;
	IBOutlet UIButton *e6;	IBOutlet UIButton *e7;	IBOutlet UIButton *e8;	IBOutlet UIButton *e9;	IBOutlet UIButton *e10;

	IBOutlet UIButton *e11;	IBOutlet UIButton *e12;	IBOutlet UIButton *e13;	IBOutlet UIButton *e14;	IBOutlet UIButton *e15;
	IBOutlet UIButton *e16;	IBOutlet UIButton *e17;	IBOutlet UIButton *e18;	IBOutlet UIButton *e19;	IBOutlet UIButton *e20;

	IBOutlet UIButton *e21;	IBOutlet UIButton *e22;	IBOutlet UIButton *e23;	IBOutlet UIButton *e24;	IBOutlet UIButton *e25;
	IBOutlet UIButton *e26;	IBOutlet UIButton *e27;	IBOutlet UIButton *e28;	IBOutlet UIButton *e29;	IBOutlet UIButton *e30;

	IBOutlet UIButton *e31;	IBOutlet UIButton *e32;	IBOutlet UIButton *e33;	IBOutlet UIButton *e34;	IBOutlet UIButton *e35;
	IBOutlet UIButton *e36;	IBOutlet UIButton *e37;	IBOutlet UIButton *e38;	IBOutlet UIButton *e39;	IBOutlet UIButton *e40;

	IBOutlet UIButton *e41;	IBOutlet UIButton *e42;	IBOutlet UIButton *e43;	IBOutlet UIButton *e44;	IBOutlet UIButton *e45;
	IBOutlet UIButton *e46;	IBOutlet UIButton *e47;	IBOutlet UIButton *e48;	IBOutlet UIButton *e49;	IBOutlet UIButton *e50;

	IBOutlet UIButton *e51;	IBOutlet UIButton *e52;	IBOutlet UIButton *e53;	IBOutlet UIButton *e54;	IBOutlet UIButton *e55;
	IBOutlet UIButton *e56;	IBOutlet UIButton *e57;	IBOutlet UIButton *e58;	IBOutlet UIButton *e59;	IBOutlet UIButton *e60;

	IBOutlet UIButton *e61;	IBOutlet UIButton *e62;	IBOutlet UIButton *e63;	IBOutlet UIButton *e64;	IBOutlet UIButton *e65;
	IBOutlet UIButton *e66;	IBOutlet UIButton *e67;	IBOutlet UIButton *e68;	IBOutlet UIButton *e69;	IBOutlet UIButton *e70;

	IBOutlet UIButton *e71;	IBOutlet UIButton *e72;	IBOutlet UIButton *e73;	IBOutlet UIButton *e74;	IBOutlet UIButton *e75;
	IBOutlet UIButton *e76;	IBOutlet UIButton *e77;	IBOutlet UIButton *e78;	IBOutlet UIButton *e79;	IBOutlet UIButton *e80;

	IBOutlet UIButton *e81;	IBOutlet UIButton *e82;	IBOutlet UIButton *e83;	IBOutlet UIButton *e84;	IBOutlet UIButton *e85;
	IBOutlet UIButton *e86;	IBOutlet UIButton *e87;	IBOutlet UIButton *e88;	IBOutlet UIButton *e89;	IBOutlet UIButton *e90;

	IBOutlet UIButton *e91;	IBOutlet UIButton *e92;	IBOutlet UIButton *e93;	IBOutlet UIButton *e94;	IBOutlet UIButton *e95;
	IBOutlet UIButton *e96;	IBOutlet UIButton *e97;	IBOutlet UIButton *e98;	IBOutlet UIButton *e99;	IBOutlet UIButton *e100;

	IBOutlet UIButton *e101;	IBOutlet UIButton *e102;	IBOutlet UIButton *e103;	IBOutlet UIButton *e104;	IBOutlet UIButton *e105;
	IBOutlet UIButton *e106;	IBOutlet UIButton *e107;	IBOutlet UIButton *e108;	IBOutlet UIButton *e109;	IBOutlet UIButton *e110;

	IBOutlet UIButton *e111;	IBOutlet UIButton *e112;	IBOutlet UIButton *e113;	IBOutlet UIButton *e114;	IBOutlet UIButton *e115;
	IBOutlet UIButton *e116;	IBOutlet UIButton *e117;	IBOutlet UIButton *e118;
		
	IBOutlet UIImageView *radioActive;
	
	IBOutlet UIImageView *spectra;
}

@property (nonatomic, assign) id <PTViewControllerDelegate> delegate;

- (IBAction) done;

- (IBAction) info;

- (IBAction) selectGraph;

- (void) buildDensity;

- (void) buildEN;

- (void) buildBP;

- (void) buildMP;

- (void) buildAR;

- (void) buildAV;

- (void) buildVEP;

- (void) buildEOA;

- (void) buildEOF;

- (void) buildEOV;

- (void) buildTC;

- (void) buildTE;

- (IBAction) selectDisplayMode;

- (IBAction) changeSpectraType;

- (IBAction) playSpeech;

- (void) buildDefault;

- (void) buildState: (int)elementState;

- (void) buildRadioactive;

- (void) buildHuman;

- (IBAction) elementSelect: (id)sender;

- (void) buildFromAN: (NSInteger) an;

@end


@protocol PTViewControllerDelegate

- (void) ptViewControllerDidFinish:(PTViewController *)controller;

@end