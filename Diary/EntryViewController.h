//
//  NewEntryViewController.h
//  Diary
//
//  Created by Chloe on 2015-12-30.
//  Copyright © 2015 Chloe Horgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiaryEntry;

@interface EntryViewController : UIViewController

@property (strong, nonatomic) DiaryEntry *entry;

@end
