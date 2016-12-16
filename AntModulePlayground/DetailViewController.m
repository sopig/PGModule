//
//  DetailViewController.m
//  AntModulePlayground
//
//  Created by xiaoxian on 2016/12/15.
//  Copyright © 2016年 sopig.cn. All rights reserved.
//

#import "DetailViewController.h"
#import "AntModuleManager.h"
#import "AntCommandExecutor.h"
#import "AntCommand.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)antload
{
    AntRegisterModuleURI(@"com.DetailViewController");
}


//AntRegisterModuleURI(@"https://www.baidu.com/a/index.html#part3?a=1&b=2");


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    
 
    
}

- (void)notFound:(id)sender
{
     ;
}

- (void)a:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDate *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)dealloc
{
    
}

@end
