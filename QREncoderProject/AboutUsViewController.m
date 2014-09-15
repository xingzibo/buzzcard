//
//  AboutUsViewController.m
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import "AboutUsViewController.h"

#import "MyQRViewController.h"

#import "SCViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) myBuzzCard
{
 //   MyQRViewController *myQR = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQRView"];
   // [self.navigationController presentViewController:myQR animated:YES completion:nil];
    //[self presentViewController:myQR animated:YES completion:nil];
}

-(void) buzzCardScan
{
    SCViewController *scan = [self.storyboard instantiateViewControllerWithIdentifier:@"Scan"];
    [self presentViewController:scan animated:YES completion:nil];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
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
