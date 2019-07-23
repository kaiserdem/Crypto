//
//  MTSlideToOpenView.swift
//  Crypto
//
//  Created by Kaiserdem on 12.07.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

@objc public protocol MTSlideToOpenDelegate {
  func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView)
}

@objcMembers public class MTSlideToOpenView: UIView {
  
  // MARK: All Views
  public let textLabel: UILabel = {
    let label = UILabel.init()
    return label
  }()
  public let sliderTextLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  public let textForButtonLabel: UILabel = {
    let label = UILabel()
    label.text = NSLocalizedString("Buy BTC", comment: "Buy BTC")
    label.textAlignment = NSTextAlignment.center
    label.textColor = .white
    label.font = UIFont(name:"Helvetica", size:14)

    return label
  }()
  public let thumnailImageView: UIImageView = {
    let view = MTRoundImageView()
    view.isUserInteractionEnabled = true
//    view.contentMode = .center
    return view
  }()
  public let sliderHolderView: UIView = {
    let view = UIView()
    return view
  }()
  public var draggedView: UIView = {
    let view = UIView()
    return view
  }()
  public let view: UIView = {
    let view = UIView()
    return view
  }()
  // MARK: Public properties
  public weak var delegate: MTSlideToOpenDelegate?
  public var animationVelocity: Double = 0.2 // время возвращения
  public var sliderViewTopDistance: CGFloat = 0.0 { // размер сверху
    didSet {
      topSliderConstraint?.constant = sliderViewTopDistance
      layoutIfNeeded()
    }
  }
  
  public var thumbnailViewStartingDistance: CGFloat = 0.0 { // начало и конец внутреннего
    didSet {
      leadingThumbnailViewConstraint?.constant = thumbnailViewStartingDistance
      trailingDraggedViewConstraint?.constant = thumbnailViewStartingDistance
      setNeedsLayout()
    }
  }
  
  public var isEnabled:Bool = true {
    didSet {
      animationChangedEnabledBlock?(isEnabled)
    }
  }
  
  public var animationChangedEnabledBlock:((Bool) -> Void)?
  // MARK: Default styles
  public var sliderCornerRadious: CGFloat = 8 { // текст поле свайпа
    didSet {
      sliderHolderView.layer.cornerRadius = sliderCornerRadious
      draggedView.layer.cornerRadius = sliderCornerRadious
    }
  }
  public var defaultSliderBackgroundColor: UIColor = UIColor(red:0.1, green:0.61, blue:0.84, alpha:0.1) {
    didSet {
      sliderHolderView.backgroundColor = defaultSliderBackgroundColor
      sliderTextLabel.textColor = defaultSliderBackgroundColor
    }
  }
  
  // MARK: Private Properties
  private var leadingThumbnailViewConstraint: NSLayoutConstraint?
  private var leadingTextLabelConstraint: NSLayoutConstraint?
  private var topSliderConstraint: NSLayoutConstraint?
  private var topThumbnailViewConstraint: NSLayoutConstraint?
  private var trailingDraggedViewConstraint: NSLayoutConstraint?
  private var xPositionInThumbnailView: CGFloat = 0
  private var xEndingPoint: CGFloat {
    get {
      return (self.view.frame.maxX - thumnailImageView.bounds.width - thumbnailViewStartingDistance)
    }
  }
  private var isFinished: Bool = false
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  private var panGestureRecognizer: UIPanGestureRecognizer!
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setupView()
  }
  
  private func setupView() {
    
    self.addSubview(view)
    view.layer.cornerRadius = 8                    //////////////////// cornerRadius
    view.addSubview(thumnailImageView)
    thumnailImageView.layer.cornerRadius = 8
    view.addSubview(sliderHolderView)
    view.addSubview(draggedView)
    draggedView.addSubview(sliderTextLabel)
    sliderHolderView.addSubview(textLabel)
    view.bringSubviewToFront(self.thumnailImageView) // без вю нет скролинга
    thumnailImageView.addSubview(textForButtonLabel)
    setupConstraint()
    setStyle()
    // Add pan gesture
    panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
    panGestureRecognizer.minimumNumberOfTouches = 1
    thumnailImageView.addGestureRecognizer(panGestureRecognizer)
  }
  
  private func setupConstraint() {
    view.translatesAutoresizingMaskIntoConstraints = false
    thumnailImageView.translatesAutoresizingMaskIntoConstraints = false
    sliderHolderView.translatesAutoresizingMaskIntoConstraints = false
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    sliderTextLabel.translatesAutoresizingMaskIntoConstraints = false
    draggedView.translatesAutoresizingMaskIntoConstraints = false
    textForButtonLabel.translatesAutoresizingMaskIntoConstraints = false
    
    textForButtonLabel.trailingAnchor.constraint(equalTo: thumnailImageView.trailingAnchor).isActive = true
    textForButtonLabel.centerYAnchor.constraint(equalTo: thumnailImageView.centerYAnchor).isActive = true
    textForButtonLabel.leadingAnchor.constraint(equalTo: thumnailImageView.leadingAnchor).isActive = true
    textForButtonLabel.centerXAnchor.constraint(equalTo: thumnailImageView.centerXAnchor).isActive = true
    
    // Setup for view длинна всего вю
    view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    // Setup for circle View
    leadingThumbnailViewConstraint = thumnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    leadingThumbnailViewConstraint?.isActive = true
    
    topThumbnailViewConstraint = thumnailImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
    topThumbnailViewConstraint?.isActive = true
    
    thumnailImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    thumnailImageView.heightAnchor.constraint(equalTo: thumnailImageView.widthAnchor, constant: -55).isActive = true // ширена кнопки
    
    // Setup for slider holder view - Настройка для просмотра держателя слайдера
    topSliderConstraint = sliderHolderView.topAnchor.constraint(equalTo: view.topAnchor, constant: sliderViewTopDistance)
    topSliderConstraint?.isActive = true
    sliderHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    sliderHolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    sliderHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    // Setup for textLabel
    textLabel.topAnchor.constraint(equalTo: sliderHolderView.topAnchor).isActive = true
    textLabel.centerYAnchor.constraint(equalTo: sliderHolderView.centerYAnchor).isActive = true
    leadingTextLabelConstraint = textLabel.leadingAnchor.constraint(equalTo: sliderHolderView.leadingAnchor, constant: 60)
    leadingTextLabelConstraint?.isActive = true
    textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-8)).isActive = true
    
    // Setup for sliderTextLabel
    sliderTextLabel.topAnchor.constraint(equalTo: textLabel.topAnchor).isActive = true
    sliderTextLabel.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true
    sliderTextLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor).isActive = true
    sliderTextLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor).isActive = true
    
    // Setup for Dragged View
    draggedView.leadingAnchor.constraint(equalTo: sliderHolderView.leadingAnchor).isActive = true
    draggedView.topAnchor.constraint(equalTo: sliderHolderView.topAnchor).isActive = true
    draggedView.centerYAnchor.constraint(equalTo: sliderHolderView.centerYAnchor).isActive = true
    trailingDraggedViewConstraint = draggedView.trailingAnchor.constraint(equalTo: thumnailImageView.trailingAnchor, constant: thumbnailViewStartingDistance)
    trailingDraggedViewConstraint?.isActive = true
    
  }
  
  private func setStyle() {
    textLabel.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    textLabel.textAlignment = .center
    
  }
  
  // Нажмите на эскиз с точкой
  private func isTapOnThumbnailViewWithPoint(_ point: CGPoint) -> Bool{
    return self.thumnailImageView.frame.contains(point)
  }
  
  //обновить Thumbnail X Position
  private func updateThumbnailXPosition(_ x: CGFloat) {
    leadingThumbnailViewConstraint?.constant = x
    setNeedsLayout()
  }
  
  // MARK: UIPanGestureRecognizer
  @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
    if isFinished || !isEnabled {
      return
    }
    let translatedPoint = sender.translation(in: view).x
    switch sender.state {
    case .began:
      break
    case .changed:
      if translatedPoint >= xEndingPoint {
        updateThumbnailXPosition(xEndingPoint)
        return
      }
      if translatedPoint <= thumbnailViewStartingDistance {
        textLabel.alpha = 1
        updateThumbnailXPosition(thumbnailViewStartingDistance)
        return
      }
      updateThumbnailXPosition(translatedPoint)
      draggedView.alpha = (xEndingPoint + translatedPoint) / xEndingPoint
      break
    case .ended:
      if translatedPoint >= xEndingPoint {
        textLabel.alpha = 0
        updateThumbnailXPosition(xEndingPoint)
        // Finish action
        isFinished = true
        delegate?.mtSlideToOpenDelegateDidFinish(self)
        return
      }
      if translatedPoint <= thumbnailViewStartingDistance {
        textLabel.alpha = 1
        updateThumbnailXPosition(thumbnailViewStartingDistance)
        return
      }
      UIView.animate(withDuration: animationVelocity) {
        self.leadingThumbnailViewConstraint?.constant = self.thumbnailViewStartingDistance
        self.textLabel.alpha = 1
        self.layoutIfNeeded()
      }
      break
    default:
      break
    }
  }
  // Others сбросить состояние с анимацией
  public func resetStateWithAnimation(_ animated: Bool) {
    let action = {
      self.leadingThumbnailViewConstraint?.constant = self.thumbnailViewStartingDistance
      self.textLabel.alpha = 1
      self.layoutIfNeeded()
      //
      self.isFinished = false
    }
    if animated {
      UIView.animate(withDuration: animationVelocity) {
        action()
      }
    } else {
      action()
    }
  }
}

class MTRoundImageView: UIImageView {
  override func layoutSubviews() {
  }
}
