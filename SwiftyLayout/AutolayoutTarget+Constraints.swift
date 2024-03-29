//
//  AutolayoutTarget+Constraints.swift
//  AutolayoutHelpers
//
//  Created by Joe Thomson on 03/05/2020.
//  Copyright © 2020 Classical Apps. All rights reserved.
//

import UIKit

extension AutolayoutTarget
{
    /// Constrains this view to another using the given constraints.
    @discardableResult
    fileprivate func constrain(to other: AutolayoutTarget, priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.flatMap{ $0.constraints(between: self, and: other) }
        if doNotActivate == false
        {
            self.activateConstraints(final, priority: priority)
        }
        return final
    }
    
    /// Constrains this view to another using the given constraints.
    @discardableResult
    public func constrain(to other: AutolayoutTarget, priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        return self.constrain(to: other, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to fill another.
    @discardableResult
    public func fill(to other: AutolayoutTarget, priority: UILayoutPriority = .required, doNotActivate: Bool = false, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint]
    {
        return self.constrain(to: other, priority: priority, doNotActivate: doNotActivate, .fill(insets: insets))
    }
    
    /// Constrains this view using the given constraints.
    @discardableResult
    fileprivate func constrain(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: [UnaryConstraint]) -> [NSLayoutConstraint]
    {
        let final = constraints.flatMap{ $0.constraint(for: self) }
        if doNotActivate == false
        {
            self.activateConstraints(final, priority: priority)
        }
        return final
    }
    
    /// Constrains this view using the given constraints.
    @discardableResult
    public func constrain(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: UnaryConstraint...) -> [NSLayoutConstraint]
    {
        return self.constrain(priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Activates the given constraints and sets `translatesAutoresizingMaskIntoConstraints` to `false` if possible.
    private func activateConstraints(_ constraints: [NSLayoutConstraint], priority: UILayoutPriority)
    {
        if let view = self.underlyingView
        {
            view.ifSafeSet(translatesAutoresizingMaskIntoConstraints: false)
        }
        for constraint in constraints
        {
            constraint.priority = priority
            constraint.isActive = true
        }
    }
}

extension AutolayoutTarget
{
    /// Constrains this view to its superview using the given constraints.
    @discardableResult
    public func constrainToSuperview(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to its superview using the given constraints.
    @discardableResult
    public func constrainToSuperview(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to fill its superview.
    @discardableResult
    public func fillToSuperview(priority: UILayoutPriority = .required, doNotActivate: Bool = false, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, priority: priority, doNotActivate: doNotActivate, .fill(insets: insets))
    }
    
    /// Constrains this view to fill its superview.
    @discardableResult
    public func fillToSuperview(priority: UILayoutPriority = .required, doNotActivate: Bool = false, inset: CGFloat) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview, priority: priority, doNotActivate: doNotActivate, .fill(inset: inset))
    }
    
    /// Constrains this view to its superview's layout margins using the given constraints.
    @discardableResult
    public func constrainToSuperviewLayoutMargins(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.layoutMarginsGuide, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to its superview's layout margins using the given constraints.
    @discardableResult
    public func constrainToSuperviewLayoutMargins(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.layoutMarginsGuide, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to fill its superview's layout margins.
    @discardableResult
    public func fillToSuperviewLayoutMargins(priority: UILayoutPriority = .required, doNotActivate: Bool = false, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.layoutMarginsGuide, priority: priority, doNotActivate: doNotActivate, .fill(insets: insets))
    }
    
    /// Constrains this view to fill its superview's layout margins.
    @discardableResult
    public func fillToSuperviewLayoutMargins(priority: UILayoutPriority = .required, doNotActivate: Bool = false, inset: CGFloat) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.layoutMarginsGuide, priority: priority, doNotActivate: doNotActivate, .fill(inset: inset))
    }
    
    /// Constrains this view to its superview's safe area using the given constraints.
    @available(iOS 11.0, *)
    @discardableResult
    public func constrainToSuperviewSafeArea(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to its superview's safe area using the given constraints.
    @available(iOS 11.0, *)
    @discardableResult
    public func constrainToSuperviewSafeArea(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to fill its superview's safe area.
    @available(iOS 11.0, *)
    @discardableResult
    public func fillToSuperviewSafeArea(priority: UILayoutPriority = .required, doNotActivate: Bool = false, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, priority: priority, doNotActivate: doNotActivate, .fill(insets: insets))
    }
    
    /// Constrains this view to fill its superview's safe area.
    @available(iOS 11.0, *)
    @discardableResult
    public func fillToSuperviewSafeArea(priority: UILayoutPriority = .required, doNotActivate: Bool = false, inset: CGFloat) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.safeAreaLayoutGuide, priority: priority, doNotActivate: doNotActivate, .fill(inset: inset))
    }
    
    /// Constrains this view to its superview's readable content guide using the given constraints.
    @discardableResult
    public func constrainToSuperviewReadableGuide(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: [BinaryConstraint]) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.readableContentGuide, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to its superview's readable content guide using the given constraints.
    @discardableResult
    public func constrainToSuperviewReadableGuide(priority: UILayoutPriority = .required, doNotActivate: Bool = false, _ constraints: BinaryConstraint...) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.readableContentGuide, priority: priority, doNotActivate: doNotActivate, constraints)
    }
    
    /// Constrains this view to fill its superview's readable content guide.
    @discardableResult
    public func fillToSuperviewReadableGuide(priority: UILayoutPriority = .required, doNotActivate: Bool = false, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.readableContentGuide, priority: priority, doNotActivate: doNotActivate, .fill(insets: insets))
    }
    
    /// Constrains this view to fill its superview's readable content guide.
    @discardableResult
    public func fillToSuperviewReadableGuide(priority: UILayoutPriority = .required, doNotActivate: Bool = false, inset: CGFloat) -> [NSLayoutConstraint]
    {
        guard let superview = self.superview else { return [] }
        return self.constrain(to: superview.readableContentGuide, priority: priority, doNotActivate: doNotActivate, .fill(inset: inset))
    }
}
