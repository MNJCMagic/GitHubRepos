//
//  ViewController.m
//  GitHubRepos
//
//  Created by Mike Cameron on 2018-04-26.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray* repos;
@property (nonatomic, strong) NSMutableArray* repoObjs;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    NSMutableArray *dict = [[NSMutableArray alloc] init];
    self.repoObjs = dict;
    //data
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/MNJCMagic/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@", error.localizedDescription);
            return;
        }
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//        self.repos = repos;
        if (jsonError) {
            NSLog(@"jsonErrod: %@", jsonError.localizedDescription);
            return;
        }
        for (NSDictionary *repo in repos) {
            NSString *repoName = repo[@"name"];
//            NSLog(@"repo: %@", repoName);
        }

//        self.repos = repos;
        for (NSDictionary* repo in repos) {
            NSDictionary *tempDict = [[NSDictionary alloc] initWithDictionary:repo];
            Repo* tempRepo = [[Repo alloc] initWithDictionary:tempDict];
            [self.repoObjs addObject:tempRepo];
//            NSLog(@"added %@", self.repoObjs);
            
            
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            [self.tableView reloadData];
        }];
    }];
    
    [dataTask resume];
 
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repoObjs.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Repo *item = self.repoObjs[indexPath.row];
    NSDictionary *temp = [[NSDictionary alloc] initWithDictionary:item.dict];
    cell.textLabel.text = temp[@"name"];
    return cell;
}




@end
