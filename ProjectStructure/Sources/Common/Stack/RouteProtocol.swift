import Foundation

/// The RouteProtocol is used to restrict the extensions on Array so that they do not
/// pollute autocomplete for Arrays containing other types.
public protocol RouteProtocol {
    
    /// The associated type representing the screen or destination in the navigation system.
    associatedtype Screen
    
    /// Creates a new route instance that pushes a screen onto the navigation stack.
    static func push(_ screen: Screen) -> Self
    
    /// Creates a new route instance that presents a screen as a modal sheet.
    static func sheet(_ screen: Screen, withNavigation: Bool) -> Self
#if os(macOS)
    // Full-screen cover unavailable.
#else
    /// Creates a new route instance that presents a screen as a full-screen cover.
    static func cover(_ screen: Screen, withNavigation: Bool) -> Self
#endif
    /// The screen associated with this route.
    var screen: Screen { get set }
    
    /// A Boolean indicating whether the screen should be presented inside a navigation view.
    var withNavigation: Bool { get }
    
    /// A Boolean indicating whether the screen is currently presented.
    var isPresented: Bool { get }
    
    /// The style of the route, which determines how the screen is displayed.
    var style: RouteStyle { get }
}

public extension RouteProtocol {
    /// A sheet presentation.
    /// - Parameter screen: the screen to be shown.
    static func sheet(_ screen: Screen) -> Self {
        sheet(screen, withNavigation: false)
    }
    
#if os(macOS)
    // Full-screen cover unavailable.
#else
    /// A full-screen cover presentation.
    /// - Parameter screen: the screen to be shown.
    @available(OSX, unavailable, message: "Not available on OS X.")
    static func cover(_ screen: Screen) -> Self {
        cover(screen, withNavigation: false)
    }
#endif
    
    /// The root of the stack. The presentation style is irrelevant as it will not be presented.
    /// - Parameter screen: the screen to be shown.
    static func root(_ screen: Screen, withNavigation: Bool = false) -> Self {
        sheet(screen, withNavigation: withNavigation)
    }
}

extension Route: RouteProtocol {}
