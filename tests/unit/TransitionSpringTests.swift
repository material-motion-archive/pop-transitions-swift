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

import XCTest
import MaterialMotionRuntime
@testable import MaterialMotionTransitions
import MaterialMotionPopTransitions

class FakeDirector: NSObject, TransitionDirector {
  required init(transition: Transition) {
  }
  func setUp() {
  }
}

class TransitionSpringTests: XCTestCase {

  var forwardTransition: Transition!
  var backwardTransition: Transition!
  var runtime: MotionRuntime!
  override func setUp() {
    forwardTransition = Transition(directorClass: FakeDirector.self,
                                   direction: .forward,
                                   back: UIViewController(),
                                   fore: UIViewController())
    backwardTransition = Transition(directorClass: FakeDirector.self,
                                    direction: .backward,
                                    back: UIViewController(),
                                    fore: UIViewController())
    runtime = MotionRuntime()
  }

  func testSetsBackValueWhenTransitioningForward() {
    let tween = TransitionSpring("opacity", transition: forwardTransition, back: 0, fore: 1)
    let view = UIView()
    view.layer.opacity = 0.5

    runtime.addPlan(tween, to: view.layer)

    XCTAssertEqual(view.layer.opacity, 0)
  }

  func testSetsForeValueWhenTransitioningBackward() {
    let tween = TransitionSpring("opacity", transition: backwardTransition, back: 0, fore: 1)
    let view = UIView()
    view.layer.opacity = 0.5

    runtime.addPlan(tween, to: view.layer)

    XCTAssertEqual(view.layer.opacity, 1)
  }

  func testAnimatesToForeValuesWhenTransitioningForward() {
    let tween = TransitionSpring("opacity", transition: forwardTransition, back: 0, fore: 1)
    let view = UIView()
    view.layer.opacity = 0.5

    let delegate = ExpectableRuntimeDelegate()
    delegate.didIdleExpectation = expectation(description: "Did idle")
    runtime.delegate = delegate

    runtime.addPlan(tween, to: view.layer)

    waitForExpectations(timeout: 1)

    XCTAssertFalse(runtime.isActive)
    XCTAssertEqual(view.layer.opacity, 1)
  }

  func testAnimatesToBackValuesWhenTransitioningBackward() {
    let tween = TransitionSpring("opacity", transition: backwardTransition, back: 0, fore: 1)
    let view = UIView()
    view.layer.opacity = 0.5

    let delegate = ExpectableRuntimeDelegate()
    delegate.didIdleExpectation = expectation(description: "Did idle")
    runtime.delegate = delegate

    runtime.addPlan(tween, to: view.layer)

    waitForExpectations(timeout: 1)

    XCTAssertFalse(runtime.isActive)
    XCTAssertEqual(view.layer.opacity, 0)
  }
}
