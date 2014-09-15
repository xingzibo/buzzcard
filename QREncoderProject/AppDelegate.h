//
//  AppDelegate.h
//  QREncoderProject
//
//  Created by Daniel Beard on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreatedQRViewController;

@interface AppDelegate : UIViewController

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CreatedQRViewController *viewController;

@property (strong, nonatomic) UIAlertView *alert;

@end
