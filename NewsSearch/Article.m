//
//  Contacts.m
//  fitmoo
//
//  Created by hongjian lin on 6/22/15.
//  Copyright (c) 2015 com.fitmoo. All rights reserved.
//

#import "Article.h"

@implementation Article

- (NSString *)snippet
{
    return ([_snippet isEqual:[NSNull null]]) ? @"" : _snippet;
}

@end
