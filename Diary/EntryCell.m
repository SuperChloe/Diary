//
//  EntryCell.m
//  Diary
//
//  Created by Chloe on 2015-12-31.
//  Copyright © 2015 Chloe Horgan. All rights reserved.
//

#import "EntryCell.h"
#import "DiaryEntry.h"

@interface EntryCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *moodImageView;

@end

@implementation EntryCell

+ (CGFloat)heightForEntry:(DiaryEntry *)entry {
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 39.0f;
    const CGFloat minHeight = 85.0f;
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGRect boundingBox = [entry.body boundingRectWithSize:CGSizeMake(220, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    
    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
    
}

- (void)configureCellForEntry:(DiaryEntry *)entry {
    self.bodyLabel.text = entry.body;
    self.locationLabel.text = entry.location;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMMM, d yyyy"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:entry.date];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
}

// Boiler plate code...


//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
