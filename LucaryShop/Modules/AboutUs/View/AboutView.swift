//
//  AboutView.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import UIKit
import MapKit
final class AboutView: UIView {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Haqqımızda – Lucary"
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        label.textColor = UIColor(named: "priceColor")
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .gray
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return textView
    }()
    
    private let playerView: VideoPlayerView = {
        let view = VideoPlayerView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
        let image = UIImage(systemName: "play.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
    }()
    
    private let contactTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 14)
        textView.dataDetectorTypes = [.link, .phoneNumber]
        textView.linkTextAttributes = [
            .foregroundColor: UIColor(named: "blueColor") ?? .blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return textView
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.isScrollEnabled = false
        map.layer.cornerRadius = 12
        return map
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .verifyBg
        
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        
        contentStack.axis = .vertical
        contentStack.spacing = 24
        contentStack.isLayoutMarginsRelativeArrangement = true
        contentStack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 32, right: 16)
        
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        // Add arranged views
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(headerLabel)
        contentStack.addArrangedSubview(textView)
        contentStack.addArrangedSubview(playerView)
        contentStack.addArrangedSubview(contactTextView)
        contentStack.addArrangedSubview(mapView)
        playerView.addSubview(playPauseButton)
    }

    private func setupLayout() {
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { $0.height.equalTo(100) }
        playerView.snp.makeConstraints { $0.height.equalTo(340) }
        mapView.snp.makeConstraints { $0.height.equalTo(240) }
        playPauseButton.snp.makeConstraints { $0.center.equalToSuperview() }
        contactTextView.snp.makeConstraints { $0.height.greaterThanOrEqualTo(100) }
    }
    
    private func setupActions() {
        playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
    }

    // MARK: - Public Methods
    func setText(_ text: String) {
        textView.text = text
    }

    func setImage(named name: String) {
        imageView.image = UIImage(named: name)
    }

    func setVideo(url: URL) {
        playerView.configure(with: url, autoplay: false)
    }

    func setMap(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        mapView.setRegion(
            MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)),
            animated: false
        )
    }

    func setContactInfo(text: String) {
        contactTextView.text = text
    }

    // MARK: - Actions
    
    @objc private func togglePlayPause() {
        if playerView.isPlaying() {
            playerView.pause()
            playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else {
            playerView.play()
            playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
}
