//
//  MasterViewController.h
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong,nonatomic) NSMutableArray *contactArray;
@property (strong,nonatomic) NSMutableArray *searchResults;

@property (strong, nonatomic) UIWindow *window;
-(IBAction)goBack;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property BOOL isFiltered;

@end
