//
//  SearchViewController.m
//  ClassFinder
//
//  Created by Jason Xie on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import "SearchViewController.h"
#import "CourseViewController.h"
#import "Course.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;

@property (strong, nonatomic) NSMutableArray *courses;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.coursesTableView setDelegate:self];
    [self.coursesTableView setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender {
    if (self.searchTextField.text.length > 0) {
        [self retrieveFromParse];
    }
}

- (void)retrieveFromParse {
    PFQuery *courses = [Course query];
    [courses whereKey:@"name" containsString:[self.searchTextField.text uppercaseString]];
    [courses findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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
    [self performSegueWithIdentifier:@"SearchToCourse" sender:selectedObj];
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
        nextVC.currentId = self.currentId;
    }
}

@end
