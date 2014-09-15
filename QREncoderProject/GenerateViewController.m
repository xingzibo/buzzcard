//
//  GenerateViewController.m
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import "GenerateViewController.h"

#import "CreatedQRViewController.h"

#import "MyQRViewController.h"

@interface GenerateViewController ()

@end

@implementation GenerateViewController

@synthesize window;
@synthesize personDesignation,firstName,lastName,dateOfBirth,contactNumber,emailId,companyName,webUrl,streetDetails,cityName,countryName,postCode,faxNumber,myView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(BOOL)isABackSpace:(NSString*)string {
    NSString* check =@"Check";
    check = [check stringByAppendingString:string];
    if ([check isEqualToString:@"Check"]) {
        return YES;
    }
    return NO;
}


-(void) createQR
{
        
    if(![webUrl.text hasPrefix:@"www."])
    {
        NSString *url = @"www.";
        NSString *finalUrl = [url stringByAppendingString:webUrl.text];
        webUrl.text = finalUrl;
    }
    
    /////
    
    
    
    /////
    
    NSArray *contactArray = [[NSArray alloc] initWithObjects: firstName.text,lastName.text,personDesignation.text,dateOfBirth.text,contactNumber.text,faxNumber.text,emailId.text,companyName.text,webUrl.text,streetDetails.text,cityName.text,countryName.text,postCode.text, nil];
    NSString *finalContact = [contactArray componentsJoinedByString:@"|"];
    
    
    /////
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:finalContact forKey:@"ContactToAppend"];
    
    [prefs setObject:contactNumber.text forKey:@"ContactToSearch"];
    
    ////
    
    CreatedQRViewController *createQR = [[CreatedQRViewController alloc] initWithNibName:@"CreatedQRViewController" bundle:nil];
    createQR.contact = finalContact;
    
    UIImage *image1 = [createQR quickResponseImageForString:finalContact withDimension:182];
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image1) forKey:@"MyQR1"];
    
    //[self presentViewController:createQR animated:YES completion:nil];
    
    ////
    NSUserDefaults *prefsCont = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefsCont setObject:contactNumber.text forKey:@"MyContactNumber"];
    
    /////
    
    MyQRViewController *myQR = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQRView"];
    
    [self presentViewController:myQR animated:YES completion:nil];
    
    }

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    //
    
    personDesignation.delegate=self;
    firstName.delegate=self;
    lastName.delegate=self;
    dateOfBirth.delegate=self;
    contactNumber.delegate=self;
    emailId.delegate=self;
    companyName.delegate=self;
    webUrl.delegate=self;
    streetDetails.delegate=self;
    cityName.delegate=self;
    countryName.delegate=self;
    postCode.delegate=self;
    faxNumber.delegate=self;
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [dateOfBirth setInputView:datePicker];
    
}

-(void)updateTextField:(id)sender
{
    if([dateOfBirth isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)dateOfBirth.inputView;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        NSString *date = [dateFormat stringFromDate:picker.date];
    
        //NSLog(@"date is >>> , %@",date);
        dateOfBirth.text = date;
        //dateOfBirth.text = [NSString stringWithFormat:@"%@",picker.date];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [personDesignation resignFirstResponder];
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [dateOfBirth resignFirstResponder];
    [contactNumber resignFirstResponder];
    [emailId resignFirstResponder];
    [companyName resignFirstResponder];
    [webUrl resignFirstResponder];
    [streetDetails resignFirstResponder];
    [cityName resignFirstResponder];
    [countryName resignFirstResponder];
    [postCode resignFirstResponder];
    [faxNumber resignFirstResponder];

    return  YES;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}




- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 50; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
