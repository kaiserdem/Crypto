//
//  Portfolio.swift
//  Crypto
//
//  Created by Kaiserdem on 20.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class Portfolio: UIViewController {

  @IBOutlet weak var navigationBarOutlet: UINavigationBar!
  @IBOutlet weak var navBarItemOutlet: UINavigationItem!

  override func viewDidLoad() {
        super.viewDidLoad()
    
  setupNavBarSettings()

  }
  
  private func setupNavBarSettings() {
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    let titleLabel = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 0, height:0))
    titleLabel.text = "Portfolio"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name:"Helvetica", size:21)
    
    navBarItemOutlet.titleView = titleLabel
    navigationBarOutlet.setGradientBackground(colors: colors)
  }

  
}
