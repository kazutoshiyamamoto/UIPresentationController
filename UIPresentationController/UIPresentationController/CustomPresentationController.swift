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
        self.overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(CustomPresentationController.overlayDidTouch(_:)))]
        self.overlay.backgroundColor = UIColor.black
        self.overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, at: 0)
        
        // ViewControllerの遷移アニメーションと同時に指定されたアニメーションを実行するメソッド
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
            self?.overlay.alpha = 0.7
            }, completion:nil)
    }
    
    // 非表示時のアニメーションが開始されようとしていることをプレゼンテーションコントローラーに通知するメソッド
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlay.alpha = 0.0
            }, completion: nil)
    }
    
    // 非表示のアニメーション開始後に呼ばれるメソッド
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }
    
    // モーダルのサイズ
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height)
    }
    
    // モーダルのframe
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect()
        let containerBounds = containerView!.bounds
        let childContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.size = childContentSize
        presentedViewFrame.origin.x = 0.0
        presentedViewFrame.origin.y = containerBounds.height / 2.0
        
        return presentedViewFrame
    }
    
    // コンテナビューのレイアウト開始前に呼ばれる
    override func containerViewWillLayoutSubviews() {
        self.overlay.frame = containerView!.bounds
        self.presentedView?.frame = frameOfPresentedViewInContainerView
        self.presentedView?.layer.cornerRadius = 10.0
        self.presentedView?.clipsToBounds = true
    }
    
    @objc func overlayDidTouch(_ sender: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
