//
//  Class.h
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <Parse/Parse.h>

@interface Class : PFObject

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSMutableArray *students;

@end
