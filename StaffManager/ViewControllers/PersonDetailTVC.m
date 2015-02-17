//
//  PersonDetailTVC.m
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "PersonDetailTVC.h"
#import "Person.h"
#import "Role.h"

@interface PersonDetailTVC () <UITextFieldDelegate>
@end

@implementation PersonDetailTVC

@synthesize person= _person;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"Setting the value of fields in this static table to that of the passed Person");
    // self.personNameTextField.text= self.person.firstname;
    self.personFirstnameTextField.text= self.person.firstname;
    self.personSurnameTextField.text= self.person.surname;
    self.personRoleTableViewCell.textLabel.text= self.person.inRole.name;
    self.selectedRole= self.person.inRole;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    // [self setPersonNameTextField:nil];
    [super viewDidDisappear:animated];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the PersonDetailTVC Delegate that Save was tapped on the PersonDetailTVC");
    
    self.person.firstname = self.personFirstnameTextField.text; // Set Firstname
    self.person.surname = self.personSurnameTextField.text; // Set Surname
    [self.person setInRole:self.selectedRole]; // Set Relationship!!!
    [self.managedObjectContext save:nil];  // write to database
    [self.delegate theSaveButtonOnTheAddPersonTVCWasTapped:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender  // !
{
    if ([segue.identifier isEqualToString:@"Person Role Segue"])
	{
        NSLog(@"Setting PersonDetailTVC as a delegate of PersonRoleTVC");
        PersonRoleTVC *personRoleTVC = segue.destinationViewController;
        personRoleTVC.delegate = self;
        personRoleTVC.managedObjectContext = self.managedObjectContext;
	}
    else {
        NSLog(@"Unidentified Segue Attempted!");
    }
}

- (void)roleWasSelectedOnPersonRoleTVC:(PersonRoleTVC *)controller
{
    self.personRoleTableViewCell.textLabel.text = controller.selectedRole.name;
    self.selectedRole = controller.selectedRole;
    NSLog(@"PersonDetailTVC reports that the %@ role was selected on the PersonRoleTVC", controller.selectedRole.name);
    [controller.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITextFieldDelegate metode

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
