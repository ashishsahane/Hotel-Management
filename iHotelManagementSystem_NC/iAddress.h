//
//  iAddress.h
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 05/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCity.h"

@interface iAddress : NSObject <NSCoding>
{
    iCity* city;
}
@property (retain)NSString* address;
@property (retain)iCity* city;

@end
