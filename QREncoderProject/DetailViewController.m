//
//  DetailViewController.m
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import "DetailViewController.h"
#import "ContactDetailViewController.h"
@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize profilePic,imageName,detailDescriptionLabel,personAddress,personContactNum,personCity,personFullName,personCompanyName,personCountry,personDOB,personEmailID,personLastName,personPostCode,personDesign,personWebsite;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


//



//

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft]
                                forKey:@"orientation"];
}

- (void)viewDidLoad
{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft]
                                forKey:@"orientation"];
    
    
    /*
    [detailDescriptionLabel sizeToFit];
    [personAddress sizeToFit];
    [persontitle sizeToFit];
    [personFirstName sizeToFit];
    [personLastName sizeToFit];
    [personDOB sizeToFit];
    [personAddress sizeToFit];
    [personCity sizeToFit];
    [personCountry sizeToFit];
    [personPostCode sizeToFit];
     */
    
    self.profilePic.layer.borderWidth = 3.0f;
    
    self.profilePic.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
    
    ContactDetailViewController *cdv = [[ContactDetailViewController alloc] init];
    [cdv getContactDetails];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *selCont = [prefs stringForKey:@"ContactToBeSent"];
   // NSLog(@"The selected contact is %@",selCont);
    
    NSArray *finalContact = [selCont componentsSeparatedByString:@"&&"];
   
   
    self.personDesign.text=finalContact[0];
    self.personDesign.adjustsFontSizeToFitWidth = YES;
   // [self.persontitle adjustsFontSizeToFitWidth];
   // [self.persontitle sizeToFit];
    
    self.personFullName.text=finalContact[1];
    self.personFullName.adjustsFontSizeToFitWidth = YES;
    //[self.personFirstName adjustsFontSizeToFitWidth];
    //[self.personFirstName sizeToFit];
    
    self.personLastName.text=finalContact[2];
    self.personLastName.adjustsFontSizeToFitWidth = YES;
    //[self.personLastName adjustsFontSizeToFitWidth];
   // [self.personLastName sizeToFit];
    
   // NSString *fullName1 = [finalContact[1] stringByAppendingString:@" "];
   // NSString *fullName2 = [fullName1 stringByAppendingString:finalContact[2]];
    
    self.personFullName.text = finalContact[1];
    
    self.personDOB.text=finalContact[3];
    
    [self.personContactNum setTitle:finalContact[4] forState:UIControlStateNormal];
    [self.personFaxNum setTitle:finalContact[5] forState:UIControlStateNormal];
    
    NSString *eid;
    eid = [finalContact[6] lowercaseString];
    [self.personEmailID setTitle:eid forState:UIControlStateNormal];
    
    
    self.personCompanyName.text=finalContact[7];
    
    NSString *site;
    site = [finalContact[8] lowercaseString];
   // NSString *website=@"www.";
   // site = [website stringByAppendingString:site];
    [self.personWebsite setTitle:site forState:UIControlStateNormal];
    
    self.personAddress.text=finalContact[9];
    self.personCity.text=finalContact[10];
    self.personCountry.text=finalContact[11];
    self.personPostCode.text=finalContact[12];
    
    NSString *contNumString = [self.personContactNum titleForState:UIControlStateNormal];
    NSArray *myStrings = [[NSArray alloc] initWithObjects:self.personFullName.text , contNumString, nil];
    
    imageName = [myStrings componentsJoinedByString:@"|"];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:imageName];
    self.profilePic.image = [UIImage imageWithData:imageData];
    
}

-(void) openWebpage
{
    NSString* launchUrl = [@"http://" stringByAppendingString:self.personWebsite.currentTitle];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
    
}

-(void) makeCall
{
    NSString *numToCall=[@"tel:" stringByAppendingString:self.personContactNum.currentTitle];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numToCall]];
}

-(void) sendEmail
{
 //   NSString *emailTitle = @"";
    // Email Content
   // NSString *messageBody = @"";
    // To address
   // NSArray *toRecipents = [NSArray arrayWithObject:self.personContactNum];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    //[mc setSubject:emailTitle];
    //[mc setMessageBody:messageBody isHTML:NO];
    NSArray *toArray = [self.personEmailID.currentTitle componentsSeparatedByString:@""];
    [mc setToRecipients:toArray];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
          //  NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
           // NSLog(@"Mail not sent.");
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
     
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
