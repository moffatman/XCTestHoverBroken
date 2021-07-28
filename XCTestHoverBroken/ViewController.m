//
//  ViewController.m
//  XCTestHoverBroken
//
//  Created by Callum Moffat on 2021-07-28.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UILabel* label;
    UIPointerInteraction* pointerInteraction API_AVAILABLE(ios(13.4));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 64.0, 320.0, 24.0)];
    label.textColor = [UIColor blackColor];
    label.text = @"initial";
    [self.view addSubview:label];
    self.view.accessibilityIdentifier = @"my_view";
    if (@available(iOS 13.4, *)) {
        pointerInteraction = [[UIPointerInteraction alloc] initWithDelegate:self];
        [self.view addInteraction:pointerInteraction];
    }
}

- (UIPointerRegion*)pointerInteraction:(UIPointerInteraction*)interaction
                      regionForRequest:(UIPointerRegionRequest*)request
                         defaultRegion:(UIPointerRegion*)defaultRegion API_AVAILABLE(ios(13.4)) {
  if (request != nil) {
    label.text = @"hover";
  }
  return nil;
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    label.text = @"touches_ended";
}

@end
