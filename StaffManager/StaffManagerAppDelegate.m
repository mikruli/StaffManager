//
//  StaffManagerAppDelegate.m
//  StaffManager
//
//  Created by Dejan Kumric on 1/31/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "StaffManagerAppDelegate.h"

#import "Role.h"
#import "RolesTVC.h"
#import "PersonTVC.h"

@implementation StaffManagerAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsController= _fetchedResultsController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self setupFetchedResultsController];
    
    if ( ![[self.fetchedResultsController fetchedObjects] count] > 0 ) {
        NSLog(@"!!!!! --> There's nothing in the database so defaults will be inserted");
        [self importCoreDataDefaultRoles];
    } else {
        NSLog(@"There's stuff in the database so skipping the import of default data");
    }
    
    // Override point for customization after application launch.
    /*
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    RolesTVC *controller = (RolesTVC *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
     */
    //
    
    // The Tab Bar
    UITabBarController *tabBarController= (UITabBarController *)self.window.rootViewController;
    
    // The Two Navigation Controllers attached to the Tab Bar (At Tab Bar Indexes 0 and 1)
    UINavigationController *personsTVCnav= [[tabBarController viewControllers] objectAtIndex:1];
    UINavigationController *rolesTVCnav= [[tabBarController viewControllers] objectAtIndex:0];
    
    // The Persons Table View Controller (Second Nav Controller Index 1)
    PersonTVC *personsTVC= [[personsTVCnav viewControllers] objectAtIndex:0];
    personsTVC.managedObjectContext= self.managedObjectContext;
    
    // The Roles Table View Controller (First Nav Controller Index 0)
    RolesTVC *rolesTVC= [[rolesTVCnav viewControllers] objectAtIndex:0];
    rolesTVC.managedObjectContext= self.managedObjectContext;
    
    return YES;
}

- (void)insertRoleWithRoleName:(NSString *)roleName
{
    Role *role = [NSEntityDescription insertNewObjectForEntityForName:@"Role"
                                               inManagedObjectContext:self.managedObjectContext];
    
    role.name = roleName;
    
    [self.managedObjectContext save:nil];
}

- (void)importCoreDataDefaultRoles {
    
    NSLog(@"Importing Core Data Default Values for Roles...");
    [self insertRoleWithRoleName:@"C/C++ Developer"];
    [self insertRoleWithRoleName:@"Obj-C Developer"];
    [self insertRoleWithRoleName:@"Java Developer"];
    [self insertRoleWithRoleName:@"ASP.NET Developer"];
    [self insertRoleWithRoleName:@"Unix Engineer"];
    [self insertRoleWithRoleName:@"Windows Engineer"];
    [self insertRoleWithRoleName:@"Business Analyst"];
    [self insertRoleWithRoleName:@"Infrastructure Manager"];
    [self insertRoleWithRoleName:@"Project Manager"];
    [self insertRoleWithRoleName:@"Operations Manager"];
    [self insertRoleWithRoleName:@"Desktop Support Analyst"];
    [self insertRoleWithRoleName:@"Chief Information Officer"];
    NSLog(@"Importing Core Data Default Values for Roles Completed!");
}

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
    [self.fetchedResultsController performFetch:nil];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"StaffManager.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options= [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
