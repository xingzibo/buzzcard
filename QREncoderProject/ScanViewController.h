//
//  ScanViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewPreview;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UIButton *bbitemStart;
- (IBAction)startScan;
@property (strong, nonatomic) NSString *scannedContact;

@end
