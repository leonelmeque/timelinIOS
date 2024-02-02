//
//  TLHomeVCEmptyState.swift
//  timelinapp
//
//  Created by Leonel Meque on 28/1/24.
//

import UIKit

class TLHomeVCEmptyState: UIView {
    
    var textStack: UIStackView!
    var descriptionText = TLTypography(title: "Looks like you don't have any Todos", fontSize: .body, colour: .label, weight: .medium)
    var headingText = TLTypography(title: "Lets Start", fontSize: .title, colour: .label, weight: .bold)
    
    let callToActionButton = TLButton(label: "Add First Todo", variant: .primary, size: .lg)
    
    let container = UIView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with view: UIView) {
        bounds = view.bounds
        backgroundColor = .systemBackground
        textStack = UIStackView(arrangedSubviews: [headingText, descriptionText])
        textStack.axis = .vertical
        
        addSubview(container)
        
        container.addSubview(callToActionButton)
        container.addSubview(textStack)
        
        headingText.textAlignment = .center
        descriptionText.textAlignment = .center
        container.backgroundColor = .systemRed
        setupLayout()
    }
    
    func setupLayout() {
        container.translatesAutoresizingMaskIntoConstraints = false
        textStack.translatesAutoresizingMaskIntoConstraints = false
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -TLSpacing.s16.size),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: TLSpacing.s16.size),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Text Stack Constraints
            textStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            textStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            textStack.topAnchor.constraint(equalTo: container.topAnchor),
            
            // Button Constraints
            callToActionButton.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: TLSpacing.s16.size),
            callToActionButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            callToActionButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])
    }
    
}
