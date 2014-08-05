//
//  BLUser.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/5/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLUser.h"
#import "Parse/PFObject+Subclass.h"


@implementation BLUser : PFUser

@dynamic friends;

/*
+ (NSString *)parseClassName {
    return @"BLUser";
}
 */

- (NSString *)name
{
    return self[@"additional"];
}

- (void)setName:(NSString *)name
{
    self[@"additional"] = name;
}
@end
