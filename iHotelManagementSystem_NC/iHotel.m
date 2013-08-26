//
//  iHotel.m
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 05/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import "iHotel.h"

@implementation iHotel

@synthesize Name = Name;
@synthesize telephone_number = telephone_number;
@synthesize rating = rating;
@synthesize arrRoom = arrRoom;
@synthesize NumberOfRooms = NumberOfRooms;
@synthesize address = address;
@synthesize hotelImage = hotelImage;


 -(id)init
{
    self = [super init];
    if(self)
    {
        address = [[iAddress alloc] init];
        arrRoom = [[NSMutableArray alloc] init];
    }
    return self;
}
#pragma mark - NSCoding

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:Name forKey:@"Name" ];
    [coder encodeInt:telephone_number forKey:@"telephone_number"];
    [coder encodeFloat:rating forKey:@"rating"];
    [coder encodeInt:NumberOfRooms forKey:@"NumberOfRooms"];
    [coder encodeObject:arrRoom forKey:@"RoomArray"];
    [coder encodeObject:address forKey:@"addressObj"];
    [coder encodeObject:hotelImage forKey:@"hotelImage"];

}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    address = [[iAddress alloc] init];
    arrRoom = [[NSMutableArray alloc] init];
    
    [self setName:[aDecoder decodeObjectForKey:@"Name"]];
    [self setTelephone_number:[aDecoder decodeIntForKey:@"telephone_number"]];
    [self setRating:[aDecoder decodeFloatForKey:@"rating"]];
    [self setNumberOfRooms:[aDecoder decodeIntForKey:@"NumberOfRooms"]];
    [self setArrRoom:[aDecoder decodeObjectForKey:@"RoomArray"]];
    [self setAddress:[aDecoder decodeObjectForKey:@"addressObj"]];
    [self setHotelImage:[aDecoder decodeObjectForKey:@"hotelImage"]];
    
    return self;
}
-(void)dealloc
{
    if(Name)
    {
        [Name release];
        Name = nil;
    }
    if(address)
    {
        [address release];
        address = nil;
    }
    if (arrRoom) {
        [arrRoom removeAllObjects];
        [arrRoom release];
        arrRoom = nil;
    }
    if(hotelImage)
    {
        [hotelImage release];
        hotelImage = nil;
    }
    [super dealloc];
}

-(NSString*)description
{
    
    NSString *desc = [NSString stringWithFormat:@"\n Hotel Name:: %@ \n Address:: %@ \n Contact Number:: %d \n Ratings:: %.1f/5",Name,address,telephone_number,rating];

    iRoom *rm = [[iRoom alloc] init];

    for (iRoom *rm in [self arrRoom])
        desc = [desc stringByAppendingFormat:@"\n ====Room Info==== %@",[rm description]];
    [rm release];
    rm = nil;

    

    return desc;
}

@end
