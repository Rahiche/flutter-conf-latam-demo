import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController

    // Set initial window size to approximate iPhone 16 Pro portrait logical points (≈402 x 874)
    let targetContentSize = NSSize(width: 402, height: 874)

    // Center the window on the main screen with the desired content size
    if let screen = NSScreen.main {
      let screenFrame = screen.visibleFrame
      let contentRect = NSRect(
        x: screenFrame.midX - targetContentSize.width / 2,
        y: screenFrame.midY - targetContentSize.height / 2,
        width: targetContentSize.width,
        height: targetContentSize.height
      )
      let frame = self.frameRect(forContentRect: contentRect)
      self.setFrame(frame, display: true)
    } else {
      // Fallback: set content size directly
      self.setContentSize(targetContentSize)
    }

    // Optionally constrain minimal size to avoid accidental tiny windows
    self.minSize = NSSize(width: 360, height: 720)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
