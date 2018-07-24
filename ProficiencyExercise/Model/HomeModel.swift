//
//  HomeModel.swift
//  ProficiencyExercise
//
//  Created by Ajay Parmar on 7/23/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import UIKit

class HomeModel: NSObject {

     //Table
     var tableView : UITableView?
    
     var tableRowsDataArr : NSArray = []
    
}

extension HomeModel: UITableViewDataSource,UITableViewDelegate{
    
    // Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRowsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellIdentifier, for: indexPath) as! HomeTableViewCell
        let tableDataDictionary = self.tableRowsDataArr[indexPath.row] as! NSDictionary
        if let title = tableDataDictionary["title"] as? String {
            cell.titleText.text = title
        }
        if let description = tableDataDictionary["description"] as? String {
            cell.descriptionText.text = description
        }
        if let imageHref = tableDataDictionary["imageHref"] as? String {
            cell.homeTableImage.downloadImage(link: imageHref)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //Custom row height
        return 150.0
    }
}


extension HomeModel{
    
    func makeAPICall() {
        let url = URL(string: baseURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error as Any)
            } else {
                let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    print("could not convert data to UTF-8 format")
                    return
                }
                do {
                    let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                    
                    print(responseJSONDict)
                    
                    let mainResponseDict = responseJSONDict as! NSDictionary
                    let navBarTitle = mainResponseDict["title"] as! NSString
                    self.tableRowsDataArr = mainResponseDict["rows"] as! NSArray
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                    }
                    
                } catch {
                    print(error)
                }
            }

            }.resume()
    }
    
    
}

extension UIImageView {
    func downloadImage(url: URL, fromMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let imageData = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = imageData
            }
            }.resume()
    }
    func downloadImage(link: String, fromMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadImage(url: url, fromMode: mode)
    }
}

