//
//  PersonTVC.m
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "PersonTVC.h"
#import "AddPersonTVC.h"
#import "Person.h"
#import "PersonDetailTVC.h"

@interface PersonTVC () <AddPersonTVCDelegate, PersonDetailTVCDelegate>

@end

@implementation PersonTVC

#pragma mark - ViewController postavke

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSString *entityName= @"Person"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request the Entity
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter if you want
    // request.predicate= [NSPredicate predicateWithFormat:@"Person.name= Blah"];
    
    // 4 - Sort if you want
    request.sortDescriptors= [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"firstname"
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier= @"Persons Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ( cell == nil ) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    Person *person= [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *fullName= [NSString stringWithFormat:@"%@ %@", person.firstname, person.surname];
    cell.textLabel.text= fullName;
    cell.detailTextLabel.text= person.inRole.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        
        // self.suspendAutomaticTrackingOfChangesInManagedObjectContext= YES;
        
        // [self.tableView beginUpdates]; // Avoid NSinteralInconsistencyException
        
        // Delete the person object that was swiped
        
        Person *personToDelete= [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Deleting (%@)", personToDelete.firstname);
        [self.managedObjectContext deleteObject:personToDelete];
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
    if ( [segue.identifier isEqualToString:@"Add Person Segue"] ) {
        
        NSLog(@"Setting PersonsTVC as a delegate of AddPersonTVC");
        
        AddPersonTVC *addPersonTVC= segue.destinationViewController;
        addPersonTVC.delegate= self;
        addPersonTVC.managedObjectContext= self.managedObjectContext;
    } else if ( [segue.identifier isEqualToString:@"Person Detail Segue"] ) {
        
        NSLog(@"Setting PersonsTVC as a delegate of PersonDetailTVC");
        
        PersonDetailTVC *personDetailTVC= segue.destinationViewController;
        personDetailTVC.delegate= self;
        personDetailTVC.managedObjectContext= self.managedObjectContext;
        
        // Store selected Person in selectedPerson property
        NSIndexPath *indexPath= [self.tableView indexPathForSelectedRow];
        self.selectedPerson= [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSLog(@"Passing selected person (%@) to PersonDetailTVC", self.selectedPerson.firstname);
        personDetailTVC.person= self.selectedPerson;
        
    } else {
        NSLog(@"Unidentified Segue Attempted!");
    }
}

- (void)theSaveButtonOnTheAddPersonTVCWasTapped:(AddPersonTVC *)controller
{
    // do something here like refreshing the table or whatever
    
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];
}

@end
