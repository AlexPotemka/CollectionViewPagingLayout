//
//  LayoutDesignerOptionCell.swift
//  PagingLayoutSamples
//
//  Created by Amir on 19/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class LayoutDesignerOptionCell: UITableViewCell, NibBased {
    
    // MARK: Properties
    
    var viewModel: LayoutDesignerOptionCellViewModel? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var singleSlider: UISlider!
    @IBOutlet private weak var singleSliderInput: UITextField!
    @IBOutlet private weak var doubleSliderStackView: UIStackView!
    @IBOutlet private weak var doubleSlider1: UISlider!
    @IBOutlet private weak var doubleSliderInput1: UITextField!
    @IBOutlet private weak var doubleSlider2: UISlider!
    @IBOutlet private weak var doubleSliderInput2: UITextField!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var nilLabel: UILabel!
    @IBOutlet private weak var switchView: UISwitch!
    
    private var onSingleSliderChange: (CGFloat) -> Void = { _ in }
    private var onSingleSliderInputChange: (CGFloat) -> Void = { _ in }
    private var onDoubleSlider1Change: (CGFloat) -> Void = { _ in }
    private var onDoubleSliderInput1Change: (CGFloat) -> Void = { _ in }
    private var onDoubleSlider2Change: (CGFloat) -> Void = { _ in }
    private var onDoubleSliderInput2Change: (CGFloat) -> Void = { _ in }
    private var onSwitchChange: (Bool) -> Void = { _ in }
    private var onSelectedSegmentChange: (Int) -> Void = { _ in }
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        updateViews()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        backgroundColor = .clear
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        nilLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        [singleSlider, doubleSlider1, doubleSlider2].forEach {
            $0?.tintColor = .white
            $0?.thumbTintColor = .white
            $0?.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.3)
            $0?.minimumTrackTintColor = .white
            $0?.addTarget(self, action: #selector(onSliderChange(slider:)), for: .valueChanged)
        }
        [singleSliderInput, doubleSliderInput1, doubleSliderInput2].forEach {
            $0?.backgroundColor = .white
            $0?.textAlignment = .center
            $0?.layer.cornerRadius = 8
            $0?.addTarget(self, action: #selector(onInputChange(input:)), for: .editingChanged)
            $0?.keyboardType = .decimalPad
        }
        switchView.onTintColor = .systemGreen
        switchView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        switchView.layer.cornerRadius = switchView.layer.bounds.height / 2
        switchView.addTarget(self, action: #selector(onSwitchChange(switchView:)), for: .valueChanged)
        
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.3098039216, green: 0.5215686275, blue: 0.8666666667, alpha: 1)], for: .selected)
        segmentedControl.tintColor = .white
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        segmentedControl.addTarget(self, action: #selector(onSelectedSegmentChange(control:)), for: .valueChanged)
    }
    
    @objc private func onSwitchChange(switchView: UISwitch) {
        onSwitchChange(switchView.isOn)
    }
    
    @objc private func onSelectedSegmentChange(control: UISegmentedControl) {
        onSelectedSegmentChange(control.selectedSegmentIndex)
    }
    
    @objc private func onInputChange(input: UITextField) {
        onInputChange(input: input, fromSlider: false)
    }
    
    @objc private func onSliderChange(slider: UISlider) {
        onSliderChange(slider: slider, fromInput: false)
    }
    
    private func onSliderChange(slider: UISlider, fromInput: Bool) {
        let value = CGFloat(slider.value)
        if slider == singleSlider, !(singleSlider.value == Float(value) && fromInput) {
            onSingleSliderChange(value)
            onInputChange(input: singleSliderInput, fromSlider: true)
            singleSliderInput.set(value: value)
        } else if slider == doubleSlider1, !(doubleSlider1.value == Float(value) && fromInput) {
            onDoubleSlider1Change(value)
            onInputChange(input: doubleSliderInput1, fromSlider: true)
            doubleSliderInput1.set(value: value)
        } else if slider == doubleSlider2, !(doubleSlider2.value == Float(value) && fromInput) {
            onDoubleSlider2Change(value)
            onInputChange(input: doubleSliderInput2, fromSlider: true)
            doubleSliderInput2.set(value: value)
        }
    }
    
    private func onInputChange(input: UITextField, fromSlider: Bool) {
        let value = input.floatValue
        if input == singleSliderInput, !(singleSliderInput.floatValue == value && fromSlider) {
            onSingleSliderInputChange(CGFloat(value))
            onSliderChange(slider: singleSlider, fromInput: true)
            singleSlider.value = value
        } else if input == doubleSliderInput1, !(doubleSliderInput1.floatValue == value && fromSlider) {
            onDoubleSliderInput1Change(CGFloat(value))
            onSliderChange(slider: doubleSlider1, fromInput: true)
            doubleSlider1.value = value
        } else if input == doubleSliderInput2, !(doubleSliderInput2.floatValue == value && fromSlider) {
            onDoubleSliderInput2Change(CGFloat(value))
            onSliderChange(slider: doubleSlider2, fromInput: true)
            doubleSlider2.value = value
        }
    }
    
    private func updateViews() {
        guard let viewModel = viewModel, label != nil else { return }
        
        label.text = viewModel.title
        singleSlider.isHidden = true
        singleSliderInput.isHidden = true
        doubleSliderStackView.isHidden = true
        segmentedControl.isHidden = true
        switchView.isHidden = true
        nilLabel.isHidden = true
        
        switch viewModel.kind {
            
        case let .singleSlider(current, range, optional, onChange):
            singleSlider.isHidden = false
            singleSliderInput.isHidden = false
            singleSliderInput.set(value: current ?? 0)
            singleSlider.value = Float(current ?? 0)
            singleSlider.maximumValue = Float(range.upperBound)
            singleSlider.minimumValue = Float(range.lowerBound)
            onSingleSliderChange = onChange
            if optional {
                switchView.isHidden = false
                switchView.isOn = current == nil
                nilLabel.isHidden = false
                onSwitchChange = { [weak self] in
                    guard let self = self else { return }
                    onChange($0 ? nil : CGFloat(self.singleSlider.value))
                    self.singleSlider.isHidden = $0
                    self.singleSliderInput.isHidden = $0
                }
                onSwitchChange(switchView.isOn)
            }
            
        case let .doubleSlider(current, range, optional, onChange):
            doubleSliderStackView.isHidden = false
            doubleSliderStackView.alpha = 1
            doubleSliderInput1.set(value: current?.0 ?? 0)
            doubleSlider1.value = Float(current?.0 ?? 0)
            doubleSliderInput2.set(value: current?.1 ?? 0)
            doubleSlider2.value = Float(current?.1 ?? 0)
            doubleSlider1.maximumValue = Float(range.upperBound)
            doubleSlider2.maximumValue = Float(range.upperBound)
            doubleSlider1.minimumValue = Float(range.lowerBound)
            doubleSlider2.minimumValue = Float(range.lowerBound)
            let getValues = { [weak self] in self.map { (CGFloat($0.doubleSlider1.value), CGFloat($0.doubleSlider2.value)) } }
            
            onDoubleSlider1Change = { _ in onChange(getValues()) }
            onDoubleSlider2Change = { _ in onChange(getValues()) }
            if optional {
                switchView.isHidden = false
                switchView.isOn = current == nil
                nilLabel.isHidden = false
                onSwitchChange = { [weak self] in
                    guard let self = self else { return }
                    onChange($0 ? nil : getValues())
                    self.doubleSliderStackView.alpha = $0 ? 0 : 1
                }
                onSwitchChange(switchView.isOn)
            }
            
            
        case let .toggleSwitch(current, onChange):
            switchView.isHidden = false
            switchView.isOn = current
            onSwitchChange = onChange
            
        case let .segmented(options, current, onChange):
            segmentedControl.isHidden = false
            segmentedControl.removeAllSegments()
            options.reversed().forEach {
                segmentedControl.insertSegment(withTitle: $0, at: 0, animated: false)
            }
            onSelectedSegmentChange = { onChange(options[$0]) }
            if let index = options.firstIndex(of: current) {
                segmentedControl.selectedSegmentIndex = index
            }
        }
    }
    
}


private extension UITextField {
    
    var floatValue: Float {
        text?.floatValue ?? 0
    }
    
    func set(value: Float) {
        set(value: CGFloat(value))
    }
    
    func set(value: CGFloat) {
        text = value.format()
    }
}
