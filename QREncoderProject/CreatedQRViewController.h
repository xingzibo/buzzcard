//
//  ViewController.h
//  QREncoderProject
//
//  Created by Daniel Beard on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qrencode.h"

@interface CreatedQRViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *contactImageView;
@property (strong, nonatomic) UIWindow *window;
-(IBAction)saveQR;
-(IBAction)goBack;

@property (strong, nonatomic) NSString *contact;

- (UIImage *)quickResponseImageForString:(NSString *)dataString withDimension:(int)imageWidth;

@end
