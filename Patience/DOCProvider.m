//
//  DOCProvider.m
//  Patience
//
//  Created by Angie Lal on 11/17/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import "DOCProvider.h"

@implementation DOCProvider
- (id)initWithJson:(NSDictionary *)json
{
    self = [super initWithJson:json];
    if (self) {
        //set up patient properties here, like name and whatnot
        _name = json[@"name"];
    }
    return self;
}

@end
