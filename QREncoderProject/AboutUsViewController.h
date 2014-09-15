//
//  AboutUsViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *myBuzz;
@property (strong, nonatomic) IBOutlet UIButton *buzzScan;

-(IBAction) myBuzzCard;
-(IBAction) buzzCardScan;
@end
