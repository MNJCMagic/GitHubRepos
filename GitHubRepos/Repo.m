//
//  Repo.m
//  GitHubRepos
//
//  Created by Mike Cameron on 2018-04-26.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

#import "Repo.h"

@implementation Repo

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _dict = dict;
    }
    return self;
}


@end
