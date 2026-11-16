import SwiftUI
import SpriteKit
import AVFoundation

@main struct MiniGolfApp: App {
    var body: some Scene { WindowGroup { ContentView() } }
}

struct ContentView: View {
    @State private var playing = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.10, green: 0.04, blue: 0.22), Color(red: 0.28, green: 0.08, blue: 0.36)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            if playing {
                VStack(spacing: 12) {
                    HStack { Button("‹ Games") { playing = false }; Spacer(); Text("MINI MINI GOLF").font(.headline); Spacer() }.foregroundStyle(.white)
                    Text("EARLY PLAY TEST").font(.caption.bold()).foregroundStyle(.yellow)
                    SpriteView(scene: GolfScene(size: CGSize(width: 525, height: 350)), options: [.allowsTransparency]).aspectRatio(1.5, contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: 16))
                    Text("Drag back from the ball and release to putt. Physics and obstacles are provisional.").font(.footnote).multilineTextAlignment(.center).foregroundStyle(.white.opacity(0.85))
                    Spacer(minLength: 0)
                }.padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text("MINI GOLF").font(.system(size: 39, weight: .black, design: .rounded)).foregroundStyle(.white)
                        Text("CHOOSE YOUR GAME").font(.subheadline.bold()).tracking(2).foregroundStyle(.yellow)
                        card("Nabisco World", detail: "Classic course · reconstruction in progress", active: false)
                        card("Nabisco / Candystand", detail: "Candy course · reconstruction in progress", active: false)
                        card("Mini Mini Golf", detail: "Desktop course · try the early play test", active: true)
                        Text("Early test build · Original course artwork and sounds are being recovered.").font(.footnote).foregroundStyle(.white.opacity(0.75))
                    }.padding(24).frame(maxWidth: 700, alignment: .leading)
                }
            }
        }
    }
    func card(_ title: String, detail: String, active: Bool) -> some View {
        Button { if active { playing = true } } label: {
            HStack(spacing: 16) {
                Image(systemName: active ? "flag.checkered.circle.fill" : "flag.circle.fill").font(.system(size: 36)).foregroundStyle(active ? .yellow : .white.opacity(0.5))
                VStack(alignment: .leading, spacing: 5) { Text(title).font(.title3.bold()); Text(detail).font(.caption).foregroundStyle(.white.opacity(0.78)) }
                Spacer(); if active { Image(systemName: "chevron.right").fontWeight(.bold) }
            }.foregroundStyle(.white).padding(18).background(.white.opacity(active ? 0.17 : 0.08), in: RoundedRectangle(cornerRadius: 18))
        }.buttonStyle(.plain).disabled(!active)
    }
}

final class GolfScene: SKScene, SKPhysicsContactDelegate {
    private let ball = SKShapeNode(circleOfRadius: 7)
    private var dragStart: CGPoint?
    private var sound: AVAudioPlayer?
    private var sunk = false
    override func didMove(to view: SKView) {
        guard childNode(withName: "background") == nil else { return }
        scaleMode = .aspectFit
        backgroundColor = .clear
        let background = SKSpriteNode(imageNamed: "mini-hole")
        background.name = "background"; background.position = CGPoint(x: size.width/2, y: size.height/2); background.size = size; background.zPosition = -1; addChild(background)
        let cup = SKShapeNode(ellipseOf: CGSize(width: 23, height: 12)); cup.position = CGPoint(x: 376, y: 278); cup.fillColor = .black; cup.strokeColor = .white; cup.zPosition = 1; addChild(cup)
        ball.fillColor = .white; ball.strokeColor = .lightGray; ball.position = CGPoint(x: 219, y: 55); ball.zPosition = 2
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 7); ball.physicsBody?.linearDamping = 1.8; ball.physicsBody?.restitution = 0.6; ball.physicsBody?.friction = 0.3; ball.physicsBody?.allowsRotation = false; addChild(ball)
        physicsWorld.gravity = .zero
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 8, y: 8, width: size.width - 16, height: size.height - 16))
    }
    override func update(_ currentTime: TimeInterval) {
        guard !sunk, let body = ball.physicsBody else { return }
        if hypot(ball.position.x - 376, ball.position.y - 278) < 10 && hypot(body.velocity.dx, body.velocity.dy) < 100 {
            sunk = true; body.velocity = .zero; ball.isHidden = true
            if let url = Bundle.main.url(forResource: "cup", withExtension: "mp3") { sound = try? AVAudioPlayer(contentsOf: url); sound?.play() }
            let message = SKLabelNode(text: "Nice putt! Tap to reset")
            message.name = "message"; message.fontName = "HelveticaNeue-Bold"; message.fontSize = 20; message.position = CGPoint(x: size.width/2, y: 20); message.zPosition = 5; addChild(message)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { if sunk { sunk = false; ball.isHidden = false; ball.position = CGPoint(x: 219, y: 55); childNode(withName: "message")?.removeFromParent(); return }; guard let touch = touches.first, let body = ball.physicsBody, hypot(body.velocity.dx, body.velocity.dy) < 10 else { return }; let p = touch.location(in: self); if hypot(p.x-ball.position.x, p.y-ball.position.y) < 55 { dragStart = p } }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let start = dragStart, let p = touches.first?.location(in: self), let body = ball.physicsBody else { dragStart = nil; return }
        let dx = max(-90, min(90, start.x-p.x)); let dy = max(-90, min(90, start.y-p.y))
        body.applyImpulse(CGVector(dx: dx * 0.012, dy: dy * 0.012)); dragStart = nil
        if let url = Bundle.main.url(forResource: "putt", withExtension: "mp3") { sound = try? AVAudioPlayer(contentsOf: url); sound?.play() }
    }
}
