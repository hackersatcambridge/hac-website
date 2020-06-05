struct Location {
    var latitude : Double 
    var longitude : Double
    var address : String?
    var venue : String?

    init(latitude: Double, longitude: Double, address: String? = nil, venue: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.venue = venue
    }
}