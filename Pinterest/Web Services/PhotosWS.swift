//
//  PhotosWS.swift
//  Pinterest
//
//  Created by Alumno on 6/17/19.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

import UIKit

class PhotosWS: NSObject {
  typealias Photos = (_ array: [PinterestBE]) -> Void
  
  class func getPhotos(_ success: @escaping Photo){
    let endpoint = ""
    let path = ""
    
    let url = endpoint+path
    
    CSMWebServiceManager.shared.request.getRequest(urlString: url, parameters: nil){ (response) in
      let arrayResponsePhotos = response.JSON?.dictionary["photos"]?.array ?? []
      var arrayPinterestBE = [PinterestBE]()
      
      for json in arrayResponsePhotos {
        let objPinterestBE = PinterestBE.parse(json)
        arrayPinterestBE.append(objPinterestBE)
      }
      
      success(arrayPinterestBE)
    }
  }
}
