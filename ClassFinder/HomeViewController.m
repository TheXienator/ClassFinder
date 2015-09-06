//
//  HomeViewController.m
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCorekit.h>
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "CourseViewController.h"
#import "Course.h"
#import "Student.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;

@property (strong, nonatomic) NSMutableArray *courses;

@property (strong, nonatomic) Student *student;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.coursesTableView setDelegate:self];
    [self.coursesTableView setDataSource:self];
    [self setUpFacebook];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setUpFacebook];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpFacebook {
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             PFQuery *query = [Student query];
             [query whereKey:@"name" equalTo:result[@"name"]];
             [query whereKey:@"fbId" equalTo:result[@"id"]];
             [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                 if (objects.count == 0) {
                     self.student = [Student object];
                     self.student.name = result[@"name"];
                     self.student.fbId = result[@"id"];
                     [self.student saveInBackground];
                 } else {
                     self.student = [objects objectAtIndex:0];
                 }
                 self.name.text = result[@"name"];
                 [self retrieveFromParse];
             }];
         }
     }];
}

- (void)retrieveFromParse {
    PFQuery *courses = [Course query];
    [courses whereKey:@"objectId" containedIn:self.student.courseIds];
    [courses findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error) {
            self.courses = [[NSMutableArray alloc] init];
            for (Course *object in objects) {
                [self.courses addObject:object];
            }
            [self.coursesTableView reloadData];
        } else {
            NSLog(error.description);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *coursesIdentifier = @"coursesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coursesIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coursesIdentifier];
    }

    Course *course = [self.courses objectAtIndex:indexPath.row];
    cell.textLabel.text = course.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Course *selectedObj = [self.courses objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"HomeToCourse" sender:selectedObj];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender respondsToSelector:@selector(studentIds)]) {
        CourseViewController *nextVC = [segue destinationViewController];
        nextVC.course = sender;
        nextVC.currentId = self.student;
    } else {
        SearchViewController *nextVC = [segue destinationViewController];
        nextVC.currentId = self.student;
    }
}

@end
