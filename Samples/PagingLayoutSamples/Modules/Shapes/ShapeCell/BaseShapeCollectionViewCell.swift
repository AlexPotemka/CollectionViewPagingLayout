//
//  BaseShapeCollectionViewCell.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class BaseShapeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var viewModel: ShapeCardViewModel? {
        didSet {
            updateViews()
        }
    }
    
    private(set) var shapeCardView: ShapeCardView!
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        shapeCardView = ShapeCardView.instantiate()
        let leftRightMargin = UIScreen.main.bounds.width * 0.18
        let topBottomMargin = UIScreen.main.bounds.height * 0.06
        contentView.fill(with: shapeCardView,
                         edges: UIEdgeInsets(top: topBottomMargin, left: leftRightMargin, bottom: -topBottomMargin, right: -leftRightMargin))
        clipsToBounds = false
        contentView.clipsToBounds = false
    }
    
    private func updateViews() {
        shapeCardView.viewModel = viewModel
    }
    
}
