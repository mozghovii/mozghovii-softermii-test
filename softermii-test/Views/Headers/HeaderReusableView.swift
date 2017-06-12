//
//  HeaderReusableView.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit
import SDWebImage
class HeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var postsButton: CustomButton!
    @IBOutlet weak var followersButton: CustomButton!
    @IBOutlet weak var followingButton: CustomButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func fillWithData(data: User) {
        postsButton.setCustomTitle(title: (data.posts?.count)!, subtitle: (data.posts?.name)!)
        followersButton.setCustomTitle(title: (data.followers?.count)!, subtitle: (data.followers?.name)!)
        followingButton.setCustomTitle(title: (data.following?.count)!, subtitle: (data.following?.name)!)
        avatarImageView.sd_setImage(with: data.avatarURL, placeholderImage: nil)
    }
    
}
