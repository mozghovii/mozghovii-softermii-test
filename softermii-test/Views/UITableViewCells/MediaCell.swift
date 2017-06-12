//
//  MediaCell.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit
import SDWebImage
class MediaCell: UICollectionViewCell {
    @IBOutlet weak var previewImageView: UIImageView!
    public func configureCellWithModel(model: MediaModel) {
        previewImageView.sd_setImage(with: model.thumbnail, placeholderImage: nil)
    }
}
