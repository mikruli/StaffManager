//
//  RolesTVC.m
//  StaffManager
//
//  Created by Dejan Kumric on 1/31/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "RolesTVC.h"
#import "AddRoleTVC.h"
#import "Role.h"
#import "RoleDetailTVC.h"

@interface RolesTVC () <AddRoleTVCDelegate, RoleDetailTVCDelegate>

@end

@implementation RolesTVC

@synthesize searchResults= _searchResults;

#pragma mark - ViewController postavke

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[[self.fetchedResultsController fetchedObjects] count]];
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}

#pragma mark - Povlacenje podataka iz baze

- (void)setupFetchedResultsController
{
    // 1 - Decide what entity you want
    NSString *entityName= @"Role"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request the Entity
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter if you want
    // request.predicate= [NSPredicate predicateWithFormat:@"Role.name= Blah"];
    
    // 4 - Sort if you want
    request.sortDescriptors= [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                                    ascending:YES
                                                                                     selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController= [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                       managedObjectContext:self.managedObjectContext
                                                                         sectionNameKeyPath:nil
                                                                                  cacheName:nil];
    [self performFetch];
    
}

#pragma mark - TableView Data Source metode

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    }
    else
    {
        return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier= @"Roles Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ( cell == nil ) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    Role *role = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        NSLog(@"Configuring cell to show search results");
        role = [self.searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        NSLog(@"Configuring cell to show normal data");
        role = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    cell.textLabel.text= role.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        
        // self.suspendAutomaticTrackingOfChangesInManagedObjectContext= YES;
        
        // [self.tableView beginUpdates]; // Avoid NSinteralInconsistencyException
        
        // Delete the role object that was swiped
        
        Role *roleToDelete= [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Deleting (%@)", roleToDelete.name);
        [self.managedObjectContext deleteObject:roleToDelete];
        [self.managedObjectContext save:nil];
        
        // Delete the (now empty) row on the table
        // [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // [self performFetch];
        
        // [self.tableView endUpdates];
        // self.suspendAutomaticTrackingOfChangesInManagedObjectContext= NO;
    }
}

#pragma mark - Prepare for segue i delagate protokol metoda

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"Add Role Segue"] ) {
        
        NSLog(@"Setting RolesTVC as a delegate of AddRoleTVC");
        
        AddRoleTVC *addRoleTVC= segue.destinationViewController;
        addRoleTVC.delegate= self;
        addRoleTVC.managedObjectContext= self.managedObjectContext;
    } else if ( [segue.identifier isEqualToString:@"Role Detail Segue"] ) {
        
        NSLog(@"Setting RolesTVC as a delegate of RoleDetailTVC");
        
        RoleDetailTVC *roleDetailTVC= segue.destinationViewController;
        roleDetailTVC.delegate= self;
        roleDetailTVC.managedObjectContext= self.managedObjectContext;
        
        // Store selected Role in selectedRole property
        NSIndexPath *indexPath= [self.tableView indexPathForSelectedRow];
        self.selectedRole= [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSLog(@"Passing selected role (%@) to RoleDetailTVC", self.selectedRole.name);
        roleDetailTVC.role= self.selectedRole;
        
    } else {
        NSLog(@"Unidentified Segue Attempted!");
    }
}

- (void)theSaveButtonOnTheAddRoleTVCWasTapped:(AddRoleTVC *)controller
{
    // do something here like refreshing the table or whatever
    
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSLog(@"Previous Search Results were removed.");
    [self.searchResults removeAllObjects];
    
    for (Role *role in [self.fetchedResultsController fetchedObjects])
    {
        if ([scope isEqualToString:@"All"] || [role.name isEqualToString:scope])
        {
            NSComparisonResult result = [role.name compare:searchText
                                                   options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                     range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                NSLog(@"Adding role.name '%@' to searchResults as it begins with search text '%@'", role.name, searchText);
                [self.searchResults addObject:role];
            }
        }
    }
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:@"All"];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:@"All"];
    return YES;
}

@end
