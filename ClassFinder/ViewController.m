//
//  ViewController.m
//  ClassFinder
//
//  Created by Jason Xie on 9/4/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCorekit.h>
#import <Parse/Parse.h>
#import "Student.h"
#import "Course.h"

@interface ViewController ()

@property (strong, nonatomic) Student *currentStudent;
@property (strong, nonatomic) NSMutableString *coursesString;

@property (weak, nonatomic) IBOutlet UITextField *studentTextField;
@property (weak, nonatomic) IBOutlet UITextField *classTextField;
@property (weak, nonatomic) IBOutlet UITextField *lookUpTextField;

@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *classesLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // For more complex open graph stories, use `FBSDKShareAPI`
    // with `FBSDKShareOpenGraphContent`
    /* make the API call */
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/{friend-list-id}"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id /*or NSDictionary* */ result,
                                          NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        NSLog(@"Found: %lu friends", (unsigned long)friends.count);
        //NSArray *friendIDs = [friends collect:^id(NSDictionary<FBGraphUser>* friend) {return friend.id;}];
    }];
}

- (IBAction)addStudentAction:(id)sender {
    if (self.studentTextField.text.length > 0) {
        self.currentStudent = [Student object];
        self.currentStudent.name = self.studentTextField.text;
        self.currentStudent.courses = [NSMutableArray new];
        self.studentNameLabel.text = self.studentTextField.text;
        self.classesLabel.text = @"No Classes";
        self.coursesString = NULL;
    }
    self.studentTextField.text = @"";
}

- (IBAction)addClassButton:(id)sender {
    if (self.currentStudent && self.classTextField.text.length > 0) {
        Course *course = [Course object];
        course.name = self.classTextField.text;
        [self.currentStudent addCourse:course];
        if (!self.coursesString) {
            self.coursesString = [NSMutableString new];
        } else {
            [self.coursesString appendString:@"\n"];
        }
        [self.coursesString appendString:[NSString stringWithFormat:@"Class %lu: %@", self.currentStudent.courses.count, self.classTextField.text]];
        self.classesLabel.text = self.coursesString;
    }
    self.classTextField.text = @"";
}

- (IBAction)save:(id)sender {
    [self.currentStudent save];
}

- (IBAction)findStudent:(id)sender {
    if (self.lookUpTextField.text.length > 0) {
        PFQuery *studentQuery = [PFQuery queryWithClassName:@"Student"];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
