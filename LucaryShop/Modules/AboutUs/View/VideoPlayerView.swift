//
//  VideoPlayerView.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import Foundation
import UIKit
import AVFoundation
final class VideoPlayerView: UIView {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    private let playerContainerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addSubview(playerContainerView)
        playerContainerView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(with url: URL, autoplay: Bool = false) {
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        guard let playerLayer = playerLayer else { return }

        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = bounds
        playerContainerView.layer.addSublayer(playerLayer)
        
        if autoplay {
            player?.play()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = playerContainerView.bounds
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
    }

    func isPlaying() -> Bool {
        return player?.timeControlStatus == .playing
    }
}

