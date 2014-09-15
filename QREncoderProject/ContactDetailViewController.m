//
//  ContactDetailViewController.m
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import "ContactDetailViewController.h"
#import "CamViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SCViewController.h"
#import <Parse/Parse.h>

@interface ContactDetailViewController ()


@end

@implementation ContactDetailViewController


@synthesize detail,window,designation,firstName,lastName,dateOfBirth,contactNumber,emailId,companyName,webUrl,addressDetails,cityName,countryName,postCode,faxNumber,i,contactToAttach,contact;

@synthesize scannedContactImage,imageName,buffer;





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
     //NSLog(@"The detail is %@",self.detail);
    return self;
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    contact = [PFObject objectWithClassName:@"ContactRepo"];
}


-(void)takePhoto
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.scannedContactImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    NSString *name1 = [self.firstName.text stringByAppendingString:@" "];
    NSString *name2 = [name1 stringByAppendingString:self.lastName.text];
    
    
    NSArray *myStrings = [[NSArray alloc] initWithObjects: name2, self.contactNumber.text, nil];

    imageName = [myStrings componentsJoinedByString:@"|"];
    
   // NSLog(@"the image name is %@",imageName);
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.scannedContactImage.image)            forKey:imageName];

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void) addImage
{
    CamViewController *cam= [[CamViewController alloc] initWithNibName:@"CamViewController" bundle:nil];
    [self presentViewController:cam animated:YES completion:nil];
}


-(void) goBack
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *mainstoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainViewController = [mainstoryBoard instantiateInitialViewController];
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     // contact = [PFObject objectWithClassName:@"ContactRepo"];
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    
    // Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    
    
    
    
    NSUserDefaults *sud = [NSUserDefaults standardUserDefaults];
    NSString *myString = [sud stringForKey:@"Contact"];
  //  NSLog(@"The detail is %@",myString);
    
    NSArray *splitContact = [myString componentsSeparatedByString:@"|"];
    
    
    firstName.text = splitContact[0];
    lastName.text = splitContact[1];
    designation.text = splitContact[2];
    dateOfBirth.text = splitContact[3];
    contactNumber.text=splitContact[4];
    faxNumber.text=splitContact[5];
    emailId.text=splitContact[6];
    companyName.text=splitContact[7];
    
    //NSString *url = @"www.";
    //NSString *finalUrl = [url stringByAppendingString:splitContact[8]];
    webUrl.text=splitContact[8];
    addressDetails.text=splitContact[9];
    cityName.text=splitContact[10];
    countryName.text=splitContact[11];
    postCode.text=splitContact[12];
    
    
    /////
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    contactToAttach = [prefs stringForKey:@"ContactToAppend"];
    
    NSArray *contArr = [[NSArray alloc] initWithObjects: contactToAttach,contactNumber.text,nil];
    
    NSString *contactToBeSent = [contArr componentsJoinedByString:@"|"];
    
    //NSString *sendingContact = [contactToBeSent stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
    
    //
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs1 setObject:contactNumber.text forKey:@"FetchContact"];

    //
    
    // parse content
    
    

    
    
    //

    
  //  NSLog(@"Contact to send is %@",sendingContact);
    
    ////json is initiated here
    
    /*
    self.buffer = [NSMutableData data];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //instructionLabel.text=msg;
    
    [[session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://childcare.korra1.com/public/index.php/mobileapi/SetQrData?data=%@",sendingContact]]] resume];
    
    */
    ////
    
    NSString *docsDir;
    docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Contacts.sqlite"]];
    const char *dbPath = [databasePath UTF8String];
    
    if(sqlite3_open(dbPath, &contactDB)==SQLITE_OK)
    {
        char *errMsg;
        const char *sql_Stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (IMAGENAME TEXT, DESIGNATION TEXT, FIRSTNAME TEXT, LASTNAME TEXT, BIRTHDATE TEXT, CONTACTNUMBER TEXT, FAXNUMBER TEXT, EMAILID TEXT, COMPANYNAME TEXT, WEBSITE TEXT, ADDRESS TEXT, CITY TEXT, COUNTRY TEXT, POSTCODE TEXT)";
        
        if(sqlite3_exec(contactDB, sql_Stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create table");
        }
    }
    else{
        NSLog(@"Failed to open/create database");
    }
    
    [self prepareStatement];

}



-(void) prepareStatement
{
    NSString *sqlString;
    const char *sql_Stmt;
    
    //insert contact
    sqlString = [NSString stringWithFormat:@"INSERT INTO CONTACTS (imagename, designation, firstname, lastname, birthdate, contactnumber, faxnumber, emailid, companyname, website, address, city, country, postcode) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
    sql_Stmt = [sqlString UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt, -1, &insertStatement,NULL);
    
    //update contact
   // sqlString = [NSString stringWithFormat:@"UPDATE CONTACTS SET title = ? where "];
   // sql_Stmt = [sqlString UTF8String];
    //sqlite3_prepare_v2(contactDB, sql_Stmt, -1, &insertStatement,NULL);
    
    //retrieve contacts
    /*
    sqlString = [NSString stringWithFormat:@"SELECT title, firstname, lastname FROM contacts"];
    sql_Stmt = [sqlString UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt, -1, &selectStatement, NULL);
     */
    
    //search for contact
    /*
   sqlString = [NSString stringWithFormat:@"SELECT title, firstname, lastname FROM contacts where firstname = ?"];
    sql_Stmt = [sqlString UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt, -1, &selectContact, NULL);
*/
    }


///


-(void) saveContactFromOtherMobile
{
    
    ///
    
    NSString *docsDir;
    docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Contacts.sqlite"]];
    const char *dbPath = [databasePath UTF8String];
    
    if(sqlite3_open(dbPath, &contactDB)==SQLITE_OK)
    {
        char *errMsg;
        const char *sql_Stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (IMAGENAME TEXT, DESIGNATION TEXT, FIRSTNAME TEXT, LASTNAME TEXT, BIRTHDATE TEXT, CONTACTNUMBER TEXT, FAXNUMBER TEXT, EMAILID TEXT, COMPANYNAME TEXT, WEBSITE TEXT, ADDRESS TEXT, CITY TEXT, COUNTRY TEXT, POSTCODE TEXT)";
        
        if(sqlite3_exec(contactDB, sql_Stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create table");
        }
    }
    else{
        NSLog(@"Failed to open/create database");
    }
    
    ///
    
    NSString *sqlString;
    const char *sql_Stmt;
    
    //insert contact
    sqlString = [NSString stringWithFormat:@"INSERT INTO CONTACTS (imagename, designation, firstname, lastname, birthdate, contactnumber, faxnumber, emailid, companyname, website, address, city, country, postcode) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
    sql_Stmt = [sqlString UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt, -1, &insertStatement,NULL);
    
    ///
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *myString1 = [prefs stringForKey:@"RetrievedContact"];
    
   // NSLog(@"The retrieved contact is %@",myString1);

    NSArray *recdContact = [myString1 componentsSeparatedByString:@"|"];

    
    sqlite3_bind_text(insertStatement, 1, [self.imageName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 2, [recdContact[2] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 3, [recdContact[0] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 4, [recdContact[1] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 5, [recdContact[3] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 6, [recdContact[4] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 7, [recdContact[5] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 8, [recdContact[6] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 9, [recdContact[7] UTF8String], -1, SQLITE_TRANSIENT);
    
    ////
    sqlite3_bind_text(insertStatement, 10, [recdContact[8] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 11, [recdContact[9] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 12, [recdContact[10] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 13, [recdContact[11] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 14, [recdContact[12] UTF8String], -1, SQLITE_TRANSIENT);
    
    
    if(sqlite3_step(insertStatement) == SQLITE_DONE)
    {
        //NSLog(@"Contact is recieved");
        UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                                   
                                                             message:@"Contact Recieved"
                                   
                                                            delegate:self cancelButtonTitle:@"OK"
                                   
                                                   otherButtonTitles:nil];
        
        [alertPopUp show];
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

    }
    else
    {
        NSLog(@"Failed to add contact");
        UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                                   
                                                             message:@"Unable to recieve contact"
                                   
                                                            delegate:self cancelButtonTitle:@"OK"
                                   
                                                   otherButtonTitles:nil];
        
        [alertPopUp show];
    }
    sqlite3_reset(insertStatement);
    sqlite3_clear_bindings(insertStatement);
    
    //
    
    NSString *name1 = [self.firstName.text stringByAppendingString:@" "];
    NSString *name2 = [name1 stringByAppendingString:self.lastName.text];
    
    
    NSArray *myStrings = [[NSArray alloc] initWithObjects: name2, self.contactNumber.text, nil];
    
    imageName = [myStrings componentsJoinedByString:@"|"];
    
    //NSLog(@"the image name is %@",imageName);
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.scannedContactImage.image)            forKey:imageName];
    
    //
    [self findContact];
}


///

-(void) delContact
{
    [self viewDidLoad];
    //[contact deleteInBackground];
    //[PFObject deleteAllInBackground:@[contact]];
    
    //contact = [PFObject objectWithClassName:@"ContactRepo"];
    [contact deleteInBackground];
}


-(void) saveContact
{
    contact = [PFObject objectWithClassName:@"ContactExchange"];

    //parse
    {
        
        //contact = [PFObject objectWithClassName:@"ContactRepo"];
        contact[@"contact_data"]=contactToAttach;
        contact[@"contact_sendTo"]=contactNumber.text;
        [contact saveInBackground ];
    }
    
    /*
    //NSLog(@"");
      //[contact deleteInBackground];
    
    //adding delay timer to delete
    
    double delayInSeconds = 15.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       
        [contact deleteInBackground];
        
    });
     */


    
    
    //fn mod
    
    NSString *fullName = firstName.text;
    fullName = [fullName stringByAppendingString:@" "];
    fullName = [fullName stringByAppendingString:lastName.text];
    
    //
    sqlite3_bind_text(insertStatement, 1, [self.imageName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 2, [designation.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 3, [fullName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 4, [lastName.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 5, [dateOfBirth.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 6, [contactNumber.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 7, [faxNumber.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 8, [emailId.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 9, [companyName.text UTF8String], -1, SQLITE_TRANSIENT);
    
    ////
    
    // NSString *website=@"www.";
    // site = [website stringByAppendingString:site];
    
    ////
    
    sqlite3_bind_text(insertStatement, 10, [webUrl.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 11, [addressDetails.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 12, [cityName.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 13, [countryName.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 14, [postCode.text UTF8String], -1, SQLITE_TRANSIENT);

    
    if(sqlite3_step(insertStatement) == SQLITE_DONE)
    {
        NSLog(@"Contact is added");
        UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                                   
                                                             message:@"Contact Saved"
                                   
                                                            delegate:self cancelButtonTitle:@"OK"
                                   
                                                   otherButtonTitles:nil];
        
        [alertPopUp show];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        //
        
        NSString * storyboardName = @"Main";
        NSString * viewControllerID = @"ContactNav";
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        UINavigationController * controller = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
        [self presentViewController:controller animated:YES completion:nil];
        
        //

    }
    else
    {
        NSLog(@"Failed to add contact");
        UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                                   
                                                             message:@"Unable to save contact"
                                   
                                                            delegate:self cancelButtonTitle:@"Ok"
                                   
                                                   otherButtonTitles:nil];
        
        [alertPopUp show];
        SCViewController *scan = [self.storyboard instantiateViewControllerWithIdentifier:@"Scan"];
        [self presentViewController:scan animated:YES completion:nil];

    }
    sqlite3_reset(insertStatement);
    sqlite3_clear_bindings(insertStatement);
    
    //
    
    NSString *name1 = [self.firstName.text stringByAppendingString:@" "];
    NSString *name2 = [name1 stringByAppendingString:self.lastName.text];
    
    
    NSArray *myStrings = [[NSArray alloc] initWithObjects: name2, self.contactNumber.text, nil];
    
    imageName = [myStrings componentsJoinedByString:@"|"];
    
    NSLog(@"the image name is %@",imageName);
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.scannedContactImage.image)            forKey:imageName];
    
    //
    [self findContact];
}

-(void) findContact


{
    [self viewDidLoad];
    
    NSString *sqlString1;
    const char *sql_Stmt1;
    //int rc=0;
    sqlString1 = [NSString stringWithFormat:@"SELECT designation, firstname, lastname FROM contacts order by firstname"];
    sql_Stmt1 = [sqlString1 UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt1, -1, &selectStatement, NULL);
    
   // sqlite3_bind_text(selectStatement, 1, <#const char *#>, <#int n#>, <#void (*)(void *)#>)
    
    if(sqlite3_step(selectStatement) == SQLITE_ROW)
    //if(rc==SQLITE_OK)
    {
   // NSString *personDesignation;
   // NSString *personFirstName; NSString *personLastName;
    NSMutableArray *contArr = [[NSMutableArray alloc] init];
        
    //personDesignation = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(selectStatement, 0)];
    //personFirstName = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(selectStatement, 1)];
    //personLastName = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(selectStatement, 2)];
        
        /*
        while(sqlite3_step(selectStatement) == SQLITE_ROW) {
            int rowid = sqlite3_column_int(selectStatement, 1);
            NSString * name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            //contArr = [NSArray arrayWithObject:name];
            [contArr addObject:name];
            NSLog(@"The names are %@",name);
         }
           */
        
        
        /*
        
        NSString *name1 = [self.firstName.text stringByAppendingString:@" "];
        NSString *name2 = [name1 stringByAppendingString:self.lastName.text];
        
        */
        
        do
        {
            //1 is changed from 2
            
        //    int rowid = sqlite3_column_int(selectStatement, 1);
            NSString * name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            NSString * name1 = [NSString stringWithUTF8String:(char *) sqlite3_column_text(selectStatement, 2)];
            //contArr = [NSArray arrayWithObject:name];
            
            NSString *name2 = [name stringByAppendingString:@" "];
         //   NSString *name3 = [name2 stringByAppendingString:name1];
            [contArr addObject:name]; //name3 to name
        //    NSLog(@"The names are %@",name1);
            
        } while (sqlite3_step(selectStatement) == SQLITE_ROW);
    
        // NSLog(@"The name array is %@",contArr);
         [[NSUserDefaults standardUserDefaults] setObject:contArr forKey:@"ListOfContactArray"];
         [[NSUserDefaults standardUserDefaults] synchronize];
    /*
    
    NSMutableArray *contactArray = [[NSMutableArray alloc] init];
    
    NSDictionary *contactDict = [NSDictionary dictionaryWithObjectsAndKeys:personTitle,@"PersonTitle",personFirstName,@"PersonFirstName",personLastName,@"PersonLastName",nil];
    [contactArray addObject:contactDict];
        
        NSLog(@"The dict is %@",[contactDict description]);
    
    retrievePFN = [[contactDict valueForKey:@"PersonFirstName"] objectAtIndex:1];
    //NSLog(@"The name is %@", retrievePFN);
    
    //  NSString *addressField = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
     */
    }
    else{
        NSLog(@"Fail to fetch");
    }
    sqlite3_reset(selectStatement);
    sqlite3_clear_bindings(selectStatement);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getContactDetails
{
    [self viewDidLoad];
    
    NSString *sqlString2;
    const char *sql_Stmt2;
     sqlite3_stmt *selectContact;

    //int rc=0;
    sqlString2 = [NSString stringWithFormat:@"SELECT imagename, designation, firstname, lastname, birthdate, contactnumber, faxnumber, emailid, companyname, website, address, city, country, postcode FROM contacts where firstname = ? order by firstname"];
    sql_Stmt2 = [sqlString2 UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt2, -1, &selectContact, NULL);
    
     
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *selCont = [prefs stringForKey:@"SelectedContact"];
    
   // NSLog(@"CDV is %@",selCont);
    
    sqlite3_bind_text(selectContact, 1, [selCont UTF8String], -1, SQLITE_TRANSIENT);
    
    if(sqlite3_step(selectContact)==SQLITE_ROW)
    {
        NSString *pDesignation=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 1)];
        NSString *fname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 2)];
        NSString *lname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 3)];
        NSString *dob = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 4)];
        NSString *contNum = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 5)];
        NSString *faxNum = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 6)];
        NSString *email = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 7)];
        NSString *compName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 8)];
        NSString *website = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 9)];
        NSString *address = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 10)];
        NSString *city = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 11)];
        NSString *country = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 12)];
        NSString *postcode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 13)];
        
        NSArray *selectedContactDetails = [[NSArray alloc] initWithObjects: pDesignation,fname,lname,dob,contNum,faxNum,email,compName,website,address,city,country,postcode, nil];
        NSString *totalContactDetails = [selectedContactDetails componentsJoinedByString:@"&&"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        // saving an NSString
        [prefs setObject:totalContactDetails forKey:@"ContactToBeSent"];
        
    }
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
