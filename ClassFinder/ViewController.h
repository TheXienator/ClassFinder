//
//  ViewController.h
//  ClassFinder
//
//  Created by Jason Xie on 9/4/15.
//  Copyright (c) 2015 Jason Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCorekit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *myButton;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *myLoginButton;

@end

