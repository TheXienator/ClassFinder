//
//  CourseViewController.m
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCorekit.h>
#import "CourseViewController.h"
#import "FriendViewController.h"
#import "Student.h"

@interface CourseViewController ()

@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;

@property (strong, nonatomic) NSMutableArray *students;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(self.course.name);
    self.courseName.text = self.course.name;
    [self.friendsTableView setDelegate:self];
    [self.friendsTableView setDataSource:self];
    [self setUpFacebook];
    [self retrieveFromParse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpFacebook {
//    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                  initWithGraphPath:@"/me/friends"
//                                  parameters:@{@"fields": @"id, name"}
//                                  HTTPMethod:@"GET"];
//    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                          id result,
//                                          NSError *error) {
//        NSLog(@"%@", result);
//    }];
}

-(void)retrieveFromParse {
    PFQuery *query = [Student query];
    // TODO: fb friends stuff
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error) {
            self.students = [[NSMutableArray alloc] init];
            for (Student *object in objects) {
                if ([object.courseIds containsObject:self.course.objectId]) {
                    if ([object.objectId isEqualToString:self.currentId.objectId]) {
                        [self.addButton setTitle:@"-" forState:UIControlStateNormal];
                    } else {
                        [self.students addObject:object];
                    }
                }
            }
            [self.friendsTableView reloadData];
        } else {
            NSLog(error.description);
        }
    }];
}

- (IBAction)addCourse:(id)sender {
    if ([self.addButton.titleLabel.text isEqualToString:@"+"]) {
        if (!self.course.studentIds) {
            self.course.studentIds = [NSMutableArray new];
        }
        [self.course.studentIds addObject:self.currentId.objectId];
        if (!self.currentId.courseIds) {
            self.currentId.courseIds = [NSMutableArray new];
        }
        [self.currentId.courseIds addObject:self.course.objectId];
        [self.course saveInBackground];
        [self.currentId saveInBackground];
        [self.addButton setTitle:@"-" forState:UIControlStateNormal];
    } else {
        [self.course.studentIds removeObject:self.currentId.objectId];
        [self.currentId.courseIds removeObject:self.course.objectId];
        [self.course saveInBackground];
        [self.currentId saveInBackground];
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *coursesIdentifier = @"friendsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coursesIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coursesIdentifier];
    }
    
    Student *student = [self.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = student.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Student *selectedObj = [self.students objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"CourseToFriend" sender:selectedObj];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    FriendViewController *nextVC = [segue destinationViewController];
    nextVC.student = sender;
    nextVC.currentId = self.currentId;
}

@end
