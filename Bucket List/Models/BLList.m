//
//  LSItem.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLList.h"
#import "Parse/PFObject+Subclass.h"

@implementation BLList

@dynamic name;
@dynamic creator;
@dynamic participants;
@dynamic itemArray;

+ (NSString *)parseClassName
{
    return @"BLList";
}


@end
