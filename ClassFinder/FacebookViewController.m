//
//  FacebookViewController.m
//  ClassFinder
//
//  Created by Eric Chiu on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import "FacebookViewController.h"
#import "HomeViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
    }
    
    // Add a custom login button to your app
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    self.loginButton.center = CGPointMake(20 + self.loginButton.frame.size.width / 2,
                                          self.view.frame.size.height - 20 - self.loginButton.frame.size.height / 2);
    [self.view addSubview:self.loginButton];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 [self performSegueWithIdentifier:@"FBToHome" sender:self];
             }
         }];
    } else {
        NSLog(@"NOPE");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
