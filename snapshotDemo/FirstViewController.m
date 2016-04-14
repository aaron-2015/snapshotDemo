//
//  FirstViewController.m
//  snapshotDemo
//
//  Created by aaron on 16/4/14.
//  Copyright © 2016年 decai wang. All rights reserved.
//

#import "FirstViewController.h"
#import "ThirdViewController.h"


static NSString * const identifier = @"cellIdentifier";

@interface FirstViewController ()

@end

@implementation FirstViewController

#pragma mark -life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"第一个页面";
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
    NSLog(@"%@",NSStringFromCGRect(rect));
    NSLog(@"点击了第%ld行",(long)indexPath.row);
    ThirdViewController *secVC = [ThirdViewController new];
    NSArray *imageList = [self screenviewWithRectY:rect.origin.y];
    secVC.imageList = imageList;
    [self presentViewController:secVC animated:NO completion:^{
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    else if (section == 1){
        return 5;
    }
    else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组,第%ld行",(long)indexPath.section,(long)indexPath.row];
    
    return cell;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;{
    
    return [NSString stringWithFormat:@"第%ld组",(long)section];
}

#pragma mark - private method

- (NSArray *)screenviewWithRectY:(CGFloat)rectY{
    
    UIImage *image = [self snapshot:self.navigationController.view];
    CGImageRef cgRef = image.CGImage;
    
    CGImageRef topImageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(0,0, self.view.bounds.size.width,rectY + 64));
    UIImage *topImage = [UIImage imageWithCGImage:topImageRef];
    CGImageRelease(topImageRef);
    
    CGImageRef bottomImageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(0,rectY + 64 + 44 , self.view.bounds.size.width,self.view.bounds.size.height - (rectY + 64) - 44));
    UIImage *bottomImage = [UIImage imageWithCGImage:bottomImageRef];
    CGImageRelease(bottomImageRef);
    
    return @[topImage,bottomImage];
}


- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 1.0);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
