//
//  iRoom.h
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 05/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum type {SINGLE=1, DOUBLE, TWIN, TWINDOUBLE, SUITE, JUNIORSUITE, PENTHOUSESUITE} roomtype;

@interface iRoom : NSObject
{
}
@property int iRoomNumber;
@property (retain) NSString* Description;
@property float rate;
@property roomtype type;
@property BOOL isAvailable;
@property (retain) NSString* bookFromStr;
@property (retain) NSString* bookToStr;
@end
