//
//  ViewController.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "ViewController.h"
#import "RestService.h"
#import "LaunchModel.h"
#import "LaunchSiteModel.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray* launches;
//@property (strong, nonatomic) NSArray* next;
@end

@implementation ViewController
RestService *svr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    svr = [[RestService alloc] init];
//    [svr get:@"https://api.spacexdata.com/v2/launches/all" success:^(NSData * _Nonnull data) {
//        NSError* err = nil;
//        self.launches = [LaunchModel arrayOfModelsFromData:data error:&err];
//        NSLog(@"ok");
//    }];
    
//    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
//
//    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"karthik"];
//    // [navbar setBarTintColor:[UIColor lightGrayColor]];
//    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onTapCancel:)];
//    navItem.leftBarButtonItem = cancelBtn;
//
//    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone:)];
//    navItem.rightBarButtonItem = doneBtn;
//
//    [navbar setItems:@[navItem]];
//    [self.view addSubview:navbar];
    
    
    self.navigationItem.title = @"All Launches";
    
//    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
//    [imageButton setBackgroundImage:[UIImage imageNamed:@"filter.png"] forState:UIControlStateNormal];
//    [imageButton addTarget:self action:@selector(messageButtonTapped) forControlEvents:UIControlEventAllEvents];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
//    self.navigationItem.rightBarButtonItem = item;
    
//    var imageLogo = UIImage(named: "LogoWithTextSmaller.png")
//    imageLogo = imageLogo?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//    btnLogo.setImage(imageLogo, for: .normal)
    
    
    [self setupFilterButton];
}

- (void) setupFilterButton {
    UIImage *image = [UIImage imageNamed: @"filter.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIBarButtonItem *_btnLeftBar = [[UIBarButtonItem alloc]initWithImage:image
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(handleFilterTapped)];
    float itemWidth = self.navigationItem.rightBarButtonItem.width;
    float leftOffset = image.size.width - itemWidth;
    _btnLeftBar.imageInsets = UIEdgeInsetsMake(0, leftOffset, 0, 0);
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer.width = 0;
    self.navigationItem.rightBarButtonItems = @[spacer,_btnLeftBar];
}

-(void)handleFilterTapped {
    NSLog(@"Filter tapped");
}

@end

