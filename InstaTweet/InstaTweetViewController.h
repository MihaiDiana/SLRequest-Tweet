//
//  InstaTweetViewController.h
//  InstaTweet
//
//  Created by Alex Trott on 19/10/2012.
//  Copyright (c) 2012 Alex Trott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaTweetViewController : UIViewController <UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet UILabel *charCounter;


- (IBAction)sharePost:(id)sender;


@end
