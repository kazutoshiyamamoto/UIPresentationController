//
//  CustomPresentationController.swift
//  UIPresentationController
//
//  Created by home on 2019/12/30.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    // モーダルの背景に表示されるオーバーレイビュー
    var overlay: UIView!
    
    // 表示時のアニメーションが開始されようとしていることをプレゼンテーションコントローラーに通知するメソッド
    override func presentationTransitionWillBegin() {
        // アニメーションコントローラーに渡されるビュー
        let containerView = self.containerView!
        
        self.overlay = UIView(frame: containerView.bounds)
        self.overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: Selector(("overlayDidTouch:")))]
        self.containerView?.backgroundColor = UIColor.black
        self.overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, at: 0)
        
        // ViewControllerの遷移アニメーションと同時に指定されたアニメーションを実行するメソッド
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (context) in
            self?.overlay.alpha = 0.5
            }, completion: nil)
    }
    
    // 非表示時のアニメーションが開始されようとしていることをプレゼンテーションコントローラーに通知するメソッド
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (context) in
            self?.overlay.alpha = 0.0
            }, completion: nil)
    }
    
    // 非表示時のアニメーション開始後に呼ばれるメソッド
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }
    
    // モーダルのサイズ
    func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height)
    }
    
    // モーダルのframe
    func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerView!.bounds
        presentedViewFrame.size = self.sizeForChildContentContainer(container: self.presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = containerBounds.size.width - presentedViewFrame.size.width
        presentedViewFrame.origin.y = containerBounds.size.height - presentedViewFrame.size.height
        return presentedViewFrame
    }
    
    // コンテナビューのレイアウト開始前に呼ばれる
    override func containerViewWillLayoutSubviews() {
        self.overlay.frame = containerView!.bounds
        self.presentedView!.frame = self.frameOfPresentedViewInContainerView()
    }
    
    
}
