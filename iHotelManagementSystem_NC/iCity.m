//
//  iCity.m
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 06/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import "iCity.h"

@implementation iCity
@synthesize name = name;
@synthesize postalCode = postalCode;


- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: name forKey:@"CityName" ];
    [coder encodeInt:postalCode forKey:@"postalCode"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setName:[aDecoder decodeObjectForKey:@"CityName"]];
    [self setPostalCode:[aDecoder decodeIntForKey:@"postalCode"]];
    return self;
}

-(void)dealloc
{
    if(name)
    {
        [name release];
        name = nil;
    }
    
    [super dealloc];
}

-(NSString*)description
{
    return ([NSString stringWithFormat:@"\n City:: %@ \n Postal Code:: %d",name,postalCode]);
}
@end
