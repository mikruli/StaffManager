//
//  RoleDetailTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/1/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Role;

@class RoleDetailTVC;
@protocol RoleDetailTVCDelegate <NSObject>
- (void)theSaveButtonOnTheAddRoleTVCWasTapped:(RoleDetailTVC *)controller;
@end

@interface RoleDetailTVC : UITableViewController
@property (weak, nonatomic) id <RoleDetailTVCDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *roleNameTextField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Role *role;
- (IBAction)save:(id)sender;
@end
