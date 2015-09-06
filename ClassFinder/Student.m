//
//  Student.m
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import "Student.h"
#import <Parse/PFObject+Subclass.h>

@implementation Student

@dynamic name;
@dynamic fbId;
@dynamic courseIds;

+ (void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Student";
}

+(Student *)studentWithName:(NSString *)name {
    Student *student = [[Student alloc] init];
    student.name = name;
    student.courseIds = [[NSMutableArray alloc] init];
    return student;
}

@end
