//
//  ViewController.swift
//  BouncyButtonAndTable
//
//  Created by Harry Cao on 18/6/17.
//  Copyright © 2017 HarryCodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  lazy var tableButton: UIButton = {
    let button = UIButton()
    button.setTitle("Table", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(red: 96/255, green: 125/255, blue: 139/255, alpha: 1)
    button.layer.cornerRadius = 30
    button.addTarget(self, action: #selector(handleTableButtonTapped), for: .touchUpInside)
    return button
  }()
  
  lazy var bouncyButton: UIButton = {
    let button = UIButton()
    button.setTitle("Bouncy", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 64/255, alpha: 1)
    button.layer.cornerRadius = 30
    button.addTarget(self, action: #selector(handleBouncyButtonTapped), for: .touchUpInside)
    return button
  }()
  
  var tableButtonConstraints = [NSLayoutConstraint]()
  var bouncyButtonConstraints = [NSLayoutConstraint]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = .white
    self.view.addSubview(tableButton)
    self.view.addSubview(bouncyButton)
    
     tableButtonConstraints = tableButton.constraintCenterTo(centerX: self.view.centerXAnchor, xConstant: -self.view.frame.width, centerY: self.view.centerYAnchor, yConstant: -100)
    _ = tableButton.constraintSizeToConstant(widthConstant: 150, heightConstant: 60)
    
    
    bouncyButtonConstraints = bouncyButton.constraintCenterTo(centerX: self.view.centerXAnchor, xConstant: -self.view.frame.width, centerY: self.view.centerYAnchor, yConstant: 100)
    bouncyButtonConstraints.append(contentsOf: bouncyButton.constraintSizeToConstant(widthConstant: 150, heightConstant: 60))
  }
  
  var didAnimateButtons = false
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Slide 2 buttons in
    if !didAnimateButtons {
      UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.tableButtonConstraints[0].constant = 0
        self.view.layoutIfNeeded()
      }, completion: nil)
      
      UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.bouncyButtonConstraints[0].constant = 0
        self.view.layoutIfNeeded()
      }, completion: nil)
      
      didAnimateButtons = true
    }
  }
  
  @objc
  func handleTableButtonTapped() {
    navigationController?.pushViewController(TableViewController(), animated: true)
  }
  
  @objc
  func handleBouncyButtonTapped(_ sender: UIButton) {
    let originalBounds = sender.bounds
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
      sender.bounds = CGRect(x: originalBounds.origin.x - 25, y: 0, width: originalBounds.width + 100, height: originalBounds.height)
    }) { (_) in
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
        sender.bounds = originalBounds
      }, completion: nil)
    }
  }
}

