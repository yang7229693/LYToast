//
//  ViewController.m
//
//  Created by Loki on 14-5-26.
//  Copyright (c) 2014年 Loki. All rights reserved.
//

#import "ViewController.h"
#import "LYImageToast.h"
#import "LYMessageToast.h"

#define kToastDuration      1.5f

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textToastInView:(id)sender {
    
    [LYMessageToast toastWithText:@"Pop Me In Current View\n\nWidth And Height Self-Adaption!"
                  backgroundColor:[UIColor blackColor]
                             font:[UIFont systemFontOfSize:15.0f]
                        fontColor:[UIColor whiteColor]
                         duration:kToastDuration
                           inView:self.view];
}

- (IBAction)imageToastInView:(id)sender {
    
    [LYImageToast toastWithImage:@"test.png"
                          inView:self.view
                        duration:kToastDuration];
}

@end
