//
//  ListOfContactsViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 13/8/14.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ListOfContactsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
}
@property (strong,nonatomic) NSArray *contactArray;
@property (strong,nonatomic) NSArray *searchResults;
@end
