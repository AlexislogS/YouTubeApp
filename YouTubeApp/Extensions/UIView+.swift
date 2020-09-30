//
//  UIView+.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 28.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        anchors(top: superview?.topAnchor,
                leading: superview?.leadingAnchor,
                trailing: superview?.trailingAnchor,
                bottom: superview?.bottomAnchor)
    }
    
    func fillSafeArea() {
        translatesAutoresizingMaskIntoConstraints = false
        anchors(top: superview?.topAnchor,
                leading: superview?.leadingAnchor,
                trailing: superview?.trailingAnchor,
                bottom: superview?.bottomAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    func anchors(top: NSLayoutYAxisAnchor? = nil,
                 leading: NSLayoutXAxisAnchor? = nil,
                 trailing: NSLayoutXAxisAnchor? = nil,
                 bottom: NSLayoutYAxisAnchor? = nil,
                 centerX: NSLayoutXAxisAnchor? = nil,
                 centerY: NSLayoutYAxisAnchor? = nil,
                 padding: UIEdgeInsets = .zero,
                 size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
