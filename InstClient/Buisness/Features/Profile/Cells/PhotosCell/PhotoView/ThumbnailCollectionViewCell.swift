//
//  ThumbnailCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 08.12.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

let operationQueue1: OperationQueue = {
    let operationQueue = OperationQueue()
    
    operationQueue.maxConcurrentOperationCount = 5
    
    return operationQueue
}()

class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.contentMode = .scaleAspectFill
    }
    
    func setBioValues(media: MediaModel.MediaStruct) {
        
        let operation = BlockOperation { [weak self] in
            
            if media.thumbnail == nil {
                
                DispatchQueue.main.async {
                    
                }
            }
            else {
                
                guard let url = URL(string: media.thumbnail!) else  {
                    return
                }
                
                do {
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        
                        self?.thumbnailImageView.image = UIImage(data: data)
                    }
                } catch {}
            }
        }
        operationQueue1.addOperation(operation)
    }
}
