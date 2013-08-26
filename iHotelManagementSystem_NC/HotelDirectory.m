//
//  HotelDirectory.m
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 14/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import "HotelDirectory.h"
#import "iRoom.h"

@implementation HotelDirectory

@synthesize hotelList = hotelList;
-(id)init
{
    self = [super init];
    if(self)
    {
        hotelList = [[NSMutableArray alloc] init];
    }
    return self;
}
#pragma mark - NSCoding

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: hotelList forKey:@"hotelList" ];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setHotelList:[aDecoder decodeObjectForKey:@"hotelList"]];
    return self;
}

-(void)dealloc
{
    if(hotelList)
    {
        [hotelList removeAllObjects];
        [hotelList release];
        hotelList = nil;
    }
    [super dealloc];
}

-(iHotel *) search : (NSString *)Name andCity : (NSString *)city
{
    for (iHotel *hotel in hotelList) {
        if([[hotel Name] isEqualToString:Name] && [[[[hotel address] city] name] isEqualToString:city])
            return hotel;
    }
    return nil;
}

-(void)viewAllHotels
{
    [hotelList enumerateObjectsUsingBlock:^(id hotel, NSUInteger idx, BOOL *stop)
    {
        NSLog(@"\n---------- Hotel Details----------- %@",hotel);
        iRoom *rm = [[iRoom alloc] init];
        
        for (iRoom *rm in [hotel arrRoom])
            NSLog(@"\n ====Room Info==== %@",rm);
        [rm release];
        rm = nil;
    }];
}
-(NSString*)getAllHotels
{
    NSString *strHotels = [[NSString alloc] initWithString:@"\n---------- Hotel Details-----------"];
    for(iHotel *hotel in hotelList)
     {
         strHotels = [strHotels stringByAppendingFormat:@"\n\n ****====Hotel Info ====*** %@",[hotel description]];
         iRoom *rm = [[iRoom alloc] init];
         
         for (iRoom *rm in [hotel arrRoom])
             strHotels = [strHotels stringByAppendingFormat:@"\n ====Room Info==== %@",[rm description]];
         [rm release];
         rm = nil;
     };
    return [strHotels autorelease];
}
@end
