//
//  MapViewController.swift
//  MapDiary
//
//  Created by Yuki Shinohara on 2020/08/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
/// searchBarの結果をマップに反映
/// ダブルタップで入力画面へ

import UIKit
import XLPagerTabStrip
import MapKit

class MapViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
            }
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "マップ")
    }
    
}

extension MapViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //キーボードを閉じる。resignFirstResponderはdelegateメソッド
        textField.resignFirstResponder()
        
        //入力された文字を取り出す
        if let searchKey = textField.text {
            
            //入力された文字をデバッグエリアの表示
            //         print(searchKey)
            
            //CLGeocoderインスタンスを取得
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                
                //位置情報が存在する場合（定数geocoderに値が入ってる場合)はunwrapPlacemarksに取り出す。
                if let unwrapPlacemarks = placemarks {
                    
                    //1件目の情報を取り出す
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        //位置情報を取り出す
                        if let location = firstPlacemark.location {
                            
                            //位置情報から緯度経度をtargetCoordinateに取り出す
                            let targetCoordinate = location.coordinate
                            
                            //緯度経度をデバッグエリアに表示
                            print(targetCoordinate)
                            
                            //MKPointAnnotationインスタンスを取得し、ピンを生成
                             let pin = MKPointAnnotation()

                            //ピンの置く場所に緯度経度を設定
                             pin.coordinate = targetCoordinate

                            //ピンのタイトルを設定
                             pin.title = searchKey

                            //ピンを地図に置く
                             self.mapView.addAnnotation(pin)

                            //検索地点の緯度経度を中心に半径500mの範囲を表示
                             self.mapView.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            }
            )
            
        }
        //デフォルト動作を行うのでtureを返す。返り値型をBoolにしているため、この記述がないとエラーになる。
        return true
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
