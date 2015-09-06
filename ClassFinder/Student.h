//
//  Student.h
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <Parse/Parse.h>
@class Course;

@interface Student : PFObject<PFSubclassing>

+(NSString *)parseClassName;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *courses;

-(void)save;
-(void)addCourse:(Course *)course;
-(void)removeCourse:(Course *)course;

@end