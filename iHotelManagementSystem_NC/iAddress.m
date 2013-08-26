//
//  iAddress.m
//  iHotelBookingSystem
//
//  Created by Amit Sonavane on 05/06/13.
//  Copyright (c) 2013 Amit Sonavane. All rights reserved.
//

#import "iAddress.h"

@implementation iAddress

@synthesize address = address;
@synthesize city = city;

-(id)init
{
    self = [super init];
    if(self)
    {
        city = [[iCity alloc] init];
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:address forKey:@"address" ];
    [coder encodeObject:city forKey:@"city"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    city = [[iCity alloc] init];
    [self setAddress:[aDecoder decodeObjectForKey:@"address"]];
    [self setCity:[aDecoder decodeObjectForKey:@"city"]];
    return self;
}
-(void)dealloc
{
    if(city)
    {
        [city release];
        city = nil;
    }
    if(address)
    {
        [address release];
        address = nil;
    }
    [super dealloc];
}
-(NSString*)description
{
    return ([NSString stringWithFormat:@"\n %@ \n %@",address,city]);
}
@end
