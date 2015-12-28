//
//  DiaryEntry+CoreDataProperties.m
//  Diary
//
//  Created by Chloe on 2015-12-28.
//  Copyright © 2015 Chloe Horgan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DiaryEntry+CoreDataProperties.h"

@implementation DiaryEntry (CoreDataProperties)

@dynamic date;
@dynamic body;
@dynamic image;
@dynamic mood;
@dynamic location;

@end
