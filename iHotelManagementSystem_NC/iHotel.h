//
//  iHotel.h
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 05/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iAddress.h"
#import "iRoom.h"


@interface iHotel : NSObject <NSCoding>
{
    iAddress *address;
}

@property (retain) NSString *Name;
@property int telephone_number;
@property float rating;
@property int NumberOfRooms;
@property (retain) NSMutableArray *arrRoom;
@property (retain) iAddress *address;
@property (retain) UIImage *hotelImage;

@end
