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

/*
@dynamic friends;
@dynamic propercaseFullName;
@dynamic lowercaseLastName;
@dynamic lowercaseFirstName;
@dynamic lowercaseFullName;
 */

#warning remove/insert friend from tableview on add

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

- (NSArray *)friends
{
    return self[@"friends"];
}
- (void)setFriends:(NSArray *)friends
{
    self[@"friends"] = friends;
    [self save];
}

+ (void)addFriend:(BLUser *)user
{
    if (![BLUser currentUser].friends) {
        [BLUser currentUser].friends = [[NSArray alloc] initWithArray:@[user]];
    } else {
        [BLUser currentUser].friends = [[BLUser currentUser].friends arrayByAddingObject:user];
    }
}
+ (void)removeFriend:(BLUser *)user
{
    NSMutableArray *friendsArray = [[NSMutableArray alloc] initWithCapacity:[BLUser currentUser].friends.count];
    [friendsArray removeObject:user];
    [BLUser currentUser].friends = [friendsArray copy];
    [[BLUser currentUser] saveInBackground];
}
/*
+ (NSString *)parseClassName {
    return @"BLUser";
}


- (NSString *)name
{
    return self[@"additional"];
}

- (void)setName:(NSString *)name
{
    self[@"additional"] = name;
}
 */
@end
