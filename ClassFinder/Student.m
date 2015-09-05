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
@dynamic courses;

+ (void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Student";
}

-(void)save {
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!succeeded) {
            NSLog(error.description);
        }
    }];
}

-(void)addCourse:(Course *)course{
    [self.courses addObject:course];
}

-(void)removeCourse:(Course *)course {
    [self.courses removeObject:course];
}

@end
