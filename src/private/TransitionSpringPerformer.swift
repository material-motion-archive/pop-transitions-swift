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

import pop
import MaterialMotionPop
import MaterialMotionTransitions

func coerce(value: Any) -> Any {
  switch value {
  case let value as Int:
    return NSNumber(value: value)
  case let value as Float:
    return NSNumber(value: value)
  case let value as Double:
    return NSNumber(value: value)
  case let rect as CGRect:
    return NSValue(cgRect: rect)
  case let point as CGPoint:
    return NSValue(cgPoint: point)
  case let size as CGSize:
    return NSValue(cgSize: size)
  default:
    return value
  }
}

class TransitionSpringPerformer: NSObject, ComposablePerforming {
  let target: NSObject
  required init(target: Any) {
    self.target = target as! NSObject
  }

  func addPlan(_ plan: Plan) {
    let transitionSpring = plan as! TransitionSpring

    let destination: Any
    let origin: Any
    let configuration: SpringConfiguration
    switch transitionSpring.transition.direction {
    case .forward:
      destination = transitionSpring.foreDestination
      origin = transitionSpring.backDestination
      configuration = transitionSpring.configuration
    case .backward:
      destination = transitionSpring.backDestination
      origin = transitionSpring.foreDestination
      if let backwardConfiguration = transitionSpring.backwardConfiguration {
        configuration = backwardConfiguration
      } else {
        configuration = transitionSpring.configuration
      }
    }

    if (target is CALayer || target is UIView)
      && transitionSpring.property == "transform.scale"
      , let scale = origin as? CGSize {
      // POP expects .scale to be a CGSize, so we convert to a single scalar here.
      target.setValue(scale.width, forKeyPath: transitionSpring.property)
    } else {
      target.setValue(origin, forKeyPath: transitionSpring.property)
    }

    let springTo = SpringTo(transitionSpring.property, destination: destination)
    springTo.configuration = configuration
    emitter.emitPlan(springTo)
  }

  var emitter: PlanEmitting!
  func setPlanEmitter(_ planEmitter: PlanEmitting) {
    emitter = planEmitter
  }
}
