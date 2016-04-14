//
//  ThirdViewController.m
//  snapshotDemo
//
//  Created by aaron on 16/4/14.
//  Copyright © 2016年 decai wang. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *bottomInageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor yellowColor];

    _topImageView.image = _imageList.firstObject;
    _bottomInageView.image = _imageList.lastObject;
    
    _topConstraint.constant = 0;
    _bottomConstraint.constant = 0;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.5 animations:^{
        _topImageView.transform = CGAffineTransformMakeTranslation(0, -_topImageView.bounds.size.height);
    }];
    
    [UIView animateWithDuration:1.5 animations:^{
        _bottomInageView.transform = CGAffineTransformMakeTranslation(0, _bottomInageView.bounds.size.height);
    }];
    
}


@end
