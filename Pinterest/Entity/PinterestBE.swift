import UIKit

class PinterestBE: NSObject {
  var pinterest_img = ""
  var pinterest_title = ""
  var pinterest_subTitle = ""
  
  class func parse(_ json: CSMJSON) -> PinterestBE{
    let pinterest = PinterestBE()
    
    pinterest.pinterest_title = json.dictionary["title"]?.stringValue ?? ""
    pinterest.pinterest_subTitle = json.dictionary["subtitle"]?.stringValue ?? ""
    pinterest.pinterest_img = json.dictionary["imgCover"]?.stringValue ?? ""
    
    return pinterest
  }
}
