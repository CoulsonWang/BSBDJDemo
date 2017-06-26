//
//  BDJMineViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJMineViewController.h"
#import "UIBarButtonItem+CreateItem.h"
#import "BDJSettingViewController.h"

@interface BDJMineViewController ()

@end

@implementation BDJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 设置导航条
 */
- (void)setUpNavigationBar {
    //通过调用分类中的类方法快速创建UIBarButtonItem
    UIBarButtonItem *nightModeBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] highLightImage:[UIImage imageNamed:@"mine-sun-icon-click"] selectedImage:[UIImage imageNamed:@"mine-sun-icon"] target:self action:@selector(nightModeBtnClick:)];
    UIBarButtonItem *settingBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highLightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingBtn,nightModeBtn];
    
    self.navigationItem.title = @"我的";
}



/**
 处理夜间模式按钮点击
 */
- (void)nightModeBtnClick:(UIButton *)btn {
    btn.selected = !btn.isSelected;
}

- (void)settingBtnClick {
    BDJSettingViewController *settingVC = [[BDJSettingViewController alloc] init];
    [self.navigationController showViewController:settingVC sender:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
