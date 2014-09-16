//
//  MyQRViewController.m
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import "MyQRViewController.h"
#import "ContactDetailViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#include <Parse/Parse.h>

@interface MyQRViewController ()

@end

@implementation MyQRViewController

@synthesize MyQR,window,qrStat,buffer,timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyQR1"];
    MyQR.image = [UIImage imageWithData:imageData];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
    if(MyQR.image == NULL)
    {
        qrStat.text =@"NO QR Code";
        [self.save setHidden:true];
        [self.back setHidden:false];
        [self.qrHead setHidden:true];
    }
    else
    {
        [self.save setHidden:false];
        [self.back setHidden:false];
        [self.qrHead setHidden:false];
        
        
        
        
        
            timer = [NSTimer scheduledTimerWithTimeInterval: 5
                                                     target: self
                                                   selector: @selector(recContact)
                                                   userInfo: nil
                                                    repeats: YES];
             
      
            
        
    }
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}


-(void) recContact
{
    
    NSUserDefaults *prefsCont = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *myContactNumber = [prefsCont stringForKey:@"MyContactNumber"];
    
   // NSPredicate *pred = [NSPredicate predicateWithFormat:@"contact_sendTo = %@", myContactNumber];
    
   // PFQuery *q = [PFQuery queryWithClassName:@"ContactExchange" predicate:pred];
   // [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
    PFQuery *pf = [PFQuery queryWithClassName:@"ContactExchange"];
    [pf whereKey:@"contact_sendTo" equalTo:myContactNumber];
    
     [pf getFirstObjectInBackgroundWithBlock :^(PFObject *object, NSError *error) {
    //[pf findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        
        if(!error)
        {
            
            NSLog(@"the new contact is %@",object[@"contact_data"]);
            
            
            [self.timer invalidate];
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            NSString *recievedContact = object[@"contact_data"];
            
            // saving an NSString
            [prefs setObject:recievedContact forKey:@"Contact"];
            
            
            UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *tvc = [st instantiateViewControllerWithIdentifier:@"ContactDetails"];
            [self presentViewController:tvc animated:YES completion:nil];
            
            
        }
        else
        {
            NSLog(@"Error: %@",[error userInfo]);
        }
    
    }];
    
   
        
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *newContact = [prefs stringForKey:@"Contact"];
    
    NSLog(@"New Contact is %@",newContact);
    
    
    //delete query after recieving the contact
    
    
    PFQuery *query1= [PFQuery queryWithClassName:@"ContactExchange"];
    [query1 whereKey:@"contact_sendTo" equalTo:myContactNumber];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error)
        {
            for (PFObject *object in objects) {
                [object deleteInBackground];
            }
        }
    }];
    
}

-(void) json
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *myContact = [prefs stringForKey:@"ContactToSearch"];
    
    self.buffer = [NSMutableData data];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    
    [[session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://childcare.korra1.com/public/index.php/mobileapi/GetQRData?mobile=%@",myContact]]] resume];
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [buffer appendData:data];
    //NSLog(@"the data from server is %@",buffer);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
      //  NSLog(@"Download is Succesfull");
        NSString *dataString = [[NSString alloc] initWithData:buffer encoding:NSASCIIStringEncoding];
       // NSLog(@"In session task %@",dataString);
        
        
        if(![dataString isEqualToString:@"no data"])
        {
            [self.timer invalidate];
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            // saving an NSString
            [prefs setObject:dataString forKey:@"RetrievedContact"];
            
            
           
            
            NSString * storyboardName = @"Contacts";
            NSString * viewControllerID = @"ContactNav";
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
            UINavigationController * controller = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
            [self presentViewController:controller animated:YES completion:nil];
            
            ContactDetailViewController * cd = [[ContactDetailViewController alloc] init];
            [cd saveContactFromOtherMobile];
            
            
        }
        
    }
    
    else
    {
        
    }
    
}
       // NSLog(@"Error %@",[error userInfo]);


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) saveQR
{
    UIImageWriteToSavedPhotosAlbum(MyQR.image, nil, nil, nil);
    
    UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                               
                                                         message:@"QR code Saved to Album"
                               
                                                        delegate:self cancelButtonTitle:@"OK"
                               
                                               otherButtonTitles:nil];
    
    [alertPopUp show];
}

-(void) goBack
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *mainstoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainViewController = [mainstoryBoard instantiateInitialViewController];
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
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
