//
//  HTMLUtility.h
//  PTE_Mac
//
//  Created by Paul Freshney on 19/07/2017.
//
//

@interface HTMLUtility : NSObject

+ (NSString *) getCalcErrorPage;
+ (NSString *) getDivBlueCubeSingle;
+ (NSString *) getDivBlueCubeDouble;
+ (NSString *) getDivCAS;
+ (NSString *) getDivMolecularMass;
+ (NSString *) getDocHeader;
+ (NSString *) getFoundResultsFor:(NSInteger)searchIndex;
+ (NSString *) getIndentItalic;
+ (NSString *) getNaturalOccurenceHeader;
+ (NSString *) getMassOutput;
+ (NSString *) getTypeClass:(NSInteger)type;

@end
