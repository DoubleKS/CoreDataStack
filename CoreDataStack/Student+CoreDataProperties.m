//
//  Student+CoreDataProperties.m
//  CoreDataStack
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;

@end
