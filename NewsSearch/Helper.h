//
//  FitmooHelper.h
//  fitmoo
//
//  Created by hongjian lin on 4/7/15.
//  Copyright (c) 2015 com.fitmoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Helper.h"


#define SCREEN_WIDTH_RATIO ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)/320
#define UA_rgba(r,g,b,a)	[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface Helper : NSObject{
    
}
+ (Helper*) sharedInstance;

- (CGRect) resizeFrameWithFrame:(UIView *) view;
- (NSString *) regenerateString: (NSString *) originalString;
- (NSString *) generateDateString:(NSString *)dateString;

@property (strong, nonatomic) NSDictionary *keyDictionary;
@property (strong, nonatomic) NSArray *keyNameArray;

@end