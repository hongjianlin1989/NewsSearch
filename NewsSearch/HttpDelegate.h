//
//  HttpDelegate.h
//  NewsSearch
//
//  Created by hongjian lin on 2/6/16.
//  Copyright © 2016 com.massmutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"
#import "Helper.h"

@protocol HttpDelegate <NSObject>

@required

- (NSArray *) SetsOfElementNeedForHttpDelegate;
- (void) LoadObjectCompleted:(NSMutableArray *) resultArray;
- (void) LoadObjectFailed:(NSError *) error;
@end

@interface HttpDelegate : NSObject

@property (nonatomic, weak) id <HttpDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *newsArray;
- (void) StartRequest;

@end
