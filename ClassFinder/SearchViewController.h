//
//  SearchViewController.h
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Student.h"

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)Student *currentId;

@end
