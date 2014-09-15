//
//  DetailViewController.h
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *personDesign;
@property (strong, nonatomic) IBOutlet UILabel *personFullName;
@property (strong, nonatomic) IBOutlet UILabel *personLastName;
@property (strong, nonatomic) IBOutlet UILabel *personDOB;
@property (strong, nonatomic) IBOutlet UIButton *personContactNum;
@property (strong, nonatomic) IBOutlet UIButton *personFaxNum;
@property (strong, nonatomic) IBOutlet UIButton *personEmailID;
@property (strong, nonatomic) IBOutlet UILabel *personCompanyName;
@property (strong, nonatomic) IBOutlet UIButton *personWebsite;
@property (strong, nonatomic) IBOutlet UILabel *personAddress;
@property (strong, nonatomic) IBOutlet UILabel *personCity;
@property (strong, nonatomic) IBOutlet UILabel *personCountry;
@property (strong, nonatomic) IBOutlet UILabel *personPostCode;

@property (strong, nonatomic) IBOutlet UIImageView *profilePic;

@property (strong, nonatomic) NSString *imageName;

-(IBAction)makeCall;
-(IBAction)sendEmail;
-(IBAction)openWebpage;
@end
