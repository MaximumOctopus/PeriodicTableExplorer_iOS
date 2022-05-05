//
//  HTMLUtility.m
//  PTE_Mac
//
//  Created by Paul Freshney on 19/07/2017.
//
//

#import <Foundation/Foundation.h>
#import "HTMLUtility.h"


@implementation HTMLUtility


+ (NSString *) getCalcErrorPage {
    
    return @"<html><head><link type=\"text/css\" rel=\"stylesheet\" href=\"element.css\"></link></head><body class=\"JF\"> \
             <div style=\"background-color:#FF88FF\" align='center'>Molecular Mass</div><br/> \
              <table width=\"100%\" class=\"pf\"><tr><td><b>Invalid input!</b> Calc is <i>case sensitive</i>, so all element sysmbols must be entered with the correct case. e.g. Li not li.</td></tr></table>";

}


+ (NSString *) getDivBlueCubeSingle {
    
    return [[self getDivBlueCubePrefix] stringByAppendingString:@"<br/>&nbsp;&nbsp;&nbsp;&nbsp;%@<br/>"];
}


+ (NSString *) getDivBlueCubeDouble{
    
    return [[self getDivBlueCubePrefix] stringByAppendingString:@"<br/>&nbsp;&nbsp;&nbsp;%@ %@<br/>"];
}


+ (NSString *) getDivBlueCubePrefix {
    
    return @"<br/><img src=\"bluecube.gif\"> <b class=\"JF\">%@</b><br/>";
}


+ (NSString *) getDivCAS {
    
    return @"<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"JX\">CAS:</span> <i class=\"JF\">%@</i><br/><br/>";
}


+ (NSString *) getDivMolecularMass {
    
    return @"<div style=\"background-color:#FF88FF\" align='center'>Molecular Mass for \"<b>%@</b>\"</div>";
}


+ (NSString *) getDocHeader {
    
    return @"<html><head><link type=\"text/css\" rel=\"stylesheet\" href=\"element.css\"></link></head><body class=\"JF\">";
}


+ (NSString *) getFoundResultsFor:(NSInteger)searchIndex {
    
    switch(searchIndex)
    {
        case 0:
            return @"<div style=\"background-color:#88FF88\" class=\"JF\" align='center'>Found %d results for \"<b>%@</b>\"</div>";
            break;
        case 1:
            return @"<div style=\"background-color:#8888FF\" class=\"JF\" align='center'>Found %d results for \"<b>%@</b>\"</div>";
            break;
        case 2:
            return @"<div style=\"background-color:#FFFF88\" class=\"JF\" align='center'>Found %d results for \"<b>%@</b>\"</div>";
            break;
        case 3:
            return @"<div style=\"background-color:#FF8888\" class=\"JF\" align='center'>Found %d results for \"<b>%@</b>\"</div>";
            break;
            
        default:
            return @"<div style=\"background-color:#88FF88\" class=\"JF\" align='center'>Found %d results for \"<b>%@</b>\"</div>";
            break;
    }
}


+ (NSString *) getIndentItalic {
    
    return @"&nbsp;&nbsp;&nbsp;&nbsp;<i class=\"JF\">%@</i><br/>";
}


+ (NSString *) getNaturalOccurenceHeader {
    
    return @"<br/><table width=\"100%\" class=\"pf\"><tr><td width=\"20\">&nbsp;</td><td width=\"20%\">Isotope</td><td width=\"40%\">Natural Occurence</td><td width=\"25%\">Mass</td></tr>";
}


+ (NSString *) getMassOutput {
    
    return @"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%d&nbsp;&nbsp;&nbsp;&nbsp;%3.2f%%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%5.3f u<br/>";
}


+ (NSString *) getTypeClass:(NSInteger)type {

    switch (type)
    {
        case 0: // ELEMENT PAGES
            return @"elink";
            break;
        case 1: // Biography
            return @"blink";
            break;
        case 2: // Production
            return @"plink";
            break;
        case 3: // Glossary
            return @"glink";
            break;
        case 4: // Compounds
            return @"clink";
            break;
        case 5: // Reactions
            return @"qlink";
            break;
        case 6: // Equations
            return @"qlink";
            break;
        case 7: // Country
            return @"slink";
            break;
        case 8: // Spectrum
            return @"ulink";
            break;
        case 9: // Isotope
            return @"ilink";
            break;
        case 10: // Allotrope
            return @"alink";
            break;
        case 11: // OnThisDay
            return @"olink";
            break;
            
        default:
            return @"elink";
            break;
    }
}

@end
