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

public extension UIViewController {
  
  func radialPushViewController(
    _ viewController: UIViewController,
    _ duration: TimeInterval = DEFAULT_CIRCULAR_ANIMATION_DURATION,
    _ startFrame: CGRect = CGRect.zero,
    revealType: RevealType = .reveal,
    _ transitionCompletion: (() -> ())? = nil) {
    guard let navigationController = navigationController else {
      print("UIViewController is not a UINavigationViewController")
      return
    }
    navigationController.radialPresentPushViewController(
      viewController,
      duration,
      startFrame,
      revealType: revealType,
      transitionCompletion)
  }
  
  @objc func radialPopViewController() {
    guard let navigationController = navigationController else {
      print("UIViewController is not a UINavigationViewController")
      return
    }
    navigationController.radialPresentPopViewController()
  }
  
  func setupBackButton(
    title: String = "Back",
    style: UIBarButtonItemStyle = UIBarButtonItemStyle.plain) {
    navigationItem.hidesBackButton = true
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: title,
      style: style,
      target: self,
      action: #selector(radialPopViewController))
  }
  
}
