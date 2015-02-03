//
//  AddPersonTVC.m
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//
#import "AddPersonTVC.h"
#import "Person.h"

@interface AddPersonTVC () <UITextFieldDelegate>

@end

@implementation AddPersonTVC

@synthesize managedObjectContext= _managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - IBAction metode

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddPersonTVC Delegate that Save was tapped on the AddPersonTVC");
    
    Person *person= [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                              inManagedObjectContext:self.managedObjectContext];
    
    // person.firstname= self.personNameTextField.text;
    person.firstname= self.personFirstnameTextField.text;
    person.surname= self.personSurnameTextField.text;
    
    [self.managedObjectContext save:nil];
    
    [self.delegate theSaveButtonOnTheAddPersonTVCWasTapped:self];
}

#pragma mark - UITextFieldDelegate metode

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
