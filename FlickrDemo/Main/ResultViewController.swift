//
//  ResultViewController.swift
//  FlickrDemo
//
//  Created by Pony on 2020/5/28.
//  Copyright © 2020 Pony. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias photoData = searchPhotoType.Response.Photos.Photo
    var searchData: [photoData] = []
    var saveData: [photoData] = []
    var result = ""
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.title = "搜尋結果 \(result)"
        
        if let savedPhotos = defaults.object(forKey: "savedPhoto") as? Data {
            let decoder = JSONDecoder()
            if let loadedPhotos = try? decoder.decode([photoData].self, from: savedPhotos) {
                saveData = loadedPhotos
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.data = searchData[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.saveData.append(searchData[indexPath.row])
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(saveData) {
            defaults.set(encoded, forKey: "savedPhoto")
            self.displayAlert("Saved")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width / 2) - 20

        return CGSize(width: width, height: width)
    }
}
