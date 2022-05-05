//
//  RulesViewController.m
//  SquareWordz3
//
//  Created by Paul Freshney on 31/10/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  July 26th 2016

#import "PTViewController.h"
#import "constants.h"
#import "settings.h"
#import "Utility.h"

extern settings *mrSettings;

NSArray *ptData;

NSArray *myElements;

BOOL infoMode = FALSE;
NSInteger lastAN = 0;
int selectMode = 0;
int spectraType = 0;

@implementation PTViewController

@synthesize delegate;

// =======================================================================================================================================
// =======================================================================================================================================
// =======================================================================================================================================

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;    
}

// =======================================================================================================================================
// =======================================================================================================================================
// =======================================================================================================================================

- (void)viewDidLoad {
		
    [super viewDidLoad];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"PTEType" ofType:@"plist"];
	ptData = [[NSArray alloc] initWithContentsOfFile:path];	
	
	myElements = [[NSArray alloc] initWithObjects:  e1,  e2,  e3,  e4,  e5,  e6,  e7,  e8,  e9,  e10, e11, e12, e13, e14, e15, e16, e17, e18, e19, e20,
													e21, e22, e23, e24, e25, e26, e27, e28, e29, e30, e31, e32, e33, e34, e35, e36, e37, e38, e39, e40,
													e41, e42, e43, e44, e45, e46, e47, e48, e49, e50, e51, e52, e53, e54, e55, e56, e57, e58, e59, e60,
													e61, e62, e63, e64, e65, e66, e67, e68, e69, e70, e71, e72, e73, e74, e75, e76, e77, e78, e79, e80,
													e81, e82, e83, e84, e85, e86, e87, e88, e89, e90, e91, e92, e93, e94, e95, e96, e97, e98, e99, e100,
													e101, e102, e103, e104, e105, e106, e107, e108, e109, e110, e111, e112, e113, e114, e115, e116, e117, e118,				  
													nil];
	
	[self buildFromAN:0];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
    
}

- (IBAction) elementSelect: (id)sender; {
	
	[self buildFromAN:[sender tag] - 1];
}

- (void) buildFromAN: (NSInteger) an {
	
	NSDictionary *anElement = (NSDictionary *)[ptData objectAtIndex:an];
	
	eName.text = [NSString stringWithFormat:@"%@ [%@]", [anElement objectForKey:@"name"], [anElement objectForKey:@"symbol"]];
	
	eZ.text     = [NSString stringWithFormat:@"%@", [anElement objectForKey:@"atomicnumber"]];
	eM.text     = [anElement objectForKey:@"atomicweight"];
	eBP.text    = [anElement objectForKey:@"bp"];
	eMP.text    = [anElement objectForKey:@"mp"];
	eState.text = [NSString stringWithFormat:@"%@. %@.", [anElement objectForKey:@"state"], [anElement objectForKey:@"colour"]];
	eENPS.text  = [anElement objectForKey:@"enps"];
    eGroup.text = [Utility getGroupNameFromType:[[anElement objectForKey:@"type"] intValue]];
	
    radioActive.hidden = [Utility isRadioactive:an];
	
    [spectra setImage:[UIImage imageNamed:[Utility getSpectrumImage:an + 1 withSpectrum:spectraType]]];
	
	lastAN = an;
}

- (IBAction) info {
	
	if (infoMode == FALSE)
	{
		eName.text  = @"Name [Symbol]";
		eZ.text     = @"Atomic No.";
		eM.text     = @"Mass g/mol";
		eBP.text    = @"Boiling point";
		eMP.text    = @"Melting point";
		eGroup.text = @"Group";
		eState.text = @"State @ 298K and colour";
		eENPS.text  = @"Electronegativity (Pauling)";
		
		infoMode = TRUE;
	}
	else
	{
		[self buildFromAN: lastAN];
		
		infoMode = FALSE;
	}
}

- (IBAction)done {

	[self.delegate ptViewControllerDidFinish:self];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
}

- (IBAction) selectGraph {
	
	selectMode = 1;	

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Show according to..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Density", @"Electronegativity", @"Melting Point", @"Boiling Point", @"Atomic Radius", @"Atomic Volume", @"Valence Electron Potential", @"Enthalpy of Atomisation", @"Enthalpy of Fusion", @"Enthalpy of Vapourisation", @"Thermal Conductivity", @"Thermal Expansion", NULL];
	
    [actionSheet showInView: self.view];
	
	[actionSheet release];
}

- (IBAction) selectDisplayMode {
	
	selectMode = 0;	
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Display" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Colour by Type", @"Solid at 298K, 1 atm", @"Liquid at 298K, 1 atm", @"Gas at 298K, 1 atm", @"Synthetic", @"Radioactive", NULL];
	
	[actionSheet showInView: self.view];
	
	[actionSheet release];
}

- (void)actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	switch (selectMode)
	{
		case 0:
			if ((buttonIndex >= 0) && (buttonIndex <= 5))
			{
				switch (buttonIndex)
				{
					case 0:
						[self buildDefault];
						break;
					case 1:
						[self buildState:1];
						break;
					case 2:
						[self buildState:3];
						break;
					case 3:
						[self buildState:2];
						break;
					case 4:
						[self buildState:4];
						break;
					case 5:
						[self buildRadioactive];
						break;		
				}
			}
			
			break;
		case 1:
			if ((buttonIndex >= 0) && (buttonIndex <= 10))
			{
				switch (buttonIndex)
				{
					case 0:
						[self buildDensity];
						break;
					case 1:
						[self buildEN];
						break;
					case 2:
						[self buildBP];
						break;
					case 3:
						[self buildMP];
						break;
					case 4:
						[self buildAR];
						break;
					case 5:
						[self buildAV];
						break;
					case 6:
						[self buildVEP];
						break;
					case 7:
						[self buildEOA];
						break;
					case 8:
						[self buildEOF];
						break;
					case 9:
						[self buildTC];
						break;
					case 10:
						[self buildTE];
						break;						
				}
			}		
			
			break;			
	}
}
	
- (void) buildDefault {
		
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		NSDictionary *anElement = (NSDictionary *)[ptData objectAtIndex:t];

		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"type%d.png", [[anElement objectForKey:@"type"] intValue]]] forState:UIControlStateNormal];
	}
}
	
- (void) buildState: (int)elementState {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
        
        [thisButton setBackgroundImage:[UIImage imageNamed:[Utility getStateImage:state[t] withElementState:elementState]] forState:UIControlStateNormal];
	}
}
	
- (void) buildRadioactive {

	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
        if ([Utility isRadioactive:t])
		{
			[thisButton setBackgroundImage:[UIImage imageNamed:@"grad127.png"] forState:UIControlStateNormal];
		}
		else
		{
			[thisButton setBackgroundImage:[UIImage imageNamed:@"grad129.png"] forState:UIControlStateNormal];
		}
	}
}

- (void) buildHuman {
	
}	

- (void) buildDensity {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataDensity[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildEN {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataEN[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildBP {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataBP[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildMP {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataMP[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildAR {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataAR[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildAV {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataAV[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildVEP {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataVEP[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildEOA {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataEOA[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildEOF {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataEOF[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildEOV {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataEOV[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildTC {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataTC[t]]] forState:UIControlStateNormal];
	}
}

- (void) buildTE {
	
	UIButton *thisButton;
	
	for (int t = 0; t < CElementCount; t++)
	{
		thisButton = (UIButton *)[myElements objectAtIndex: t];
		
		[thisButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grad%d.png", dataTE[t]]] forState:UIControlStateNormal];
	}
}

- (IBAction) changeSpectraType {
	
	if (spectraType == 0)
	{
		spectraType = 1;
		[bSpectra setTitle:@"E" forState:(UIControlState)UIControlStateNormal];
	}
	else
	{
		spectraType = 0;
		[bSpectra setTitle:@"A" forState:(UIControlState)UIControlStateNormal];
	}

    [spectra setImage:[UIImage imageNamed:[Utility getSpectrumImage:lastAN + 1 withSpectrum:spectraType]]];
}

- (IBAction) playSpeech {
 
    [Utility playSpeech:lastAN + 1];
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
	
	[ptData release];
	[myElements release];
}


@end
