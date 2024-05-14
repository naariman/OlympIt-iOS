//
//  IntialNewsTableViewCell.swift
//  OlympIt
//
//  Created by Nariman on 11.05.2024.
//

import UIKit
import Kingfisher

class InitialNewsTableViewCell: UITableViewCell, ReusableView {
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = ._727274
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor._727274.cgColor
        imageView.clipsToBounds = true
       return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(news: NewsModel) {
        timeLabel.text = news.time
        titleLabel.text = news.title
        accessoryImageView.kf.setImage(with: news.imageUrl)
    }
}

private extension InitialNewsTableViewCell {
    func setupViews() {
        contentView.backgroundColor = ._252527
        contentView.addSubviews(timeLabel, titleLabel, accessoryImageView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(16)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.size.equalTo(64)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
}