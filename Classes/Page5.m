//
//  Page5.m
//  PTE
//
//  Created by Paul Freshney on 07/02/2010.
//  Copyright 2014 freshney.org. All rights reserved.
//  April 18th 2016

//   PTE HTML Word Index, pteIndex.db
//   'CREATE TABLE pteIndex ([pteWord] VARCHAR, [pteLink] VARCHAR, [pteTitle] VARCHAR);'

//   PTE Constants data, pteConstants.db
//   'CREATE TABLE pteContants ([pteName] VARCHAR PRIMARY KEY, [pteSymbol] VARCHAR, [pteValue] VARCHAR, [pteUnits] VARCHAR, [pteUncer] VARCHAR);'

//   PTE Compounds data, pteCompounds.db
//   'CREATE TABLE pteCompound ([pteName] VARCHAR, [pteFormulaF] VARCHAR, [pteFormula] VARCHAR, [pteCAS] VARCHAR, [pteOther1] VARCHAR, [pteOther2] VARCHAR, [pteOther3] VARCHAR, [pteOther4] VARCHAR, [pteOther5] VARCHAR, [pteOther6] VARCHAR);'

//   PTE Equations data, pteEquations.db
//   'CREATE TABLE pteEquation ([pteName] VARCHAR, [pteTitle] VARCHAR);'

#import "Page5.h"
#import <sqlite3.h>
#import "constants.h"
#import "settings.h"
#import "HTMLUtility.h"
#import "SQLUtility.h"
#import "Utility.h"


extern settings *pteSettings;

int AtSearchPage;

NSArray *massData;

@implementation Page5

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
	
	AtSearchPage = 0;
	
	elementSymbols = [[NSArray alloc] initWithObjects: @"H", @"He", @"Li", @"Be", @"B", @"C", @"N", @"O", @"F", @"Ne", 
													   @"Na", @"Mg", @"Al", @"Si", @"P", @"S", @"Cl", @"Ar", @"K", @"Ca", 
													   @"Sc", @"Ti", @"V", @"Cr", @"Mn", @"Fe", @"Co", @"Ni", @"Cu", @"Zn", 
													   @"Ga", @"Ge", @"As", @"Se", @"Br", @"Kr", @"Rb", @"Sr", @"Y", @"Zr",
													   @"Nb", @"Mo", @"Tc", @"Ru", @"Rh", @"Pd", @"Ag", @"Cd", @"In", @"Sn",
													   @"Sb", @"Te", @"I", @"Xe", @"Cs", @"Ba", @"La", @"Ce", @"Pr", @"Nd",
													   @"Pm", @"Sm", @"Eu", @"Gd", @"Tb", @"Dy", @"Ho", @"Er", @"Tm", @"Yb",
													   @"Lu", @"Hf", @"Ta", @"W", @"Re", @"Os", @"Ir", @"Pt", @"Au", @"Hg",
													   @"Tl", @"Pb", @"Bi", @"Po", @"At", @"Rn", @"Fr", @"Ra", @"Ac", @"Th",
													   @"Pa", @"U", @"Np", @"Pu", @"Am", @"Cm", @"Bk", @"Cf", @"Es", @"Fm",
													   @"Md", @"No", @"Lr", @"Rf", @"Db", @"Sg", @"Bh", @"Hs", @"Mt", @"Ds",
													   @"Rg", @"Cn", @"Uut", @"Uuq", @"Uup", @"Uuh", @"Uus", @"Uuo",
													   nil];

	switch (pteSettings.sSearchScope)
	{
		case 0:
			labelSearch.text = @"Constants";
			break;
		case 1:
			labelSearch.text = @"Compounds";
			break;
		case 2:
			labelSearch.text = @"Equations";
			break;
		case 3:
			labelSearch.text = @"Page Content";
			break;			
		case 4:
			labelSearch.text = @"Molecular calculator";
			break;
	}
	
	NSString *path2 = [[NSBundle mainBundle] pathForResource:@"awisolist" ofType:@"plist"];
	massData = [[NSArray alloc] initWithContentsOfFile:path2];	

	[self openSearchPage];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void) openSearchPage {

	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"htm"];

	NSString *HTMLData = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

	[sWebView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath:filePath]];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	
	[self waitAnimOn];
	
	return YES;
}

- (void) waitAnimOn {
	
	[pleaseWait startAnimating];
	
	swTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector (waitAnimOff) userInfo:NULL repeats:NO];
	
}

- (void) waitAnimOff {
	
	[self doSearch];	
	
	[pleaseWait stopAnimating];
	
	[swTimer invalidate];
	
}

- (void) webViewDidFinishLoad:(UIWebView *)wv {

	bbiNext.enabled = wv.canGoForward;
	
	if (AtSearchPage == 0)
	{
		bbiPrevious.enabled = YES;
	}
	else
	{
		bbiPrevious.enabled = NO;
		
		AtSearchPage = 0;
	}

}

- (int) SymbolToAn: (NSString *)symbol {
	
	int anIndex = 999;
	int symbolListIndex = 0;
	
	while ((anIndex == 999) && (symbolListIndex < CElementCount))
	{
		if ([symbol caseInsensitiveCompare:(NSString *)[elementSymbols objectAtIndex: symbolListIndex]] == NSOrderedSame)
		{
			anIndex = symbolListIndex;
		}
		
		symbolListIndex++;
	}
	
	if (anIndex == 999)
	{
		anIndex = 0;
	}
	
	return anIndex;
}

- (void) doSearch {
		
	NSString *userStuff = userEntry.text;	
	
	if (([userStuff caseInsensitiveCompare:@"help"] == 0))
	{
		[self openSearchPage];
	}
	else
	{
		const char *pathConstants = [[[NSBundle mainBundle] pathForResource:@"pteConstants" ofType:@"db"] UTF8String];
		const char *pathCompounds = [[[NSBundle mainBundle] pathForResource:@"pteCompounds" ofType:@"db"] UTF8String];
		const char *pathEquations = [[[NSBundle mainBundle] pathForResource:@"pteEquations" ofType:@"db"] UTF8String];
		const char *pathIndex = [[[NSBundle mainBundle] pathForResource:@"pteIndex" ofType:@"db"] UTF8String];
	
		int dbrc;
	
		switch (pteSettings.sSearchScope)
		{
			case 0:
				dbrc = sqlite3_open(pathConstants, &db);
				break;
			
			case 1:
				dbrc = sqlite3_open(pathCompounds, &db);
				break;
			
			case 2:
				dbrc = sqlite3_open(pathEquations, &db);
				break;
				
			case 3:
				dbrc = sqlite3_open(pathIndex, &db);
				break;			
		}

		if ((dbrc != SQLITE_OK) && (pteSettings.sSearchScope != 4))
		{
			// ERROR HANDLING CODE HERE :)
		}
		else
		{
			sqlite3_stmt *dbps;

			NSString *HTMLData = [HTMLUtility getDocHeader];
		
			NSString *queryNS;
		
			int resultCount = 0;
		
			if (pteSettings.sSearchScope != 4)
			{
                queryNS = [SQLUtility getSQLFind:pteSettings.sSearchScope with:userEntry.text];
                
				const char *query = [queryNS UTF8String];
				dbrc = sqlite3_prepare_v2(db, query, -1, &dbps, NULL );
			}

			switch (pteSettings.sSearchScope)
			{
				case 0: // CONSTANTS search
				{
				
					while (sqlite3_step(dbps) == SQLITE_ROW)
					{
						resultCount++;
					
						NSString *pteName   = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)];
						NSString *pteSymbol = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 1)];
						NSString *pteValue  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 2)];
						NSString *pteUnits  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 3)];
						NSString *pteUncer  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 4)];
					
						HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getDivBlueCubeDouble], pteName, pteValue, pteUnits]];
					
						if ([pteUncer length] > 0)
						{
							HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:@"<br/>&nbsp;&nbsp;&nbsp;uncertainty: %@<br/>", pteUncer]];
						}
					
						[pteUncer release];
						[pteUnits release];
						[pteValue release];
						[pteSymbol release];
						[pteName release];
					}
				
					NSString *header = [NSString stringWithFormat:[HTMLUtility getFoundResultsFor:0], resultCount, userEntry.text];
				
					HTMLData = [header stringByAppendingString: HTMLData];
		
					break;
				}
				
				case 1: // COMPOUNDS search
				{
					NSString *pteName = @"";
					NSString *pteFormulaF = @"";
					NSString *cas = @"";
					NSString *other1 = @"";
					NSString *other2 = @"";
					NSString *other3 = @"";
					NSString *other4 = @"";
					NSString *other5 = @"";
					NSString *other6 = @"";
				
					while (sqlite3_step(dbps) == SQLITE_ROW)
					{
						resultCount++;
						  
						pteName     = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 0)];
						pteFormulaF = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 1)];
						cas         = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 3)];
						other1      = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 4)];
						other2      = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 5)];
						other3      = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 6)];
						other4      = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 7)];
						other5      = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 8)];
						other6      = [NSString stringWithUTF8String:(char *)sqlite3_column_text(dbps, 9)];
		
						HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getDivBlueCubeSingle], pteName, pteFormulaF]];
					
						if ([cas length] > 0)
						{
							HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getDivCAS], cas]];
						}
					
						if ([other1 length] > 0)
						{
							HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getIndentItalic], other1]];
					
							if ([other2 length] > 0)
							{
								HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getIndentItalic], other2]];
							}
					
							if ([other3 length] > 0)
							{
								HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getIndentItalic], other3]];
							}
					
							if ([other4 length] > 0)
							{
								HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getIndentItalic], other4]];
							}

							if ([other5 length] > 0)
							{
                                HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getIndentItalic], other5]];
							}

							if ([other6 length] > 0)
							{
								HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getIndentItalic], other6]];
							}
						}
					
					}

					NSString *header = [NSString stringWithFormat:[HTMLUtility getFoundResultsFor:1], resultCount, userEntry.text];
				
					HTMLData = [header stringByAppendingString: HTMLData];
				
					break;
				}
				
				case 2: // EQUATIONS search
				{				
					while (sqlite3_step(dbps) == SQLITE_ROW)
					{
						resultCount++;
						
						NSString *pteLink  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)];
						NSString *pteTitle = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 1)];
												
						HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:@"<br/><img src=\"bluecube.gif\"> <a class=\"blink\" href=\"%@.htm\">%@</a>", pteLink, pteTitle]];
						
						[pteTitle release];
						[pteLink release];
					}
					
					NSString *header = [NSString stringWithFormat:[HTMLUtility getFoundResultsFor:2], resultCount, userEntry.text];
					
					HTMLData = [header stringByAppendingString: HTMLData];
					
					break;
				}
					
				case 3: // PTE Content Search
				{
				
					NSString *currentWord = @"";
				
					while (sqlite3_step(dbps) == SQLITE_ROW)
					{
						resultCount++;
						
						NSString *pteWord  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)];
						NSString *pteLink  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 1)];
						NSString *pteTitle = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 2)];
						int pteType        = sqlite3_column_int(dbps, 3);
											
						if (![currentWord isEqualToString:pteWord])
						{
							HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:@"<br/><img src=\"bluecube.gif\"> <b class=\"JF\">%@</b><br/>", pteWord]];						
						
							currentWord = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)];
						}
                        
                        HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:@"&nbsp;&nbsp;&nbsp;<a class=\"%@\" href=\"%@\">%@</a><br/>", [HTMLUtility getTypeClass:pteType], pteLink, pteTitle]];
					
						[pteTitle release];
						[pteLink release];
						[pteWord release];
					}
				
					NSString *header = [NSString stringWithFormat:[HTMLUtility getFoundResultsFor:3], resultCount, userEntry.text];
				
					HTMLData = [header stringByAppendingString: HTMLData];
					
					break;
				}
					
				case 4:
				{
					
					int ElementCount[CElementCount];
					int lastQuantity = 1;
					int QuantityModifier = 1;
					float am = 0.0;
					NSString *tempStore = @"";
					NSString *quantity = @"";
					NSString *cxc = @"";
					
					NSCharacterSet *setOfLetters  = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
					NSCharacterSet *setOfULetters = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
					NSCharacterSet *setOfNumbers  = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
					
					NSMutableArray *qmList = [[NSMutableArray alloc] initWithCapacity:6];
					[qmList addObject:@"1"];
					
					for (int t = 0; t < CElementCount; t++)
					{
						ElementCount[t] = 0;
					}
								
					for (NSInteger t = [userEntry.text length] - 1; t >= 0; t--)
					{
						cxc = [userEntry.text substringWithRange:NSMakeRange(t,1)];
						
						tempStore = [NSString stringWithFormat:@"%@%@", cxc, tempStore];
					
						NSRange letterRange  = [cxc rangeOfCharacterFromSet:setOfLetters];
						NSRange letterURange = [cxc rangeOfCharacterFromSet:setOfULetters];
						NSRange numberRange  = [cxc rangeOfCharacterFromSet:setOfNumbers];
						
						if (letterRange.location != NSNotFound)
						{

							if (letterURange.location != NSNotFound)
							{
								ElementCount[[self SymbolToAn: tempStore]] = ElementCount[[self SymbolToAn: tempStore]] + (lastQuantity * QuantityModifier);
					
								tempStore    = @"";
								quantity     = @"";
								lastQuantity = 1;
							}
						}
						else if (numberRange.location != NSNotFound)
						{
							quantity = [NSString stringWithFormat:@"%@%@", tempStore, quantity];
							
							tempStore = @"";
					
							lastQuantity = [quantity intValue];
						}
						else if (([cxc isEqualToString:@")"]) || ([cxc isEqualToString:@"]"]))
						{
							quantity = @"";
					
							QuantityModifier = QuantityModifier * lastQuantity;
							
							[qmList addObject:[NSString stringWithFormat:@"%d", QuantityModifier]];
					
							lastQuantity = 1;
							
							tempStore = @"";
						}
						else if (([cxc isEqualToString:@"("]) || ([cxc isEqualToString:@"["]))
						{
							[qmList removeLastObject];
							
							NSString *lastQM = (NSString *)[qmList objectAtIndex: [qmList count]-1];
							
							QuantityModifier = [lastQM intValue];
							
							tempStore = @"";
						}
					}
					
					if (![tempStore isEqualToString: @""])
					{
						ElementCount[[self SymbolToAn: tempStore]] = ElementCount[[self SymbolToAn: tempStore]] + 1;
					}
					
					// ===============================================================================================					
					// == stage 1: calculate atomic mass now =========================================================
					// ===============================================================================================
					
					for (int t = 0; t < CElementCount; t++)
					{
						if (ElementCount[t] != 0)
						{
							am = am + (ElementCount[t] * atomicMass[t]);
						}
					}
					
					HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:@"<br/>&nbsp;&nbsp;&nbsp;Total Mass: <b>%f</b> u<br/><br/>", am]];
					
					// ===============================================================================================					
					// == stage 2: calculate % weight by element =====================================================
					// ===============================================================================================
					
					float pam = 0.0;
					float tam = 0.0;
					
					for (int t = 0; t < CElementCount; t++)
					{
						if (ElementCount[t] != 0)
						{
							pam = ((ElementCount[t] * atomicMass[t]) / am) * 100;
							tam = ElementCount[t] * atomicMass[t];
					
							HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:[HTMLUtility getMassOutput], (NSString *)[elementSymbols objectAtIndex: t], ElementCount[t], pam, tam]];
						}
					}
					
					// ===============================================================================================
					// == now lets add subscripts to the formula =====================================================
					// ===============================================================================================
										
					int superMode = 0;
					int subMode = 0;
					
					NSString *fs = @"";
					
					for (int t = 0; t < [userEntry.text length]; t++)
					{
						
						NSRange numberRange = [[userEntry.text substringWithRange:NSMakeRange(t,1)] rangeOfCharacterFromSet:setOfNumbers];
						
						if (numberRange.location != NSNotFound)
						{
						
							if (superMode == 1)
							{
								fs = [fs stringByAppendingString:[userEntry.text substringWithRange:NSMakeRange(t,1)]];
							}
							else
							{
								if (t == 0)/* or (formula[t-1]='.') then*/
								{
									if (subMode == 1)
									{
										fs = [fs stringByAppendingString: @"</sub>"];
										 
										subMode = 0;
									}
					
									fs = [fs stringByAppendingString:[userEntry.text substringWithRange:NSMakeRange(t,1)]];
								}
								else
								{
									if (subMode == 1)
									{
										fs = [fs stringByAppendingString:[userEntry.text substringWithRange:NSMakeRange(t,1)]];
									}
									else
									{
										fs = [fs stringByAppendingString: @"<sub>"];
										fs = [fs stringByAppendingString:[userEntry.text substringWithRange:NSMakeRange(t,1)]];
									}
					
									subMode  = 1;
								}
							}
						}
						else
						{
							if (subMode == 1)
							{
								fs = [fs stringByAppendingString: @"</sub>"];

								subMode = 0;
							}
					
							fs = [fs stringByAppendingString:[userEntry.text substringWithRange:NSMakeRange(t,1)]];
						}
					}
					
					if (subMode == 1)
					{
						fs = [fs stringByAppendingString: @"</sub>"];
					}
					
                    for (int t = 0; t < CElementCount; t++)
                    {
                        if (ElementCount[t] != 0)
                        {
                            NSDictionary *anElement = (NSDictionary *)[massData objectAtIndex:t];
                        
                            int massIsoCounts = [[anElement objectForKey:@"atomicicoint"] intValue];
									
                            HTMLData = [HTMLData stringByAppendingString:[HTMLUtility getNaturalOccurenceHeader]];
									
                            for (int z = 1; z <= massIsoCounts; z++)
                            {
                                HTMLData = [HTMLData stringByAppendingString: [NSString stringWithFormat:@"<tr class=\"JZ\"><td>&nbsp;</td><td>%@</td><td>%@%%</td><td>%@</td></tr>", [anElement objectForKey:[NSString stringWithFormat:@"iname%d", z]], [anElement objectForKey:[NSString stringWithFormat:@"ip%d", z]], [anElement objectForKey:[NSString stringWithFormat:@"iw%d", z]]]];
                            }
									
                            HTMLData = [HTMLData stringByAppendingString:@"</table>"];
                        }
                    }
										
					// ===============================================================================================					
					// ===============================================================================================
					
					NSString *header = [NSString stringWithFormat:[HTMLUtility getDivMolecularMass], fs];
					
					HTMLData = [header stringByAppendingString: HTMLData];
					
					[qmList release];
					
					break;
				}
			}
			
			AtSearchPage = 1;
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			NSString *tempDocsPath = [documentsDirectory stringByAppendingPathComponent:@"PTESearch.htm"];
						
			
			[HTMLData writeToFile:tempDocsPath atomically:NO encoding:NSUTF8StringEncoding error:NULL];		
			
			NSString *fileName = [[NSBundle mainBundle] pathForResource:@"1_1" ofType:@"jpg"];
			[sWebView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath:fileName]];
		
			sqlite3_close(db);
		}
	}
}

- (IBAction) searchScope {
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Search Scope" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Constants", @"Compounds", @"Equations", @"Page Content", @"Molecular calculator", NULL];
	
	[actionSheet showFromToolbar: p5Toolbar];
	
	[actionSheet release];
}

- (void)actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if ((buttonIndex >= 0) && (buttonIndex <= 4))
	{
		pteSettings.sSearchScope = buttonIndex;
        
        labelSearch.text = [Utility getSearchScopeText:pteSettings.sSearchScope];
	}
}

- (IBAction) previousSearch {
	
	if ([sWebView canGoBack])
	{
		[sWebView goBack];
	}
	else
	{
		AtSearchPage = 1;
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *tempDocsPath = [documentsDirectory stringByAppendingPathComponent:@"PTESearch.htm"];
		
		NSString *HTMLData = [NSString stringWithContentsOfFile:tempDocsPath encoding:NSUTF8StringEncoding error:nil];
		
		NSString *fileName = [[NSBundle mainBundle] pathForResource:@"1_1" ofType:@"jpg"];
		[sWebView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath:fileName]];
	}

}

- (IBAction) nextSearch {
	
	[sWebView goForward];
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

- (void)dealloc {
	
	[elementSymbols release];
	
    [super dealloc];
}


@end
