//
//  FacebookViewController.h
//  ClassFinder
//
//  Created by Eric Chiu on 9/5/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCorekit.h>

@interface FacebookViewController : UIViewController

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *myButton;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *myLoginButton;

@end
