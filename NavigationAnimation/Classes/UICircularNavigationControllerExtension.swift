//
// Copyright (c) 2017 T-Pro
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

public extension UINavigationController {

  func radialPresentPushViewController(
    _ viewController: UIViewController? = nil,
    _ duration: TimeInterval = DEFAULT_CIRCULAR_ANIMATION_DURATION,
    _ startFrame: CGRect = CGRect.zero,
    revealType: RevealType = .reveal,
    _ transitionCompletion: (() -> ())? = nil) {
    
    let rect: CGRect
    
    if startFrame == CGRect.zero {
      let viewControllerSize = visibleViewController?.view.frame.size
      rect = CGRect(
        origin: CGPoint(
          x: viewControllerSize?.width ?? 0,
          y: viewControllerSize?.height ?? 0),
        size: CGSize(
          width: 0,
          height: 0))
    } else {
      rect = startFrame
    }
    
    let animatorDirector = CicularTransactionDirector()
    animatorDirector.duration = duration
    delegate = animatorDirector
    animatorDirector.animationBlock = { (transactionContext, animationTime, completion) in

      let toViewController = transactionContext.viewController(
        forKey: UITransitionContextViewControllerKey.to)
      let fromViewController = transactionContext.viewController(
        forKey: UITransitionContextViewControllerKey.from)

      if let toView = toViewController?.view,
         let fromView = fromViewController?.view {

        switch revealType {
          case RevealType.reveal:
            transactionContext.containerView.insertSubview(
              toView, aboveSubview: fromView)
            toView.drawAnimatedCircularMask(
              startFrame: rect,
              duration: animationTime,
              revealType: revealType) { () -> Void in
              completion()
              transitionCompletion?()
            }
            break

          case RevealType.unreveal:
            transactionContext.containerView.insertSubview(
              toView, belowSubview: fromView)
            fromView.drawAnimatedCircularMask(
              startFrame: rect,
              duration: animationTime,
              revealType: revealType) { () -> Void in
              completion()
              transitionCompletion?()
            }
            break
        }
      }
    }

    switch revealType {
      case RevealType.reveal:
        if let viewController = viewController {
          pushViewController(viewController, animated: true)
        } else {
          print("ViewController is nil")
        }
        break
      case RevealType.unreveal:
        popViewController(animated: true)
        break
    }
  }

  func radialPresentPopViewController() {
    radialPresentPushViewController(revealType: .unreveal)
  }

}





