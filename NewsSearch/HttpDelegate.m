//
//  HttpDelegate.m
//  NewsSearch
//
//  Created by hongjian lin on 2/6/16.
//  Copyright © 2016 com.massmutual. All rights reserved.
//

#import "HttpDelegate.h"
#import "AFNetworking.h"

@interface HttpDelegate ()
{
    NSString *page;
    NSString *searchHeadline;
    NSString *currentKey;
    NSString *searchCategory;
    NSLock *Lock;
}
@end

@implementation HttpDelegate

- (void) parseArticle:(NSDictionary *) dic
{
    [Lock lock];
    _newsArray= [[NSMutableArray alloc] init];
    NSDictionary *response= [dic objectForKey:@"response"];
    NSArray *docs= [response objectForKey:@"docs"];
    for (NSDictionary *res in docs) {
        Article *arc= [[Article alloc] init];
        arc._id= [res objectForKey:@"_id"];
        NSDictionary * headline= [res objectForKey:@"headline"];
        arc.headline= [headline objectForKey:@"main"];
        arc.lead_paragraph= [res objectForKey:@"lead_paragraph"];
        arc.snippet= [res objectForKey:@"snippet"];
        arc.web_url= [res objectForKey:@"web_url"];
        arc.source= [res objectForKey:@"source"];
        arc.pub_date= [[Helper sharedInstance] generateDateString:[res objectForKey:@"pub_date"]];
        [_newsArray addObject:arc];
    }
   
    [_delegate LoadObjectCompleted:_newsArray];
    [Lock unlock];

}

- (void) StartRequest
{
    
    NSArray *resultArray= [_delegate SetsOfElementNeedForHttpDelegate];
    searchHeadline=[resultArray objectAtIndex:0];
    page=[resultArray objectAtIndex:1];
    currentKey=[resultArray objectAtIndex:2];
    searchCategory=[resultArray objectAtIndex:3];
    
    if ([searchCategory isEqualToString:@"Article Search"]) {
        [self getNewsFromUrl];
    }
    
}

- (void) getNewsFromUrl
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url= [NSString stringWithFormat:@"http://api.nytimes.com/svc/search/v2/articlesearch.json?q=%@&page=%@&sort=newest&api-key=%@",[[Helper sharedInstance] regenerateString:searchHeadline],page,currentKey];
    
    [manager GET: url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary * responseDic= responseObject;
        [self parseArticle:responseDic];
    } // success callback block
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
            [_delegate LoadObjectFailed:error];
            NSLog(@"Error: %@", error);} // failure callback block
     ];
}

- (id) init;{
    
    if ((self = [super init])) {
         Lock= [NSLock new];
    }

    return self;
}

-(void)dealloc
{
    _delegate = nil;
}


@end
