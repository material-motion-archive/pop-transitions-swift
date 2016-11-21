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

import MaterialMotionPop
import MaterialMotionTransitions

/**
 Pull a property towards a specific value using a POP spring during a transition.

 A different SpringTo plan will be emitted depending on the transition's direction.

 When multiple plans are added to the same property, the last-registered plan's values will be used.
 */
@objc(MDMTransitionSpring)
public final class TransitionSpring: NSObject, Plan {

  /** The property whose value should be pulled with a spring. */
  public var property: String

  /** The value to which the property should be pulled when the transition is moving forward. */
  public var foreDestination: Any

  /** The value to which the property should be pulled when the transition is moving backward. */
  public var backDestination: Any

  /** The transition in which this plan should be performed. */
  public var transition: Transition

  /** The spring's desired configuration while the transition is moving forward. */
  public var configuration = SpringTo.defaultConfiguration

  /**
   The spring's desired configuration while the transition is moving backward.

   If nil then configuration will be used instead.
   */
  public var backwardConfiguration: SpringConfiguration?

  /** Initialize a TransitionSpring plan with a property and destination. */
  @objc(initWithProperty:transition:back:fore:)
  public init(_ property: String, transition: Transition, back: Any, fore: Any) {
    self.property = property
    self.transition = transition
    self.backDestination = coerce(value: back)
    self.foreDestination = coerce(value: fore)
    super.init()
  }

  /** The performer that will fulfill this plan. */
  public func performerClass() -> AnyClass {
    return TransitionSpringPerformer.self
  }

  /** Returns a copy of this plan. */
  public func copy(with zone: NSZone? = nil) -> Any {
    let spring = TransitionSpring(property, transition: transition, back: backDestination, fore: foreDestination)
    spring.configuration = (configuration.copy() as! SpringConfiguration)
    if let backwardConfiguration = backwardConfiguration {
      spring.backwardConfiguration = (backwardConfiguration.copy() as! SpringConfiguration)
    }
    return spring
  }
}
