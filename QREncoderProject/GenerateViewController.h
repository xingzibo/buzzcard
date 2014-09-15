//
//  GenerateViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import <UIKit/UIKit.h>

@interface GenerateViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IBOutlet UITextField *personDesignation;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (strong, nonatomic) IBOutlet UITextField *contactNumber;
@property (strong, nonatomic) IBOutlet UITextField *emailId;
@property (strong, nonatomic) IBOutlet UITextField *companyName;
@property (strong, nonatomic) IBOutlet UITextField *webUrl;
@property (strong, nonatomic) IBOutlet UITextField *streetDetails;
@property (strong, nonatomic) IBOutlet UITextField *cityName;
@property (strong, nonatomic) IBOutlet UITextField *countryName;
@property (strong, nonatomic) IBOutlet UITextField *postCode;
@property (strong, nonatomic) IBOutlet UITextField *faxNumber;

@property (strong, nonatomic) IBOutlet UIView *myView;

-(IBAction) createQR;

@end
