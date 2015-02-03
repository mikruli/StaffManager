//
//  PersonTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class Person;

@interface PersonTVC : CoreDataTableViewController
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Person *selectedPerson;
@end
