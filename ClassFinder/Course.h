//
//  Course.h
//  
//
//  Created by Jason Xie on 9/5/15.
//
//

#import <Parse/Parse.h>
@class Student;

@interface Course : PFObject<PFSubclassing>

+(NSString *)parseClassName;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSMutableArray *students;

-(void)save;
-(void)addStudent:(Student *)student;

@end
