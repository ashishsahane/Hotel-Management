//
//  NSString+ReadConsole.m
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 14/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import "NSString+ReadConsole.h"

@implementation NSString (ReadConsole)
+(NSString*)ReadConsoleData
{
    char buffer[2048] = {0};
    fgets(buffer, sizeof(buffer), stdin);
    NSString* inputString = [[NSString alloc] initWithUTF8String:buffer];
    
    return [inputString autorelease];
}
@end
