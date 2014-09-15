//
//  MasterViewController.m
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "ContactDetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    
    
        NSArray *convertedContactArray;
        NSArray *convertedSearchResults;
    
    
}
@end

@implementation MasterViewController
@synthesize contactArray,searchResults,window;
@synthesize mySearchBar,myTableView,isFiltered;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void) goBack
    {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        UIStoryboard *mainstoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *mainViewController = [mainstoryBoard instantiateInitialViewController];
        //[mainstoryBoard release];
        self.window.rootViewController = mainViewController;
        [self.window makeKeyAndVisible];
        
    }
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResults = [NSMutableArray arrayWithArray: [self.contactArray filteredArrayUsingPredicate:resultPredicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ContactDetailViewController *cd = [[ContactDetailViewController alloc] init];
    [cd findContact];
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    
    //
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
   // self.searchDisplayController.searchResultsDelegate = self;
    
    contactArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"ListOfContactArray"] mutableCopy];
  //  NSLog(@"The contact array is %@",contactArray);
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.contactArray count]];
    
    convertedContactArray = [contactArray copy];
   // NSLog(@"The converted contact array is %@",convertedContactArray);
    
    //// to conver
    
    NSMutableArray *sortArray = [convertedContactArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    ////
    
    myTableView.backgroundView =
    [[UIImageView alloc]initWithImage:
     [[UIImage imageNamed:@"retina_wood.png"] stretchableImageWithLeftCapWidth:0.0
                                                                 topCapHeight:5.0]];
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
       

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSArray *sourceArray;
        NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:(UITableViewCell *)sender];
        
        if (indexPath != nil)
        {
            sourceArray = self.searchResults;
            
        }
        else
        {
            indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
            sourceArray = self.contactArray;
           
        }
       // [sourceArray release];

    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    }
    else
    {
        return [self.contactArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"retina_wood.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"retina_wood.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = self.contactArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellLabelText = cell.textLabel.text;
    //NSLog(@"The selected contact is %@",cellLabelText);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:cellLabelText forKey:@"SelectedContact"];
    
    [myTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
