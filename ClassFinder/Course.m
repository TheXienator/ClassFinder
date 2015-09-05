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
@dynamic description;
@dynamic students;

+ (void)load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Course";
}

-(void)save {
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!succeeded) {
            NSLog(error.description);
        }
    }];
}

-(void)addStudent:(Student *)student {
    [self.students addObject:student];
}

@end
