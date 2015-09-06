//
//  Course.m
//  
//
//  Created by Jason Xie on 9/5/15.
//
//

#import "Course.h"
#import <Parse/PFObject+Subclass.h>

@implementation Course

@dynamic name;
@dynamic department;
@dynamic number;
@dynamic description;
@dynamic studentIds;

+ (void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Course";
}

@end
