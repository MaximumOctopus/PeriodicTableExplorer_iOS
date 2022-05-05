//
//  Utility.m
//  PTE
//
//  Created by Paul Freshney on 01/08/2017.
//
//

#import <Foundation/Foundation.h>
#import "Utility.h"

@implementation Utility


+ (NSString *) getAboutBackground:(NSInteger)screenWidth withHeight:(NSInteger)screenHeight {
    
    if (screenHeight < screenWidth)
    {
        screenHeight = screenWidth;
    }
    
    if (screenHeight > 480 && screenHeight < 667)
    {
        NSLog(@"iPhone 5/5s");
        
        return @"about-568h@2x.png";
    }
    else if ( screenHeight > 480 && screenHeight < 736)
    {
        NSLog(@"iPhone 6");
        
        return @"about-667h@2x.png";
    }
    else if ( screenHeight > 480)
    {
        NSLog(@"iPhone 6 Plus");
        
        return @"about-736h@3x.png";
    }
    else
    {
        return @"about@2x.png";
    }
}


+ (int) getElementANFromPage:(NSString *)url {
    
    if ([url length] != 0)
    {
        url = [url lastPathComponent];
        
        //NSLog(@"%@", url);
        
        if (![url hasPrefix:@"otd"]) // onthisday (otdDDMM.htm)
        {
            NSCharacterSet *wildCardSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz._ "];
            
            NSString *eAN = [url stringByTrimmingCharactersInSet:wildCardSet];
            
            if ([eAN length] == 0)
            {
                return -1;
            }
            else
            {
                return [eAN intValue];
            }
        }
        else
        {
            return -1;
        }
    }
    else
    {
        return -1;
    }
}


+ (NSString *) getFilePathFromCategory:(NSInteger)category withElementAN:(NSInteger)an {

    switch (category)
    {
        case 0:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%ld", (long)an] ofType:@"htm"];
            break;
        case 1:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"o%ld", (long)an] ofType:@"htm"];
            break;
        case 2:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"r%ld", (long)an] ofType:@"htm"];
            break;
        case 3:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"p%ld", (long)an] ofType:@"htm"];
            break;
        case 4:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"c%ld", (long)an] ofType:@"htm"];
            break;
        case 5:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"i%ld", (long)an] ofType:@"htm"];
            break;
        case 6:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"s%ld", (long)an] ofType:@"htm"];
            break;
        case 7:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"ad%ld", (long)an] ofType:@"htm"];
            break;
        case 8:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"mac%ld", (long)an] ofType:@"htm"];
            break;
        case 9:
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"a%ld", (long)an] ofType:@"htm"];
            break;
            
        default:
            NSLog(@"Unknown category %ld element %ld", (long)category, (long)an);
            return [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%ld", (long)an] ofType:@"htm"];
            break;
    }
}


+ (NSString *) getGroupNameFromType:(NSInteger)type {
    
    switch (type)
    {
        case 0:
            return @"Metalloids";
            break;
        case 1:
            return @"Alkali Metals";
            break;
        case 2:
            return@"Transition Metals";
            break;
        case 3:
            return @"Non-metals";
            break;
        case 4:
            return @"Alkali Earth Metals";
            break;
        case 5:
            return @"Metals";
            break;
        case 6:
            return @"Halogens";
            break;
        case 7:
            return @"Noble Gases";
            break;
        case 8:
            return @"Transactinides";
            break;
        case 9:
            return @"Lanthanoids";
            break;
        case 10:
            return @"Actinoids";
            break;
            
        default:
            NSLog(@"Unknown type %ld", (long)type);
            return @"Unknown";
            break;
    }
}


+ (NSString *) getOnThisDayFileName {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];
    
    NSString *dateString = @"";
    
    if (day < 10)
    {
        dateString = [dateString stringByAppendingString: [NSString stringWithFormat:@"0%lu", (long)day]];
    }
    else
    {
        dateString = [dateString stringByAppendingString: [NSString stringWithFormat:@"%lu", (long)day]];
    }
    
    if (month < 10)
    {
        dateString = [dateString stringByAppendingString: [NSString stringWithFormat:@"0%lu", (long)month]];
    }
    else
    {
        dateString = [dateString stringByAppendingString: [NSString stringWithFormat:@"%lu", (long)month]];
    }
    
    [calendar release];
    
    return [[NSBundle mainBundle] pathForResource:dateString ofType:@"htm"];
}


+ (NSString *) getSearchScopeText:(NSInteger)scope {

    switch (scope)
    {
        case 0:
            return @"Constants";
            break;
        case 1:
            return @"Compounds";
            break;
        case 2:
            return @"Equations";
            break;
        case 3:
            return @"Page Content";
            break;
        case 4:
            return @"Molecular calculator";
            break;
    
        default:
            return @"Unknown!!";
            break;
    }
}


+ (NSString *) getSpectrumImage:(NSInteger)atomicNumber withSpectrum:(NSInteger)spectrum {
    
    if (atomicNumber < 99)
    {
        if (spectrum == 1)
        {
            return [NSString stringWithFormat:@"%ld_a.png", (long)atomicNumber];
        }
        else
        {
            return [NSString stringWithFormat:@"%ld_e.png", (long)atomicNumber];
        }
    }
    else
    {
        return @"87_a.png";
    }
}


+ (NSString *) getStateImage:(NSInteger)state withElementState:(NSInteger)elementState {
    
    if (state == elementState)
    {
        switch (elementState)
        {
            case 1:
                return @"grad76.png";
                break;
            case 2:
                return @"grad41.png";
                break;
            case 3:
                return @"grad31.png";
                break;
            case 4:
                return @"grad106.png";
                break;
                
            default:
                return @"grad129.png";
        }
    }
    else
    {
        return @"grad129.png";
    }
}


+ (NSString *) getPLIST:(NSInteger)index {
    
    switch (index)
    {
        case 0:
            return [[NSBundle mainBundle] pathForResource:@"PTEName" ofType:@"plist"];
            break;
        case 1:
            return [[NSBundle mainBundle] pathForResource:@"PTEAN" ofType:@"plist"];
            break;
        case 2:
            return [[NSBundle mainBundle] pathForResource:@"PTEMP" ofType:@"plist"];
            break;
        case 3:
            return [[NSBundle mainBundle] pathForResource:@"PTEBP" ofType:@"plist"];
            break;
        case 4:
            return [[NSBundle mainBundle] pathForResource:@"PTEDD" ofType:@"plist"];
            break;
        case 5:
            return [[NSBundle mainBundle] pathForResource:@"PTEENPS" ofType:@"plist"];
            break;
        case 6:
            return [[NSBundle mainBundle] pathForResource:@"PTEAV" ofType:@"plist"];
            break;
        case 7:
            return [[NSBundle mainBundle] pathForResource:@"PTEAR" ofType:@"plist"];
            break;
        case 8:
            return [[NSBundle mainBundle] pathForResource:@"PTESun" ofType:@"plist"];
            break;
        case 9:
            return [[NSBundle mainBundle] pathForResource:@"PTEUniverse" ofType:@"plist"];
            break;
        case 10:
            return [[NSBundle mainBundle] pathForResource:@"PTEEarthCrust" ofType:@"plist"];
            break;
        case 11:
            return [[NSBundle mainBundle] pathForResource:@"PTEEOA" ofType:@"plist"];
            break;
        case 12:
            return [[NSBundle mainBundle] pathForResource:@"PTEEOF" ofType:@"plist"];
            break;
        case 13:
            return [[NSBundle mainBundle] pathForResource:@"PTEEOV" ofType:@"plist"];
            break;
        case 14:
            return [[NSBundle mainBundle] pathForResource:@"PTEHC" ofType:@"plist"];
            break;
        case 15:
            return [[NSBundle mainBundle] pathForResource:@"PTETC" ofType:@"plist"];
            break;
        case 16:
            return [[NSBundle mainBundle] pathForResource:@"PTETE" ofType:@"plist"];
            break;
        case 17:
            return [[NSBundle mainBundle] pathForResource:@"PTESOS" ofType:@"plist"];
            break;
        case 18:
            return [[NSBundle mainBundle] pathForResource:@"PTEVEP" ofType:@"plist"];
            break;				
    
        default:
            return [[NSBundle mainBundle] pathForResource:@"PTEName" ofType:@"plist"];
            break;
    }
}


+ (NSString *) getTableHeader:(NSInteger)sortOrder {
    
    switch (sortOrder)
    {
        case 0:
            return @"Elements listed by Name";
            break;
        case 1:
            return @"Elements listed by Atomic Number";
            break;
        case 2:
            return @"Elements listed by Melting Point (K)";
            break;
        case 3:
            return @"Elements listed by Boiling Point (K)";
            break;
        case 4:
            return @"Elements listed by Discovery Date";
            break;
        case 5:
            return @"Elements listed by Electronegativity (Pauling)";
            break;
        case 6:
            return @"Elements listed by Atomic Volume (cm^3/mol)";
            break;
        case 7:
            return @"Elements listed by Atomic Radius (picometres)";
            break;
        case 8:
            return @"Elements listed by abundance in the Sun";
            break;
        case 9:
            return @"Elements listed by abundance in the Universe";
            break;
        case 10:
            return @"Elements listed by abundance in the Earth's Crust";
            break;
        case 11:
            return @"Elements listed by Enthalpy of Atomisation";
            break;
        case 12:
            return @"Elements listed by Enthalpy of Fusion";
            break;
        case 13:
            return @"Elements listed by Enthalpy of Vapourisation";
            break;
        case 14:
            return @"Elements listed by Heat Capacity";
            break;
        case 15:
            return @"Elements listed by Thermal Conductivity";
            break;
        case 16:
            return @"Elements listed by Thermal Expansion";
            break;
        case 17:
            return @"Elements listed by Speed of Sound (m/s)";
            break;
        case 18:
            return @"Elements listed by Valence Electron Potential (-eV)";
            break;
            
        default:
            return @"Error!";
    }
}


+ (NSString *) getTitle:(NSInteger)sortOrder {
    
    switch (sortOrder)
    {
        case 0:
            return @"Name";
            break;
        case 1:
            return @"Atomic #";
            break;
        case 2:
            return @"Melting Point";
            break;
        case 3:
            return @"Boiling Point";
            break;
        case 4:
            return @"Discovery";
            break;
        case 5:
            return @"Electroneg.";
            break;
        case 6:
            return @"Atomic Volume";
            break;
        case 7:
            return @"Atomic Radius";
            break;
        case 8:
            return @"Abundance Sun";
            break;
        case 9:
            return @"Abundance Uni";
            break;
        case 10:
            return @"Abundance Earth";
            break;
        case 11:
            return @"Enth of Atom";
            break;
        case 12:
            return @"Enth of Fusion";
            break;
        case 13:
            return @"Enth of Vapour";
            break;
        case 14:
            return @"Heat Capacity";
            break;
        case 15:
            return @"Thermal Cond";
            break;
        case 16:
            return @"Thermal Expan";
            break;
        case 17:
            return @"Speed Sound";
            break;
        case 18:
            return @"VEP";
            break;
            
        default:
            return @"Error!";
    }
}


+ (bool) isRadioactive:(NSInteger)atomicNumber {
    
    // range 0..117
    
    if ((atomicNumber == 42) || (atomicNumber == 60) || (atomicNumber > 81))
    {
        return true;
    }
    else
    {
        return false;
    }
}


+ (void) playSpeech:(NSInteger)atomicNumber {

    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:
                                  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%ld", (long)atomicNumber] ofType:@"aiff"]] error:NULL];

    [audioPlayer play];
}


@end
