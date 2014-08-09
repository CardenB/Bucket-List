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

@dynamic propercaseFullName;
@dynamic lowercaseLastName;
@dynamic lowercaseFirstName;
@dynamic lowercaseFullName;


#warning remove/insert friend from tableview on add
/*
- (NSString *)propercaseFullName
{
    return self[@"propercaseFullName"];
}
- (void)setPropercaseFullName:(NSString *)name
{
    self[@"propercaseFullName"] = name;
}

- (NSString *)lowercaseFirstName
{
    return self[@"lowercaseFirstName"];
}
- (void)setLowercaseFirstName:(NSString *)name
{
    self[@"lowercaseFirstName"] = name;
}

- (NSString *)lowercaseLastName
{
    return self[@"lowercaseLastName"];
}
- (void)setLowercaseLastName:(NSString *)name
{
    [self setObject:name forKey:@"lowercaseLastName"];

}

- (NSString *)lowercaseFullName
{
    return self[@"lowercaseFullName"];
}
- (void)setLowercaseFullName:(NSString *)name
{
    self[@"lowercaseFullName"] = name;
}
*/
- (NSArray *)friendObjectIdArray
{
    return [self.friends valueForKeyPath:@"objectId"];
}

/*
- (NSArray *)friends
{
    return self[@"friends"];
}
- (void)setFriends:(NSArray *)friends
{
    self[@"friends"] = friends;
    [self save];
}
*/
@end
