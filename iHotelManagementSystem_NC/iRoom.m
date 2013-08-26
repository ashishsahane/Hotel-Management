//
//  iRoom.m
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 05/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import "iRoom.h"

@implementation iRoom

@synthesize iRoomNumber = iRoomNumber;
@synthesize Description = Description;
@synthesize rate = rate;
@synthesize type = type;
@synthesize isAvailable = isAvailable;
@synthesize bookFromStr = bookFromStr;
@synthesize bookToStr = bookToStr;

-(void)dealloc
{
    if (Description) {
        [Description release];
        Description = nil;
    }
    if (bookToStr) {
        [bookToStr release];
        bookToStr = nil;
    }
    if (bookFromStr) {
        [bookFromStr release];
        bookFromStr = nil;
    }
    [super dealloc];
}


- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeInt:iRoomNumber forKey:@"RoomNumber" ];
    [coder encodeObject:Description forKey:@"Description"];
    [coder encodeFloat:rate forKey:@"rate"];
    [coder encodeInt:type forKey:@"type"];
    [coder encodeBool:isAvailable forKey:@"isAvailable"];
    [coder encodeObject:bookFromStr forKey:@"bookFromStr"];
    [coder encodeObject:bookToStr forKey:@"bookToStr"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setIRoomNumber:[aDecoder decodeIntForKey:@"RoomNumber"]];
    [self setDescription:[aDecoder decodeObjectForKey:@"Description"]];
    [self setRate:[aDecoder decodeFloatForKey:@"rate"]];
    [self setType:[aDecoder decodeIntForKey:@"type"]];
    [self setIsAvailable:[aDecoder decodeBoolForKey:@"isAvailable"]];
    [self setBookFromStr:[aDecoder decodeObjectForKey:@"bookFromStr"]];
    [self setBookToStr:[aDecoder decodeObjectForKey:@"bookToStr"]];
    return self;
}

-(NSString*)description
{
    NSString *strType = [[NSString alloc] initWithString:@""];
    
    switch (type) {
        case SINGLE:
            strType = @"Single";
            break;
        case DOUBLE:
            strType = @"Double";
            break;
        case TWIN:
            strType = @"Twin";
            break;
        case TWINDOUBLE:
            strType = @"Twin Double";
            break;
        case SUITE:
            strType = @"Suite";
            break;
        case JUNIORSUITE:
            strType = @"Junior Suite";
            break;
        case PENTHOUSESUITE:
            strType = @"PentHouse Suite";
            break;
            
        default:
            break;
    }
    NSString *strAvail = [[NSString alloc] initWithString:@""];

    if(isAvailable)
        strAvail = @"YES";
    else
        strAvail = @"NO";
    NSString *desc;
    if(isAvailable)
    {
        desc = [NSString stringWithFormat:@"\n Room Number:: %d \n Room Type:: %@ \n Room Description:: %@ \n Rate:: %.2f \n Is Available:: %@",iRoomNumber,strType,Description,rate,strAvail];
    }
    else{
    desc = [NSString stringWithFormat:@"\n Room Number:: %d \n Room Type:: %@ \n Room Description:: %@ \n Rate:: %.2f \n Booked From %@ to %@",iRoomNumber,strType,Description,rate,bookFromStr,bookToStr];
    }
    [strAvail release];
    strAvail = nil;
    
    [strType release];
    strType = nil;
    
    return desc;
}
@end
