//
//  PagePadding.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 10/04/2021.
//

import Foundation

@available(iOS 13.0, *)
/// Provides paddings around the page
public struct PagePadding {

    let top: Padding?
    let left: Padding?
    let bottom: Padding?
    let right: Padding?

    public enum Padding {
        /// Creates a padding with an absolute point value.
        case absolute(CGFloat)

        /// Creates a padding that is computed as a fraction of the height of the container view.
        case fractionalHeight(CGFloat)

        /// Creates a padding that is computed as a fraction of the width of the container view.
        case fractionalWidth(CGFloat)
    }
}
