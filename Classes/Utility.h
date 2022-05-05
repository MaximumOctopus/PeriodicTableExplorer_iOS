//
//  utility.h
//  PTE_Mac
//
//  Created by Paul Freshney on 12/07/2017.
//
//

#import <AVFoundation/AVFoundation.h> 

@interface Utility : NSObject

+ (NSString *) getAboutBackground:(NSInteger)screenWidth withHeight:(NSInteger)screenHeight;

+ (NSString *) getFilePathFromCategory:(NSInteger)category withElementAN:(NSInteger)an;
+ (int) getElementANFromPage:(NSString *)url;
+ (NSString *) getOnThisDayFileName;
+ (NSString *) getGroupNameFromType:(NSInteger)type;
+ (NSString *) getPLIST:(NSInteger)index;
+ (NSString *) getSearchScopeText:(NSInteger)scope;
+ (NSString *) getSpectrumImage:(NSInteger)atomicNumber withSpectrum:(NSInteger)spectrum;
+ (NSString *) getStateImage:(NSInteger)state withElementState:(NSInteger)elementState;

+ (NSString *) getTableHeader:(NSInteger)sortOrder;
+ (NSString *) getTitle:(NSInteger)sortOrder;

+ (bool) isRadioactive:(NSInteger)atomicNumber;

+ (void) playSpeech:(NSInteger)atomicNumber;


@end
