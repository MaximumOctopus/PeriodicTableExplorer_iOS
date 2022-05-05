//
//  settings.h
//  PTE
//
//  Created by Paul Freshney on 12/02/2010.
//  Copyright 2014 freshney.org All rights reserved.
//  April 18th 2016

#import <Foundation/Foundation.h>


@interface settings : NSObject {
	
	NSInteger sCurrentElementAN, sSearchScope, tSelectedRow;
	
	NSInteger sP2Category, sP2ElementAN;
	
	NSInteger sSortOrder;
	
	NSString *sCurrentElementName;
	
	NSArray *rawElementsArray;
	NSArray *anNameList;
}

@property NSInteger sSortOrder, sCurrentElementAN, sSearchScope, sP2Category, sP2ElementAN, tSelectedRow;

@property (retain) NSString *sCurrentElementName;

@property (retain) NSArray *rawElementsArray;

@property (retain) NSArray *anNameList;

@end