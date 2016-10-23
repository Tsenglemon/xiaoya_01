//
//  rootViewTabBarController.m
//  xiaoya_01
//
//  Created by 曾凌峰 on 2016/10/10.
//  Copyright © 2016年 曾凌峰. All rights reserved.
//

#import "rootViewTabBarController.h"
#import "scheduleViewController.h"
#import "groupsViewController.h"
#import "mineViewController.h"

@interface rootViewTabBarController ()

@end

@implementation rootViewTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    scheduleViewController *secdule = [[scheduleViewController alloc] init];
    secdule.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"日程" image:[UIImage imageNamed:@"tab_buddy_nor"] tag:1];
    
    groupsViewController *groups = [[groupsViewController alloc] init];
    groups.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"群组" image:[UIImage imageNamed:@"tab_qworld_nor"] tag:2];
    
    mineViewController *mine = [[mineViewController alloc] init];
    mine.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tab_recent_nor"] tag:3];	
    
    self.viewControllers = @[secdule,groups,mine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
