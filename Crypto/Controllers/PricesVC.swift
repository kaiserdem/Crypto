//
//  ViewController.swift
//  Crypto
//
//  Created by Kaiserdem on 18.06.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Charts

class PricesVC: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
  @IBOutlet weak var widthView: NSLayoutConstraint!
  @IBOutlet weak var allCountAssetsLabel: UILabel!
  @IBOutlet weak var contentViewOutlet: UIView!
  @IBOutlet weak var backBarCornerView: UIView!
  @IBOutlet weak var navItemOutlet: UINavigationItem!
  @IBOutlet weak var allCustButOutlet: UIView!
  @IBOutlet weak var watchlistCustButOutlet: UIView!
  @IBOutlet weak var serchButtonOutlet: UIButton!
  @IBOutlet weak var serchtTFOutlet: UITextField!
  @IBOutlet weak var offlineBarButton: UIBarButtonItem! {
    didSet {
      let icon = UIImage(named: "offline")
      let iconSize = CGRect(origin: .zero, size: icon!.size)
      let iconButton = UIButton(frame: iconSize)
      iconButton.setBackgroundImage(icon, for: .normal)
      iconButton.addTarget(self, action: #selector(pressedOfflineAction), for: .touchUpInside)
      offlineBarButton.customView = iconButton
      offlineBarButton.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
      
      UIView.animate(withDuration: 1.0,
                                 delay: 0.5,
                                 options: [ .curveEaseOut, .repeat],
                                 animations: {

                                  UIView.setAnimationRepeatCount(10)
        self.offlineBarButton.customView!.transform = CGAffineTransform.identity
      }, completion: nil)
    }
  }

  var assetsResours: [Assets] = []
  var assets: [Assets] = []
  var prices: AssetPriceWSModel?
  var pricesArrayEmpty: [NSMutableArray] = []
  var assetsArrayEmpty: [Assets] = []
  var watchlistArray: [Assets] = []
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBarSettings()
    setupTopBarSettings()
    
    activitiIndicator.startAnimating()
    activitiIndicator.hidesWhenStopped = true
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(disconectedNotified),
                                           name: NSNotification.Name(rawValue: keyDissconectedNotification),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(conectedNotified),
                                           name: NSNotification.Name(rawValue: keyConectedNotification),
                                           object: nil)
  }
  
  func disconectedWebSocket() {
    offlineBarButton.tintColor = .red
    offlineBarButton.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
    UIView.animate(withDuration: 0.7,
                   delay: 0.5,
                   options: [ .curveEaseOut, .repeat],
                   animations: {
                    
                    UIView.setAnimationRepeatCount(15)
                    self.offlineBarButton.customView!.transform = CGAffineTransform.identity
    }) { (true) in
    }
  }
  
  @objc func disconectedNotified() {
    offlineBarButton.customView!.isHidden = false
    print("Disconected Notified_Disconected Notified_Disconected Notified")
    disconectedWebSocket()
  }
  
  @objc func conectedNotified() {
    offlineBarButton.customView!.isHidden = true
    print("ConectedNotified_ConectedNotified_Conected Notified")
  }
  @objc func pressedOfflineAction() {
    offlineBarButton.customView!.transform = CGAffineTransform(scaleX: 0, y: 0)
    UIView.animate(withDuration: 0.7,
                   delay: 0.5,
                   options: [ .curveEaseOut, .repeat],
                   animations: {

                    UIView.setAnimationRepeatCount(20)
                    self.offlineBarButton.customView!.transform = CGAffineTransform.identity
    }, completion: nil)
  }

  
  func fetchAssets() {
    AssetsApiWebSocket.sharedInstance.fetchAssets { [weak self] (assetsArray: [Assets]?) in
      guard let strongSelf = self else { return }
      strongSelf.assets = assetsArray!

      AssetPriceApiWebSocket.sharedInstance.fetchWebSocket { [weak self](priceArray: AssetPriceWSModel?) in

        guard let strongSelf = self else { return }
        strongSelf.prices = priceArray
        var sameId = 0
        for i in (priceArray?.prices ?? self!.pricesArrayEmpty) {
          if ((i.firstObject as? NSString) != nil) {
            let newId = i.firstObject
            for oldId in self!.assets {
              if oldId.id!.isEqual(newId) {
                sameId = 1
                if ((i.lastObject as? Double) != nil) {
                  let newPrice = i.lastObject
                  if sameId == 1 {
                    for oldPrice in self!.assets {
                      if oldPrice.id!.isEqual(i.firstObject) {
                        oldPrice.price = newPrice as? Double
                      }
                    }
                  }
                }
              }
            }
          }
          DispatchQueue.main.async {
            (self!.children[0] as? PricesTableVC)?.assetsModel = (self?.assets)!
            (self!.children[0] as? PricesTableVC)?.tableView.reloadData()
            self?.activitiIndicator.stopAnimating()
          }
        }
      }
    }
  }
  func fetchAssetsResours() {
    ApiForResource.sharedInstance.fetchAssetsResource { [weak self] (assetsArray: [Assets]?) in
      guard let strongSelf = self else { return }
      strongSelf.assetsResours = assetsArray!
    }
  }
  @objc func watchlistBtnAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.watchlistCustButOutlet.backgroundColor = .white
      self.watchlistCustButOutlet.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
      self.watchlistCustButOutlet.layer.shadowRadius = 1.5
      self.watchlistCustButOutlet.layer.shadowOpacity = 0.2
      
      self.allCustButOutlet.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
      self.allCustButOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
      self.allCustButOutlet.layer.shadowRadius = 0
      self.allCustButOutlet.layer.shadowOpacity = 0
      
      let arraySlice = self.assets[..<5]
      self.watchlistArray = Array(arraySlice)
      (self.children[0] as? PricesTableVC)?.assetsModel = self.watchlistArray
      (self.children[0] as? PricesTableVC)?.assetsModel = self.watchlistArray
      (self.children[0] as? PricesTableVC)?.tableView.reloadData()
    }
  }
  @objc func allBtnAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.allCustButOutlet.backgroundColor = .white
      self.allCustButOutlet.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
      self.allCustButOutlet.layer.shadowRadius = 1.5
      self.allCustButOutlet.layer.shadowOpacity = 0.2
      
      self.watchlistCustButOutlet.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
      self.watchlistCustButOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
      self.watchlistCustButOutlet.layer.shadowRadius = 0
      self.watchlistCustButOutlet.layer.shadowOpacity = 0
      
      (self.children[0] as? PricesTableVC)?.assetsModel = self.assets
      (self.children[0] as? PricesTableVC)?.tableView.reloadData()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "infoSegue" {
      let infoTabVC = segue.destination as? PricesTableVC
       fetchAssets()
       infoTabVC?.assetsModel = self.assets
    }
  }
  
  @IBAction func serchButtonAction(_ sender: Any) {
    serchtTFOutlet.text = ""
    serchButtonOutlet.setImage(UIImage(named: "search64")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
    serchtTFOutlet.resignFirstResponder()
  }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      serchtTFOutlet.resignFirstResponder()
      serchButtonOutlet.setImage(UIImage(named: "search64")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
      return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      serchButtonOutlet.setImage(UIImage(named: "cancel")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
    }
  
  private func setupNavBarSettings() {
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7960784314, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.6862745098, blue: 0.1490196078, alpha: 1)]
    let titleLabel = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 0, height:0))
    titleLabel.text = NSLocalizedString("Market Prices", comment: "Market Prices")
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name:"Helvetica", size:21)
    
    self.navItemOutlet.titleView = titleLabel
    self.navigationController?.navigationBar.setGradientBackground(colors: colors)
  }
  
  private func setupTopBarSettings() {
    serchtTFOutlet.delegate = self
    
    serchButtonOutlet.setImage(UIImage(named: "search64")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
    serchButtonOutlet.imageView?.tintColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    backBarCornerView.layer.cornerRadius = 8
    watchlistCustButOutlet.layer.cornerRadius = 6
    
    allCountAssetsLabel.backgroundColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    allCountAssetsLabel.layer.cornerRadius = 8
    
    allCustButOutlet.layer.cornerRadius = 6
    allCustButOutlet.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
    allCustButOutlet.layer.shadowRadius = 1.5
    allCustButOutlet.layer.shadowOpacity = 0.2
    
    let allGesture = UITapGestureRecognizer(target: self, action:  #selector (allBtnAction (_:)))
    let watchlistGesture = UITapGestureRecognizer(target: self, action:  #selector (watchlistBtnAction (_:)))
    
    self.watchlistCustButOutlet.addGestureRecognizer(watchlistGesture)
    self.allCustButOutlet.addGestureRecognizer(allGesture)
  }
}
