//
//  ContactDetailViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import <Parse/Parse.h>

@interface ContactDetailViewController : UIViewController <NSURLSessionDataDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UITextField *designation;
    UITextField *firstName;
    UITextField *lastName;
    UITextField *dateOfBirth;
    UITextField *contactNumber;
    UITextField *emailId;
    UITextField *companyName;
    UITextField *webUrl;
    UITextField *addressDetails;
    UITextField *cityName;
    UITextField *countyName;
    UITextField *postCode;
    
    NSString *databasePath;
    
    sqlite3 *contactDB;
    sqlite3_stmt *insertStatement;
    sqlite3_stmt *updateStatement;
    sqlite3_stmt *deleteStatement;
    sqlite3_stmt *selectStatement;
    //sqlite3_stmt *selectContact;
}

@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)NSMutableData *buffer;

@property (strong, nonatomic) IBOutlet UITextField *designation;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (strong, nonatomic) IBOutlet UITextField *contactNumber;
@property (strong, nonatomic) IBOutlet UITextField *faxNumber;
@property (strong, nonatomic) IBOutlet UITextField *emailId;
@property (strong, nonatomic) IBOutlet UITextField *companyName;
@property (strong, nonatomic) IBOutlet UITextField *webUrl;
@property (strong, nonatomic) IBOutlet UITextField *addressDetails;
@property (strong, nonatomic) IBOutlet UITextField *cityName;
@property (strong, nonatomic) IBOutlet UITextField *countryName;
@property (strong, nonatomic) IBOutlet UITextField *postCode;

@property (strong, nonatomic) IBOutlet UIImageView *scannedContactImage;
@property (strong, nonatomic) UIImageView *scanImg;
@property (strong, nonatomic) NSString *imageName;
@property int i;
@property (strong, nonatomic)  NSString *contactToAttach;
@property (retain, readwrite) PFObject *contact;
-(void) getContactDetails;
-(IBAction)goBack;
-(IBAction)saveContact;
-(IBAction)takePhoto;
-(IBAction)selectPhoto;
-(void) saveContactFromOtherMobile;
-(void) findContact;
-(void) delContact;
@end
