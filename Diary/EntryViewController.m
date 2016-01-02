    //
//  NewEntryViewController.m
//  Diary
//
//  Created by Chloe on 2015-12-30.
//  Copyright © 2015 Chloe Horgan. All rights reserved.
//

#import "EntryViewController.h"
#import "DiaryEntry.h"
#import "CoreDataStack.h"

@interface EntryViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIImage *pickedImage;

@property (assign, nonatomic) enum DiaryEntryMood pickedMood;
@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *averageButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (strong, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;





@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date;
    
    if (self.entry != nil) {
        self.textView.text = self.entry.body;
        self.pickedMood = self.entry.mood;
        date = [NSDate dateWithTimeIntervalSince1970:self.entry.date];
    } else {
        self.pickedMood = DiaryEntryMoodGood;
        date = [NSDate date];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    self.textView.inputAccessoryView = self.accessoryView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissSelf {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertDiaryEntry {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    DiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryEntry" inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.body = self.textView.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    entry.mood = self.pickedMood;
    entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    [coreDataStack saveContext];
}

- (void)updateDiaryEntry {
    self.entry.body = self.textView.text;
    self.entry.mood = self.pickedMood;
    self.entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
}

- (void)promptForSource {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Image Source"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self promptForCamera];
                                                          }];
    UIAlertAction *photoRoll = [UIAlertAction actionWithTitle:@"Photo Roll" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [self promptForPhotoRoll];
                                                   }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:camera];
    [alert addAction:photoRoll];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)promptForCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)promptForPhotoRoll {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setPickedMood:(enum DiaryEntryMood)pickedMood {
    _pickedMood = pickedMood;
    
    self.badButton.alpha = 0.5f;
    self.averageButton.alpha = 0.5f;
    self.goodButton.alpha = 0.5f;
    
    switch (pickedMood) {
        case DiaryEntryMoodGood:
            self.goodButton.alpha = 1.0f;
            break;
            
        case DiaryEntryMoodAverage:
            self.averageButton.alpha = 1.0f;
            break;
        
        case DiaryEntryMoodBad:
            self.badButton.alpha = 1.0f;
            break;
    }
}

- (void)setPickedImage:(UIImage *)pickedImage {
    _pickedImage = pickedImage;
    
    if (pickedImage == nil) {
        [self.imageButton setImage:[UIImage imageNamed:@"icn_noimage"] forState:UIControlStateNormal];
    } else {
    [self.imageButton setImage:pickedImage forState:UIControlStateNormal];
    }
}

- (IBAction)doneWasPressed:(id)sender {
    if (self.entry != nil) {
        [self updateDiaryEntry];
    } else {
        [self insertDiaryEntry];
    
    }
        [self dismissSelf];
}

- (IBAction)cancelWasPressed:(id)sender {
    [self dismissSelf];
}

- (IBAction)badWasPressed:(id)sender {
    self.pickedMood = DiaryEntryMoodBad;
}
- (IBAction)averageWasPressed:(id)sender {
    self.pickedMood = DiaryEntryMoodAverage;
}
- (IBAction)goodWasPressed:(id)sender {
    self.pickedMood = DiaryEntryMoodGood;
}

- (IBAction)imageButtonWasPressed:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self promptForSource];
    } else {
        [self promptForPhotoRoll];
    }
}



@end
