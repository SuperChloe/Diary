//
//  DiaryEntry.h
//  Diary
//
//  Created by Chloe on 2015-12-28.
//  Copyright © 2015 Chloe Horgan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

NS_ENUM(int16_t, DiaryEntryMood) {
    DiaryEntryMoodGood = 0,
    DiaryEntryMoodAverage = 1,
    DiaryEntryMoodBad = 2
};

@interface DiaryEntry : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "DiaryEntry+CoreDataProperties.h"
