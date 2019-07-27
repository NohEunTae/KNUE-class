//
//  KNFileBoxViewController.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNFileBoxViewController.h"
#import "KNFileBoxTableView.h"
#import "KNPublicCustomTableViewCell.h"

@interface KNFileBoxViewController ()

@property (nonatomic, strong) KNFileBoxTableView *fileBoxTableView;

@end

@implementation KNFileBoxViewController

#pragma mark File Box View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFileBoxTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Create File Box TableView

- (void)createFileBoxTableView {
    self.fileBoxTableView = [[KNFileBoxTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.fileBoxTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.fileBoxTableView registerClass:[KNPublicCustomTableViewCell class] forCellReuseIdentifier:@"fileBox"];
    self.fileBoxTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.fileBoxTableView setFileData];
    self.fileBoxTableView.fileBoxTableViewAdapter.viewController = self;
    [self.fileBoxTableView setDataSourceWithDelegate];
    [self.view addSubview:self.fileBoxTableView];
}

@end
