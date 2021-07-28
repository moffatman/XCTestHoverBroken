//
//  XCTestHoverBrokenUITests.m
//  XCTestHoverBrokenUITests
//
//  Created by Callum Moffat on 2021-07-28.
//

#import <XCTest/XCTest.h>

@interface XCTestHoverBrokenUITests : XCTestCase

@end

@implementation XCTestHoverBrokenUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testHover {
    // UI tests must launch the application that they test.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    NSLog(@"%@", app.debugDescription);

    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    for (XCUIElement* textField in app.staticTexts.allElementsBoundByIndex) {
        NSLog(@"%@", textField.label);
    }

    NSPredicate* predicateToFindFlutterView = [NSPredicate predicateWithBlock:^BOOL(id _Nullable evaluatedObject, NSDictionary<NSString*, id>* _Nullable bindings) {
        XCUIElement* element = evaluatedObject;
        return [element.identifier hasPrefix:@"my_view"];
    }];
    XCUIElement* myView = [[app descendantsMatchingType:XCUIElementTypeAny]
        elementMatchingPredicate:predicateToFindFlutterView];
    XCTAssertTrue([myView waitForExistenceWithTimeout:1], @"myView not found");

    XCTAssertTrue([app.staticTexts[@"initial"] waitForExistenceWithTimeout:1], @"communications not established");

    [myView hover];
    XCTAssertTrue([app.staticTexts[@"hover"] waitForExistenceWithTimeout:1], @"hover not processed correctly");

    [myView tap];
    XCTAssertTrue([app.staticTexts[@"touches_ended"] waitForExistenceWithTimeout:1], @"hover not processed correctly");

    [myView hover];
    XCTAssertTrue([app.staticTexts[@"hover"] waitForExistenceWithTimeout:1], @"hover not processed correctly");
}

@end
