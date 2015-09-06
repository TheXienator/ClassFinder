//
//  CourseViewController.h
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "Student.h"

@interface CourseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)Course *course;
@property (nonatomic, strong)Student *currentId;

@end
