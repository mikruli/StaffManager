//
//  Role.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Role : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *heldBy;
@end

@interface Role (CoreDataGeneratedAccessors)

- (void)addHeldByObject:(Person *)value;
- (void)removeHeldByObject:(Person *)value;
- (void)addHeldBy:(NSSet *)values;
- (void)removeHeldBy:(NSSet *)values;

@end
