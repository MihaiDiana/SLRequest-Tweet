//
//  InstaTweetViewController.m
//  InstaTweet
//
//  Created by Alex Trott on 19/10/2012.
//  Copyright (c) 2012 Alex Trott. All rights reserved.
//

#import "InstaTweetViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface InstaTweetViewController ()

@end

@implementation InstaTweetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	_postText.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [_postText becomeFirstResponder];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger length;
    length = [_postText.text length];
    NSInteger number;
    number = 140-length;
    _charCounter.text = [NSString stringWithFormat:@"%u", number];
    
    if (length >= 141) {
        _charCounter.text = [NSString stringWithFormat:@"nope"];
        
    }
}


- (IBAction)sharePost:(id)sender {
    NSString *post = [NSString stringWithFormat:@"%@", _postText.text];
    
    if (post.length >= 141) {
        NSLog(@"Tweet won't be sent.");
    } else {
        ACAccountStore *accountStoreTw = [[ACAccountStore alloc] init];
        
        ACAccountType *accountTypeTw = [accountStoreTw accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [accountStoreTw requestAccessToAccountsWithType:accountTypeTw options:NULL completion:^(BOOL granted, NSError *error) {
            if(granted) {
                
                NSArray *accountsArray = [accountStoreTw accountsWithAccountType:accountTypeTw];
                
                if ([accountsArray count] > 0) {
                    ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                    
                    SLRequest* twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                   requestMethod:SLRequestMethodPOST
                                                                             URL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"]
                                                                      parameters:[NSDictionary dictionaryWithObject:post forKey:@"status"]];
                    
                    [twitterRequest setAccount:twitterAccount];
                    
                    [twitterRequest performRequestWithHandler:^(NSData* responseData, NSHTTPURLResponse* urlResponse, NSError* error) {
                        NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                        
                    }];
                    
                }
                
            }
            
        }];
        _postText.text = [NSString stringWithFormat:@""];
        
    }
    _charCounter.text = [NSString stringWithFormat:@"140"];
    
    
}
@end
