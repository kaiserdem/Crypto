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
  
  
  @IBOutlet weak var allCountAssetsLabel: UILabel!
  @IBOutlet var contentViewOutlet: UIView!
  
  @IBOutlet weak var backBarCornerView: UIView!
  
  @IBOutlet weak var navItemOutlet: UINavigationItem!
  
  @IBOutlet weak var allCustButOutlet: UIView!
  @IBOutlet weak var watchlistCustButOutlet: UIView!
  
  @IBOutlet weak var serchButtonOutlet: UIButton!
  @IBOutlet weak var serchtTFOutlet: UITextField!
  
  var assetsResours: [Assets] = []
  var assets: [Assets]?
  var prices: AssetPriceWSModel?
  var pricesArrayEmpty: [NSMutableArray] = []
  var assetsArrayEmpty: [Assets] = []
  var data: [[Datum]]?
  var watchlistArray: [Assets] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    setupNavBarSettings()
    setupTopBarSettings()
    fetchAssetsResours()
    fetchSparklineData()

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
            for oldId in self!.assets ?? self!.assetsArrayEmpty {
              if oldId.id.isEqual(newId) {
                sameId = 1
                if ((i.lastObject as? Double) != nil) {
                  let newPrice = i.lastObject
                  if sameId == 1 {
                    for oldPrice in self!.assets! {
                      if oldPrice.id.isEqual(i.firstObject) {
                        oldPrice.price = newPrice as! Double
                      }
                    }
                  }
                }
              }
            }
          }
          DispatchQueue.main.async {
            (self!.children[0] as? InfoTableViewController)?.assetsModel = (self?.assets!)!
            (self!.children[0] as? InfoTableViewController)?.tableView.reloadData()
          }
        }
      }
    }
  }
  
  func fetchSparklineData() {
    SparklineApiWebSocket.sharedInstance.fetchWebSocketSparkline { [weak self] (dataSparklineArray: [[Datum]]?) in
      guard let  strongSelf = self else  { return }
      strongSelf.data = dataSparklineArray
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
      self.watchlistCustButOutlet.layer.shadowOpacity = 0.1
      
      self.allCustButOutlet.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
      self.allCustButOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
      self.allCustButOutlet.layer.shadowRadius = 0
      self.allCustButOutlet.layer.shadowOpacity = 0
      
      let arraySlice = self.assetsResours[..<5]
      self.watchlistArray = Array(arraySlice)
      (self.children[0] as? InfoTableViewController)?.assetsModel = self.watchlistArray
      print(self.watchlistArray.count)
      (self.children[0] as? InfoTableViewController)?.tableView.reloadData()
    }
  }
  @objc func allBtnAction(_ sender:UITapGestureRecognizer){
    DispatchQueue.main.async {
      self.allCustButOutlet.backgroundColor = .white
      self.allCustButOutlet.layer.shadowOffset = CGSize(width: 0.5, height: -1.0)
      self.allCustButOutlet.layer.shadowRadius = 1.5
      self.allCustButOutlet.layer.shadowOpacity = 0.1
      
      self.watchlistCustButOutlet.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
      self.watchlistCustButOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
      self.watchlistCustButOutlet.layer.shadowRadius = 0
      self.watchlistCustButOutlet.layer.shadowOpacity = 0
      
      // children - доступ к массиву дочерних контроллеров
      (self.children[0] as? InfoTableViewController)?.assetsModel = self.assetsResours
      (self.children[0] as? InfoTableViewController)?.tableView.reloadData()
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "infoSegue" {
      let infoTabVC = segue.destination as? InfoTableViewController
            // первые данные
      fetchAssets()
      if self.assets == nil {
        fetchAssetsResours()
        infoTabVC?.assetsModel = self.assetsResours
      } else if ((infoTabVC?.assetsModel = self.assets!) != nil) {
      }
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
    titleLabel.text = "Market Prices"
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
}

/*
 Давайте еще раз разберем что тут происходит.
 
 Основной ViewController для отображения содержания Container View совершает переход segue к контроллеру InfoTableViewController. Это означает, что перед переходом вызывается метод prepare(for segue:), в котором мы можем получить доступ к контроллеру, в который совершается переход. После получения ссылки на этот контроллер, мы передаем массив с данными в массив модели таблицы.
 
 Внимание! Для проверки работоспособности этой передачи информации не забудьте в классе InfoTableViewController в методе viewDidLoad() закомментировать строку с добавлением тестовых данных.
 
 Запустите проект заново и посмотрите результат:
 
 В массив data мы заносим данные, которые хотим передать в таблицу.
 Используя свойство childViewControllers нашего ViewController мы получаем доступ к массиву дочерних контроллеров. С учетом того, что в нашем случае он единственный, мы используем индекс [0] для получения ссылки на него.  И в свойство modelArray передаем массив data
 Факта передачи данных недостаточно. Таблица уже отображает данные, которые в нее были загружены при инициализации. Хоть в массиве модели уже присутствуют другие данные, их таблица не отобразит. Именно поэтому мы вызываем метод reloadData() у свойства tableView. В этом случае новые данные отобразятся.
 */
