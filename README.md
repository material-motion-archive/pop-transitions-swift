# POP Transitions for Material Motion (Swift)

[![Build Status](https://travis-ci.org/material-motion/pop-transitions-swift.svg?branch=develop)](https://travis-ci.org/material-motion/pop-transitions-swift)
[![codecov](https://codecov.io/gh/material-motion/pop-transitions-swift/branch/develop/graph/badge.svg)](https://codecov.io/gh/material-motion/pop-transitions-swift)

## Supported languages

- Swift 3
- Objective-C

## Features

`TransitionSpring` makes it easy to describe bi-directional spring-based transitions.

Consider the following example of a simple "slide in" transition director:

```swift
class SlideInTransitionDirector: NSObject, TransitionDirector {
  let transition: Transition
  required init(transition: Transition) {
    self.transition = transition
  }

  func setUp() {
    let midY = Double(transition.foreViewController.view.layer.position.y)
    let height = Double(transition.foreViewController.view.bounds.height)
    let slide = TransitionSpring("position.y",
                                 transition: transition,
                                 back: NSNumber(value: midY + height),
                                 fore: NSNumber(value: midY))
    transition.runtime.addPlan(slide, to: transition.foreViewController.view.layer)
  }
}
```

In this director we've defined a single TransitionSpring that handles both the forward and backward
transition. Going forward, a `SpringTo` with destination midY is emitted. Going backward, a
`SpringTo` with destination midY + height is emitted.

## Installation

### Installation with CocoaPods

> CocoaPods is a dependency manager for Objective-C and Swift libraries. CocoaPods automates the
> process of using third-party libraries in your projects. See
> [the Getting Started guide](https://guides.cocoapods.org/using/getting-started.html) for more
> information. You can install it with the following command:
>
>     gem install cocoapods

Add `MaterialMotionPopTransitions` to your `Podfile`:

    pod 'MaterialMotionPopTransitions'

Then run the following command:

    pod install

### Usage

Import the framework:

    @import MaterialMotionPopTransitions;

You will now have access to all of the APIs.

## Example apps/unit tests

Check out a local copy of the repo to access the Catalog application by running the following
commands:

    git clone https://github.com/material-motion/pop-transitions-swift.git
    cd pop-transitions-swift
    pod install
    open MaterialMotionPopTransitions.xcworkspace

## Guides

1. [How to animate a CALayer property with a TransitionSpring plan](#how-to-animate-a-calayer-property-with-a-transitionspring-plan)

### How to animate a CALayer property with a TransitionSpring plan

Code snippets:

***In Objective-C:***

```objc
MDMTransitionSpring *spring = [[MDMTransitionSpring alloc] initWithProperty:"<#key path#>"
                                                                 transition:transition
                                                                       back:<#back value#>
                                                                       fore:<#fore value#>];
[scheduler addPlan:spring to:<#Object#>];
```

***In Swift:***

```swift

let spring = TransitionSpring("<#key path#>",
                              transition: transition,
                              back: <#back value#>,
                              fore: <#fore value#>)
transition.scheduler.addPlan(spring, to: <#Layer#>)
```

## Contributing

We welcome contributions!

Check out our [upcoming milestones](https://github.com/material-motion/pop-transitions-swift/milestones).

Learn more about [our team](https://material-motion.github.io/material-motion/team/),
[our community](https://material-motion.github.io/material-motion/team/community/), and
our [contributor essentials](https://material-motion.github.io/material-motion/team/essentials/).

## License

Licensed under the Apache 2.0 license. See LICENSE for details.
