//
//  MyQRViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import <UIKit/UIKit.h>

@interface MyQRViewController : UIViewController <NSURLSessionDataDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *MyQR;

@property (strong, nonatomic) IBOutlet UIButton *save;
@property (strong, nonatomic) IBOutlet UIButton *back;

@property (strong, nonatomic) IBOutlet UILabel *qrStat;

@property (strong, nonatomic) IBOutlet UILabel *qrHead;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)NSMutableData *buffer;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSString *recievedContact;


-(IBAction)saveQR;
-(IBAction)goBack;
@end
