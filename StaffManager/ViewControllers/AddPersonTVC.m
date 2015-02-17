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

@synthesize selectedRole= _selectedRole;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.personRoleTVCell.textLabel.text = @"";
    self.personRoleTVCell.delegate = self;
    self.personRoleTVCell.managedObjectContext = self.managedObjectContext;
}
- (void)roleWasSelectedOnPicker:(Role *)role {
    
    self.selectedRole = role;
    self.personRoleTVCell.textLabel.text = self.selectedRole.name;
    NSLog(@"AddPersonTVC has set '%@' as the Selected Role", self.selectedRole.name);
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
    person.inRole= self.selectedRole;
    
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
