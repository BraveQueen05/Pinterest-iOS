//
//  CSMAutomaticStatusBarColor.swift
//  CoreSoleraMobile
//
//  Created by Felix Chacaltana on 7/30/18.
//

import UIKit

public extension UIViewController {
    
    public func classNameAsString() -> String {
        return String(describing: type(of: self))
    }
    
    func getAutomaticStatusBarColor() -> UIStatusBarStyle{
        
        let sizeStatus = UIApplication.shared.statusBarFrame.size
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: sizeStatus.width, height: sizeStatus.height))
        let img = renderer.image { (context) in
            self.view.layer.render(in: context.cgContext)
        }
        
        let color = self.averageColor(img) ?? UIColor.white
        
        let red = Int((color.cgColor.components?[0] ?? 0) * 255)
        let green = Int((color.cgColor.components?[1] ?? 0) * 255)
        let blue = Int((color.cgColor.components?[2] ?? 0) * 255)
        let alpha = Int((color.cgColor.components?[3] ?? 1))
        
        print("red:     \(red)")
        print("green:   \(green)")
        print("blue:    \(blue)")
        print("alpha:   \(alpha)")
        
        return (red <= 180 && green <= 180 && blue <= 180) ? .lightContent : .default
        
    }
    
    fileprivate func averageColor(_ image: UIImage) -> UIColor? {
        
        guard let img = CIImage(image: image) else { return nil }
        let extentVector = CIVector(x: img.extent.origin.x, y: img.extent.origin.y, z: img.extent.size.width, w: img.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: img, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [CIContextOption.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
}
