//
//  DiaryEntry+CoreDataProperties.h
//  Diary
//
//  Created by Chloe on 2015-12-28.
//  Copyright © 2015 Chloe Horgan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DiaryEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiaryEntry (CoreDataProperties)

@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSData *image;
@property (nonatomic) int16_t mood;
@property (nullable, nonatomic, retain) NSString *location;

@end

NS_ASSUME_NONNULL_END
