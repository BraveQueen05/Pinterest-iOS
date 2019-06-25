import UIKit
import AVFoundation

class PhotoStreamViewController: UICollectionViewController {
  
  @IBOutlet weak var clvPhotos: UICollectionView!
  
  var arrayImages = [PinterestBE]()
  var arrayImagesFilter = [PinterestBE]()
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  func getImages(){
    PhotosBL.getImages{(arrayImages) in
      self.arrayImages = arrayImages
      self.arrayImagesFilter = arrayImages
      self.clvPhotos.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   self.getImages()
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    collectionView?.backgroundColor = UIColor.clear
    collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
    // Set the PinterestLayout delegate
    if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
  }
  
}

extension PhotoStreamViewController: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    if searchText.trim().count == 0{
      self.arrayImagesFilter = self.arrayImages
    }else{
      self.arrayImagesFilter = self.arrayImages.filter({return $0.pinterest_title.contains(searchText)})
    }
    self.clvPhotos.reloadSections(IndexSet(integer: 0))
  }
}

extension PhotoStreamViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.arrayImagesFilter.count
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cellIdentifier = "PinterestCollectionViewCell"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
    as! PinterestCollectionViewCell
    cell.objPinterest = self.arrayImagesFilter[indexPath.row]
    if let annotateCell = cell as? AnnotatedPhotoCell {
      annotateCell.photo = arrayImages[indexPath.item]
      
    }
    return cell
  }
  
}

//MARK: - PINTEREST LAYOUT DELEGATE
extension PhotoStreamViewController : PinterestLayoutDelegate {
  
  // 1. Returns the photo height
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    return arrayImages[indexPath.item].image.size.height
  }

}
