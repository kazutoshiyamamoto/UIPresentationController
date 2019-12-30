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
    }
}
