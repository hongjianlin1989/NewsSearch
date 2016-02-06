//
//  ViewController.h
//  NewsSearch
//
//  Created by hongjian lin on 2/4/16.
//  Copyright © 2016 com.massmutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Article.h"
#import "ArticleCell.h"
#import "DetailViewController.h"
#import "UITableView+reloadData.h"
@interface ViewController : BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *newsArray;
@property (strong, nonatomic) NSDictionary *keyDictionary;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) NSString *currentKey;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSMutableArray * searchArrayHeadline;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerQueue;

@end

