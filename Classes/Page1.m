//
//  Page1.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

#import "Page1.h"
#import "constants.h"
#import "settings.h"
#import "Utility.h"

extern settings *pteSettings;

@implementation Page1

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
 		
    [super viewDidLoad];
    
    selectedRow = 0;
	
    [self orderBySelect:pteSettings.sSortOrder];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

// ==========================================================================================================================
#pragma mark TableView Callbacks

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return CElementCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    if (!((pteSettings.sSortOrder >= 0) && (pteSettings.sSortOrder <= 18)))
    {
        pteSettings.sSortOrder = 0;
    }
    
    [bbiMore setTitle:[Utility getTitle:pteSettings.sSortOrder]];
    
    return [Utility getTableHeader:pteSettings.sSortOrder];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	
	NSDictionary *anElement = (NSDictionary *)[pteSettings.rawElementsArray objectAtIndex:indexPath.row];
	
	NSString *xName = [anElement objectForKey:@"name"];
	
	UIImageView *uiv = cell.imageView;
	
	UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [anElement objectForKey:@"atomicnumber"]]];
	
	[uiv initWithImage:image];
	
	cell.textLabel.text = [xName stringByAppendingFormat:@" ( %@ )", [anElement objectForKey:@"atomicnumber"]];
	
	switch (pteSettings.sSortOrder)
	{
		case 0:
		case 1:
			cell.detailTextLabel.text = [anElement objectForKey:@"group"];
			break;
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		case 17:
		case 18:
			cell.detailTextLabel.text = [anElement objectForKey:@"data"];
			break;
	}
		
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSDictionary *anElement = (NSDictionary *)[pteSettings.rawElementsArray objectAtIndex:indexPath.row];
		
	pteSettings.sCurrentElementAN = [[anElement objectForKey:@"atomicnumber"] intValue];
	pteSettings.sP2ElementAN = [[anElement objectForKey:@"atomicnumber"] intValue];
	
	pteSettings.sCurrentElementName = [anElement objectForKey:@"name"];
	
	pteSettings.tSelectedRow = indexPath.row;
	
    // only flip once the user has selected this twice, once to select.. again to flip
    // i think this improves usability!
    if (indexPath.row == selectedRow)
    {
        DataViewController *controller = [[DataViewController alloc] initWithNibName:@"DataViewController" bundle:nil];
        controller.delegate = self;
	
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:nil];
	
        [controller release];
    }
    else
    {
        selectedRow = indexPath.row;
    }
}


- (void) orderByName {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
	
    pteSettings.sSortOrder = 0;
    
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
	
	[tableViewMain scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void) orderByASun {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 8;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByAUniverse {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 9;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByAEarthsCrust {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 10;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByAtomicNumber {
	
	[tableViewMain beginUpdates];

	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 1;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
	
	[tableViewMain scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

}

- (void) orderByAtomicRadius {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 7;
	
    pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
	
	[tableViewMain scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
	
}

- (void) orderByMeltingPoint {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 2;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByBoilingPoint {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
	
    pteSettings.sSortOrder = 3;
    
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByDiscoveryDate {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 4;
	
    pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByElectronegativity {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 5;
	
    pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByAtomicVolume {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 6;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByEOA {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
	
    pteSettings.sSortOrder = 11;
    
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByEOF {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
	
    pteSettings.sSortOrder = 12;
    
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByEOV {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];

    pteSettings.sSortOrder = 13;
    
    pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];

	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByHC {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 14;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByTC {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
	
    pteSettings.sSortOrder = 15;
    
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByTE {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
	
    pteSettings.sSortOrder = 16;
    
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderByVEP {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
    
    pteSettings.sSortOrder = 18;
	
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (void) orderBySOS {
	
	[tableViewMain beginUpdates];
	
	[pteSettings.rawElementsArray release];
	
    pteSettings.sSortOrder = 17;
    
	pteSettings.rawElementsArray = [[NSArray alloc] initWithContentsOfFile:[Utility getPLIST:pteSettings.sSortOrder]];
	
	[tableViewMain endUpdates];
	
	[tableViewMain reloadData];
}

- (IBAction) orderByNameMore {
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"List Order" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Name", @"Atomic Number", @"Melting Point", @"Boiling Point", @"Discovery Date", @"Electronegativity", @"Atomic Volume", @"Atomic Radius", @"Abundance: Sun", @"Abundance: Universe", @"Abundance: Earth's Crust", @"Enthalpy of Atomisation", @"Enthalpy of Fusion", @"Enthalpy of Vapourisation", @"Heat Capacity", @"Thermal Conductivity", @"Thermal Expansion", @"Speed of Sound", @"Valence Electron Potential", NULL];
	
	[actionSheet showFromToolbar: p1Toolbar];
	
	[actionSheet release];
}

- (void)actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    [self orderBySelect: buttonIndex];
}

- (void) orderBySelect:(NSInteger) index {
    
    pteSettings.sSortOrder = index;
    
    switch (index)
    {
        case 0:
            [self orderByName];
            break;
        case 1:
            [self orderByAtomicNumber];
            break;
        case 2:
            [self orderByMeltingPoint];
            break;
        case 3:
            [self orderByBoilingPoint];
            break;
        case 4:
            [self orderByDiscoveryDate];
            break;
        case 5:
            [self orderByElectronegativity];
            break;
        case 6:
            [self orderByAtomicVolume];
            break;
        case 7:
            [self orderByAtomicRadius];
            break;
        case 8:
            [self orderByASun];
            break;
        case 9:
            [self orderByAUniverse];
            break;
        case 10:
            [self orderByAEarthsCrust];
            break;
        case 11:
            [self orderByEOA];
            break;
        case 12:
            [self orderByEOF];
            break;
        case 13:
            [self orderByEOV];
            break;
        case 14:
            [self orderByHC];
            break;
        case 15:
            [self orderByTC];
            break;
        case 16:
            [self orderByTE];
            break;
        case 17:
            [self orderBySOS];
            break;
        case 18:
            [self orderByVEP];
            break;				
    }
    
    [tableViewMain scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setInteger:pteSettings.sSortOrder forKey:@"sortorder"];
    
    [prefs synchronize];
}


- (void) rulesViewControllerDidFinish: (RulesViewController *)controller {
    
	[[controller presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void) ptViewControllerDidFinish: (PTViewController *)controller {
    
    [[controller presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void) otdViewControllerDidFinish: (OTDViewController *)controller {
    
    [[controller presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void) dataViewControllerDidFinish: (DataViewController *)controller {
    
    [[controller presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) showPT {
	
	PTViewController *controller = [[PTViewController alloc] initWithNibName:@"PTView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:controller animated:YES completion:nil];
	
	[controller release];
}

- (IBAction) showOnThisDay {

	OTDViewController *controller = [[OTDViewController alloc] initWithNibName:@"OTDView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:controller animated:YES completion:nil];
	
	[controller release];
	
} 

- (IBAction) help {
	
	RulesViewController *controller = [[RulesViewController alloc] initWithNibName:@"RulesView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:controller animated:YES completion:nil];
	
	[controller release];
}

- (IBAction) playSpeech {
    
    [Utility playSpeech:pteSettings.sCurrentElementAN];
}

// ==========================================================================================================================
#pragma mark View Shutdown Routines

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)dealloc {
	
	//[elementList release];
	//
    [super dealloc];
}


@end
