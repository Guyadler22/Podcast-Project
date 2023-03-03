//
//  PodcastCellTableViewCell.swift
//  iTunesPodcastProject
//
//  Created by Guy Adler on 26/02/2023.
//

import UIKit
import Kingfisher

class PodcastCellTableViewCell: UITableViewCell {
    
    static let CELL_HEIGHT : CGFloat = 100
    
    static let identifier = "PodcastCellTableViewCell"
    
    private let avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let artistName:UILabel = {
        let artistLabel = UILabel()
        artistLabel.textColor = .label
        artistLabel.textAlignment = .left
        artistLabel.font = .systemFont(ofSize: 18, weight: .regular)
        artistLabel.text = "artistName"
        artistLabel.layer.cornerRadius = 8
        return artistLabel
    }()
    
    private let trackName:UILabel = {
        let trackLabel = UILabel()
        trackLabel.textColor = .label
        trackLabel.textAlignment = .left
        trackLabel.font = .systemFont(ofSize: 18, weight: .regular)
        trackLabel.text = "trackName"
        return trackLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let contentStackViewVerticalTextFields = UIStackView(arrangedSubviews: [trackName,artistName])
        
        let contentStackViewHorizontal = UIStackView(arrangedSubviews: [avatar, contentStackViewVerticalTextFields])
        
        contentStackViewHorizontal.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width - 32, height: PodcastCellTableViewCell.CELL_HEIGHT))
        
        contentStackViewHorizontal.axis = .horizontal
        contentStackViewHorizontal.spacing = 24
        contentStackViewHorizontal.distribution = .fillEqually
        contentStackViewVerticalTextFields.axis = .vertical
        contentStackViewVerticalTextFields.distribution = .fillEqually
        contentView.addSubview(contentStackViewHorizontal)
    }
    
    func populate(_ podcast: PodcastResult) {
        self.artistName.text = podcast.artistName
        self.trackName.text = podcast.artistName

        // Show the image by using Kf library
        let url = URL(string: podcast.artworkUrl100)
        self.avatar.kf.setImage(with: url)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


