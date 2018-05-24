//
//  PeriodStackView.swift
//  ParkingSign
//
//  Created by Ky Pichratanak on 22/5/18.
//  Copyright © 2018 Ky Pichratanak. All rights reserved.
//

import UIKit

public class PeriodStackView: UIStackView {

    var fromDay = DateComponents() {
        didSet {
            self.fromHourStackView.dateComponents = fromDay
            self.updateUI()
        }
    }
    var toDay = DateComponents() {
        didSet {
            self.toHourStackView.dateComponents = toDay
            self.updateUI()
        }
    }
    
    fileprivate var fromHourStackView: HourStackView!
    fileprivate var toHourStackView: HourStackView!
    fileprivate var dateLabel = SignLabel(frame: .zero)
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.createUI()
        self.updateUI()
    }
    
    init(fromDay from: DateComponents, to: DateComponents) {
        super.init(frame: CGRect.zero)
        
        self.fromDay = from
        self.toDay = to
        
        self.createUI()
        self.updateUI()
    }
    
    fileprivate func createUI() {
        self.fromHourStackView = HourStackView(dateComponents: self.fromDay)
        self.toHourStackView = HourStackView(dateComponents: self.toDay)
        
        let periodStackView = UIStackView(frame: CGRect.zero)
        periodStackView.addArrangedSubview(self.fromHourStackView)
        periodStackView.addArrangedSubview(self.toHourStackView)
        periodStackView.axis = .horizontal
        periodStackView.alignment = .center
        periodStackView.distribution = .fillProportionally
        periodStackView.spacing = 10.0
        periodStackView.contentMode = .scaleToFill
        periodStackView.backgroundColor = .clear
        
        self.addArrangedSubview(periodStackView)
        self.addArrangedSubview(self.dateLabel)
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillProportionally
        self.spacing = -3.0
        self.contentMode = .scaleToFill
        self.backgroundColor = .clear
    }
    
    fileprivate func updateUI() {
        if let fromWeekDay = self.fromDay.weekday, let toWeekDay = self.toDay.weekday {
            self.dateLabel.text = "\(fromWeekDay.dayOfWeek.rawValue) - \(toWeekDay.dayOfWeek.rawValue)"
        }
        else {
            self.dateLabel.text = "-"
        }
    }
}