//
//  DetailViewController.h
//  AntModulePlayground
//
//  Created by xiaoxian on 2016/12/15.
//  Copyright © 2016年 sopig.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

