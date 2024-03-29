import SWXMLHash

/// rte represents route - an ordered list of waypoints representing a series of turn points leading to a destination.
public struct Route {
    
    /// GPS name of route.
    public var name: String?
    
    /// GPS comment for route.
    public var comment: String?
    
    /// Text description of route for user.  Not sent to GPS.
    public var desc: String?
    
    /// Source of data. Included to give user some idea of reliability and accuracy of data.
    public var source: String?
    
    /// Links to external information about the route.
    public var links: [Link] = []
    
    /// GPS route number.
    public var number: Int?
    
    /// Type (classification) of route.
    public var type: String?
    
    /// A list of route points.
    public var points: [Waypoint]
}

extension Route: XMLIndexerDeserializable {
    public static func deserialize(_ node: XMLIndexer) throws -> Route {
        Route(
            name: try? node["name"].value(),
            comment: try? node["cmt"].value(),
            desc: try? node["desc"].value(),
            source: try? node["src"].value(),
            links: try node["lik"].all.map(Link.deserialize),
            number: try? node["number"].value(),
            type: try? node["type"].value(),
            points: try node["rtept"].all.map(Waypoint.deserialize)
        )
    }
}

extension Route: Equatable, Hashable, Codable { }
