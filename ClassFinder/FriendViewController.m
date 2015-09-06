//
//  FriendViewController.m
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import "FriendViewController.h"
#import "CourseViewController.h"
#import "Course.h"

@interface FriendViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;

@property (strong, nonatomic) NSMutableArray *courses;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(self.student.name);
    self.name.text = self.student.name;
    [self.coursesTableView setDelegate:self];
    [self.coursesTableView setDataSource:self];
    [self retrieveFromParse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self performSegueWithIdentifier:@"FriendToCourse" sender:selectedObj];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CourseViewController *nextVC = [segue destinationViewController];
    nextVC.course = sender;
    nextVC.currentId = self.currentId;
}


@end
