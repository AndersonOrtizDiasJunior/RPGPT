protocol LocalStorageProtocol {
    func get<T>(from key: LocalStorageKeys, type: T.Type) -> T?
    func get<T: Decodable>(from key: LocalStorageKeys, type: T.Type) -> T?
    func set(for key: LocalStorageKeys, value: Any)
    func set<T: Encodable>(for key: LocalStorageKeys, value: T)
}
