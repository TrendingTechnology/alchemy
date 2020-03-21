// MARK: - Examples

/// Create:
/// 1. Many to many
/// 2. One to many
/// 3. One to one:
extension User {
    /// Many to many
    func addFriend(user: User) {

    }
}

// MARK: - Implementation

extension _Relation {
    // Alt names: `associated` `related`

    /// Shorthand for if the User doens't want a bunch of relationship properties. Basically an anonymous
    /// relationship for intermediary ones.

    func through<T: Model>(table: JunctionTable<From.Value, To.Value>) -> From.Value.Relation<T> {
        // Filter across the junction table for objects of type T where the id key == `self.id`
        fatalError()
    }

    func through<T: Model>(table: JunctionTable<To.Value, From.Value>) -> From.Value.Relation<T> {
        // Filter across the junction table for objects of type T where the id key == `self.id`
        fatalError()
    }

    func through<T: Model>(theirKey: KeyPath<T, To.Value>) -> From.Value.Relation<T> {
        // Filter across the T table for objects where `id` == `keyPathValue`
        fatalError()
    }

    func through<T: RelationAllowed>(relation: KeyPath<To, _Relation<To, T>>)
        -> From.Value.Relation<T.Value>
    {
        fatalError()
    }
}
