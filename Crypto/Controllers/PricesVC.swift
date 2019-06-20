//
//  ViewController.swift
//  Crypto
//
//  Created by Kaiserdem on 18.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class PricesVC: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var allCountAssetsLabel: UILabel!
  @IBOutlet var contentViewOutlet: UIView!
  
  @IBOutlet weak var backBarCornerView: UIView!
  @IBOutlet weak var navigationBarOutlet: UINavigationBar!
  
  @IBOutlet weak var navBarOutlet: UINavigationItem!
  
  @IBOutlet weak var allCustButOutlet: UIView!
  @IBOutlet weak var watchlistCustButOutlet: UIView!
  
  @IBOutlet weak var serchButtonOutlet: UIButton!
  @IBOutlet weak var serchtTFOutlet: UITextField!
  
  var assets: [Assets]?

  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    setupNavBarSettings()
    setupTopBarSettings()
    fetchAssets()

  }
  func fetchAssets() {
    AssetsApiWebSocket.sharedInstance.fetchAssets { [weak self] (assetsArray: [Assets]?) in
      guard let strongSelf = self else { return }
      strongSelf.assets = assetsArray
      print("PricesVC \(String(describing: assetsArray))")
    }
  }
  private func setupTopBarSettings() {
    
    serchtTFOutlet.delegate = self
    
    serchButtonOutlet.setImage(UIImage(named: "search64")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
    serchButtonOutlet.imageView?.tintColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    backBarCornerView.layer.cornerRadius = 6
    watchlistCustButOutlet.layer.cornerRadius = 6
    
    allCountAssetsLabel.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    allCountAssetsLabel.layer.cornerRadius = 8
    
    allCustButOutlet.layer.cornerRadius = 6
    allCustButOutlet.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    allCustButOutlet.layer.shadowRadius = 1.5
    allCustButOutlet.layer.shadowOpacity = 0.1
    
    let allGesture = UITapGestureRecognizer(target: self, action:  #selector (allBtnAction (_:)))
    let watchlistGesture = UITapGestureRecognizer(target: self, action:  #selector (watchlistBtnAction (_:)))
    
    self.watchlistCustButOutlet.addGestureRecognizer(watchlistGesture)
    self.allCustButOutlet.addGestureRecognizer(allGesture)
  }
  
  private func setupNavBarSettings() {
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    let titleLabel = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 0, height:0))
    titleLabel.text = "Market Prices"
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name:"Helvetica", size:21)
    
    navBarOutlet.titleView = titleLabel
    navigationBarOutlet.setGradientBackground(colors: colors)
    
  }
  @objc func watchlistBtnAction(_ sender:UITapGestureRecognizer){
    watchlistCustButOutlet.backgroundColor = .white
    watchlistCustButOutlet.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    watchlistCustButOutlet.layer.shadowRadius = 1.5
    watchlistCustButOutlet.layer.shadowOpacity = 0.1
    
    allCustButOutlet.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    allCustButOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    allCustButOutlet.layer.shadowRadius = 0
    allCustButOutlet.layer.shadowOpacity = 0
    
    let data = ["Первый", "второй", "Третий", "седьмой", "Тринадцатый", "Шестьдесят два", "Восемьдесят восемь", "девяносто три", "двести", "пятьсот", "Девятьсот", "тысяча", "Десять тысяч", "Сто тысяч", "девятьсот тысяч", "Миллион" ]
    (children[0] as? InfoTableViewController)?.modelArray = data
    (children[0] as? InfoTableViewController)?.tableView.reloadData()
  }
  
  @objc func allBtnAction(_ sender:UITapGestureRecognizer){
    allCustButOutlet.backgroundColor = .white
    allCustButOutlet.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    allCustButOutlet.layer.shadowRadius = 1.5
    allCustButOutlet.layer.shadowOpacity = 0.1
    
    watchlistCustButOutlet.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    watchlistCustButOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    watchlistCustButOutlet.layer.shadowRadius = 0
    watchlistCustButOutlet.layer.shadowOpacity = 0
    
    let data = ["Красный", "Белый", "Желтый", "Зеленый", "Синий", "Оранжевый", "Черный"]
    // children - доступ к массиву дочерних контроллеров
    (children[0] as? InfoTableViewController)?.modelArray = data
    (children[0] as? InfoTableViewController)?.tableView.reloadData()
    
  }
  
  @IBAction func serchButtonAction(_ sender: Any) {
    serchtTFOutlet.text = ""
    serchButtonOutlet.setImage(UIImage(named: "search64")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
    serchtTFOutlet.resignFirstResponder()
  }
  
  @IBAction func serchTFAction(_ sender: Any) {
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "infoSegue" {
      let infoTabVC = segue.destination as? InfoTableViewController
      infoTabVC?.modelArray = ["Красный", "Белый", "Желтый", "Зеленый", "Синий", "Оранжевый", "Черный"]
    }
  }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      serchtTFOutlet.resignFirstResponder()
      serchButtonOutlet.setImage(UIImage(named: "search64")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
      return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      serchButtonOutlet.setImage(UIImage(named: "cancel")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
    }

}

