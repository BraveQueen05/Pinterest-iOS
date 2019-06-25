import UIKit

class PinterestCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imgPinterest : UIImageView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblSubTitle: UILabel!
  
  var objPinterest: PinterestBE! {
    didSet{
      self.actualizarData()
    }
  }
  
  func actualizarData(){
    self.lblTitle.text = self.objPinterest.pinterest_title
    self.imgPinterest.downloadImagenInUrl(self.objPinterest.pinterest_img, withPlaceHolderImage: nil) { (urlImagen, image) in
      if urlImagen == self.objPinterest.pinterest_img{
        self.imgPinterest.image = image
      }
    }
  }
}
