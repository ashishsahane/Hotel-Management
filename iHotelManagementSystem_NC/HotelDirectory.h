//
//  HotelDirectory.h
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 14/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iHotel.h"

@interface HotelDirectory : NSObject <NSCoding>
{
    NSMutableArray *hotelList;
}
@property(readwrite,retain) NSMutableArray *hotelList;
-(iHotel *) search : (NSString *)Name andCity : (NSString *)city;
-(void)viewAllHotels;
-(NSString*)getAllHotels;

@end
