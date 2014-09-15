//
//  ListOfContacts.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//
//

#import <UIKit/UIKit.h>

@interface ListOfContacts : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>

@property (strong,nonatomic) NSArray *contactArray;
@property (strong,nonatomic) NSArray *searchResults;
@property (strong, nonatomic) id detailItem;
@end
