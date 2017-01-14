//
//  PhotoCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 06.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

let operationQueue3: OperationQueue = {
    let operationQueue = OperationQueue()
    
    operationQueue.maxConcurrentOperationCount = 5
    
    return operationQueue
}()

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    func setPhotoValues(media: MediaModel.MediaStruct, screenWidth: CGFloat) {
        
        let operation = BlockOperation { [weak self] in
            
            if media.standard_resolution == nil {
                
                DispatchQueue.main.async {
                }
            }
            else {
                
                guard let url = URL(string: media.standard_resolution!) else {
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        
                        let imageAspectRatio = (UIImage(data: data)?.size.height)! / (UIImage(data: data)?.size.width)!
                        
                        self?.photoImageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: imageAspectRatio * screenWidth)
                        self?.photoImageView.image = UIImage(data: data)
                    }
                } catch {}
            }
        }
        
        operationQueue3.addOperation(operation)
    }
    
    static func getCellHeight(withScreenWidth width: CGFloat, media: MediaModel.MediaStruct) -> CGFloat {
        
        guard media.standResWidth == nil || media.standResHeight == nil else {
            
            let imageAspectRatio = media.standResHeight! / media.standResWidth!
            return imageAspectRatio * width
        }
      return width
    }
}
