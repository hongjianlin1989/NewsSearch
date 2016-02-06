//
//  FitmooHelper.m
//  fitmoo
//
//  Created by hongjian lin on 4/7/15.
//  Copyright (c) 2015 com.fitmoo. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (Helper*)sharedInstance
{
    static dispatch_once_t pred;
    static Helper *settings = nil;
    
    dispatch_once(&pred, ^{ settings = [[self alloc] init]; });
    return settings;
    
}

- (CGRect) resizeFrameWithFrame:(UIView *) view
{
    view.frame= CGRectMake(view.frame.origin.x * SCREEN_WIDTH_RATIO, view.frame.origin.y * SCREEN_WIDTH_RATIO, view.frame.size.width * SCREEN_WIDTH_RATIO, view.frame.size.height*SCREEN_WIDTH_RATIO);
    return view.frame;
}

- (NSString *) regenerateString: (NSString *) originalString
{
    NSString* newString = [originalString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return newString;
}


- (UIView *) addActivityIndicatorView: (UIView *)indicatorView and:(UIView *) selfView text:(NSString *) text
{
    indicatorView= [[UIView alloc] initWithFrame:CGRectMake(selfView.frame.size.width/2-50, 200*SCREEN_WIDTH_RATIO, 100, 100)];
    indicatorView.backgroundColor=[UIColor colorWithRed:174.0/255.0 green:182.0/255.0 blue:186.0/255.0 alpha:1];
    indicatorView.layer.cornerRadius=5;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(50, 40);
    activityIndicator.hidesWhenStopped = YES;
    [activityIndicator setBackgroundColor:[UIColor clearColor]];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator startAnimating];
    
    UILabel * postingLabel= [[UILabel alloc] initWithFrame: CGRectMake(0,60, 100, 30)];
    postingLabel.text= text;
    
    postingLabel.textColor=[UIColor whiteColor];
    UIFont *font = [UIFont fontWithName:@"Systom" size:13];
    [postingLabel setFont:font];
    postingLabel.textAlignment=NSTextAlignmentCenter;
    
    [indicatorView addSubview:activityIndicator];
    [indicatorView addSubview:postingLabel];
    [selfView addSubview:indicatorView];
    
    return indicatorView;
    
}


- (NSString *) generateDateString:(NSString *)dateString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    NSDate *date = [dateFormat dateFromString:dateString];
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSString *newString = [newDateFormatter stringFromDate:date];
    
    return newString;
}


- (id) init;{
    
    if ((self = [super init])) {
        NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
        _keyDictionary= [dictRoot objectForKey:@"StoryKey"];
        
    }
    
    return self;
}


@end