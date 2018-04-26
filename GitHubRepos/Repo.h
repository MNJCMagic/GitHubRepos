//
//  Repo.h
//  GitHubRepos
//
//  Created by Mike Cameron on 2018-04-26.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject
@property NSDictionary* dict;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

@end
