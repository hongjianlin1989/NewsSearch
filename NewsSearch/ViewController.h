//
//  ViewController.h
//  NewsSearch
//
//  Created by hongjian lin on 2/4/16.
//  Copyright © 2016 com.massmutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ArticleCell.h"
#import "DetailViewController.h"
#import "UITableView+reloadData.h"
#import "HttpDelegate.h"
@interface ViewController : BaseViewController<UITextFieldDelegate,HttpDelegate>

@property (strong, nonatomic) NSMutableArray *articleArray;
@property (strong, nonatomic) NSDictionary *keyDictionary;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) NSString *currentKey;
@property (strong, nonatomic) UITextField *searchTextField;
@property (strong, nonatomic) NSMutableArray * inputSearchTermArray;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerQueue;

@property (strong, nonatomic) HttpDelegate *httpDelegate;

@end

