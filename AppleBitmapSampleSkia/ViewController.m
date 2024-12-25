//
//  ViewController.m
//  AppleBitmapSampleSkia
//
//  Created by m3 on 2024/12/26.
//

#import "ViewController.h"
#import "BitmapSkiaRendering.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [BitmapSkiaRendering toUIImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(10, 10, 400, 300);  // Set the desired frame
    [self.view addSubview:imageView];  // Add the image view to the main view
}


@end
