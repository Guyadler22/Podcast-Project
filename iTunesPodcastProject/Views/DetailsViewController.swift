//
//  DetailsTableViewCell.swift
//  iTunesPodcastProject
//
//  Created by Guy Adler on 27/02/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    static let identifier = "DetailsTableViewController"
    
    var podcast : PodcastResult!

    private let avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private var artistName:UILabel = {
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
    
    private let releaseDate:UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.textColor = .label
        releaseDateLabel.textAlignment = .left
        releaseDateLabel.font = .systemFont(ofSize: 18, weight: .regular)
        releaseDateLabel.text = "trackName"
        return releaseDateLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let TextViewsStackView = UIStackView(arrangedSubviews: [avatar,artistName, trackName, releaseDate])
        
        TextViewsStackView.frame = CGRect(x: 0, y: 75, width: UIScreen.main.bounds.width,height:300)
        TextViewsStackView.alignment = .center
        TextViewsStackView.spacing = 24
        TextViewsStackView.axis = .vertical
        
        
    
        view.addSubview(TextViewsStackView)
        setDetails()
    }
    

    
    private func setDetails() {
        self.artistName.text = podcast.artistName
        self.releaseDate.text = podcast.releaseDate.replacingOccurrences(of: "T", with:" , ").replacingOccurrences(of: "Z", with:"")
        self.trackName.text = podcast.trackName
        // Show the image use the Kf library
        let url = URL(string: podcast.artworkUrl100)
        self.avatar.kf.setImage(with: url)
        
        }
    }

