/*
 Copyright 2016-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>

@import MaterialMotionRuntime;
@import MaterialMotionTransitions;
@import MaterialMotionPopTransitions;

@interface FakeDirector : NSObject <MDMTransitionDirector>
@end

@interface ObjectiveCAPITests : XCTestCase
@end

// Verify that plans can be created in Objective-C.
@implementation ObjectiveCAPITests

- (void)testTransitionSpringAPI {
  NSString *property = @"bounds.size";
  id foreDestination = [NSValue valueWithCGSize:CGSizeMake(10, 10)];
  id backDestination = [NSValue valueWithCGSize:CGSizeMake(10, 0)];
  MDMTransition *transition = [[MDMTransition alloc] initWithDirectorClass:[FakeDirector class]
                                                                 direction:MDMTransitionDirectionForward
                                                        backViewController:[UIViewController new]
                                                        foreViewController:[UIViewController new]];
  MDMTransitionSpring *plan = [[MDMTransitionSpring alloc] initWithProperty:property
                                                                 transition:transition
                                                                       back:backDestination
                                                                       fore:foreDestination];
  XCTAssertEqual(plan.property, property);
  XCTAssertEqual(plan.transition, transition);
  XCTAssertEqualObjects(plan.foreDestination, foreDestination);
  XCTAssertEqualObjects(plan.backDestination, backDestination);
}

@end

@implementation FakeDirector

- (instancetype)initWithTransition:(MDMTransition *)transition {
  return [super init];
}

- (void)setUp {
}

@end
