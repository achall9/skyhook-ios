//  This file was automatically generated and should not be edited.

import Apollo

public enum UserRole: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case skyhookAdmin
  case customerAdmin
  case customerUser
  case iaAdmin
  case iaUser
  case fieldAdjuster
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "SKYHOOK_ADMIN": self = .skyhookAdmin
      case "CUSTOMER_ADMIN": self = .customerAdmin
      case "CUSTOMER_USER": self = .customerUser
      case "IA_ADMIN": self = .iaAdmin
      case "IA_USER": self = .iaUser
      case "FIELD_ADJUSTER": self = .fieldAdjuster
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .skyhookAdmin: return "SKYHOOK_ADMIN"
      case .customerAdmin: return "CUSTOMER_ADMIN"
      case .customerUser: return "CUSTOMER_USER"
      case .iaAdmin: return "IA_ADMIN"
      case .iaUser: return "IA_USER"
      case .fieldAdjuster: return "FIELD_ADJUSTER"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: UserRole, rhs: UserRole) -> Bool {
    switch (lhs, rhs) {
      case (.skyhookAdmin, .skyhookAdmin): return true
      case (.customerAdmin, .customerAdmin): return true
      case (.customerUser, .customerUser): return true
      case (.iaAdmin, .iaAdmin): return true
      case (.iaUser, .iaUser): return true
      case (.fieldAdjuster, .fieldAdjuster): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [UserRole] {
    return [
      .skyhookAdmin,
      .customerAdmin,
      .customerUser,
      .iaAdmin,
      .iaUser,
      .fieldAdjuster,
    ]
  }
}

public final class LoginUserMutation: GraphQLMutation {
  /// mutation LoginUser($email: String, $password: String) {
  ///   login(input: {email: $email, password: $password}) {
  ///     __typename
  ///     user {
  ///       __typename
  ///       fullName
  ///       email
  ///       id
  ///       roleId
  ///       jwt
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation LoginUser($email: String, $password: String) { login(input: {email: $email, password: $password}) { __typename user { __typename fullName email id roleId jwt } } }"

  public let operationName = "LoginUser"

  public var email: String?
  public var password: String?

  public init(email: String? = nil, password: String? = nil) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["input": ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")]], type: .object(Login.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["LoginPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .object(User.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "LoginPayload", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("fullName", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("roleId", type: .scalar(UserRole.self)),
          GraphQLField("jwt", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(fullName: String? = nil, email: String? = nil, id: GraphQLID, roleId: UserRole? = nil, jwt: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "fullName": fullName, "email": email, "id": id, "roleId": roleId, "jwt": jwt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// User's full name
        public var fullName: String? {
          get {
            return resultMap["fullName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fullName")
          }
        }

        /// User email address.
        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        /// The user's ID
        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// Text description of the user's role.
        public var roleId: UserRole? {
          get {
            return resultMap["roleId"] as? UserRole
          }
          set {
            resultMap.updateValue(newValue, forKey: "roleId")
          }
        }

        /// JSON Web Token to be used in the Authorization header after a successful login.
        public var jwt: String? {
          get {
            return resultMap["jwt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "jwt")
          }
        }
      }
    }
  }
}

public final class UserDetailsQuery: GraphQLQuery {
  /// query UserDetails {
  ///   users {
  ///     __typename
  ///     ...UserFullDetails
  ///   }
  /// }
  public let operationDefinition =
    "query UserDetails { users { __typename ...UserFullDetails } }"

  public let operationName = "UserDetails"

  public var queryDocument: String { return operationDefinition.appending(UserFullDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", type: .list(.nonNull(.object(User.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "users": users.flatMap { (value: [User]) -> [ResultMap] in value.map { (value: User) -> ResultMap in value.resultMap } }])
    }

    public var users: [User]? {
      get {
        return (resultMap["users"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [User] in value.map { (value: ResultMap) -> User in User(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [User]) -> [ResultMap] in value.map { (value: User) -> ResultMap in value.resultMap } }, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(UserFullDetails.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, fullName: String? = nil, email: String? = nil, roleId: UserRole? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "fullName": fullName, "email": email, "roleId": roleId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var userFullDetails: UserFullDetails {
          get {
            return UserFullDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct UserFullDetails: GraphQLFragment {
  /// fragment UserFullDetails on User {
  ///   __typename
  ///   id
  ///   fullName
  ///   email
  ///   roleId
  /// }
  public static let fragmentDefinition =
    "fragment UserFullDetails on User { __typename id fullName email roleId }"

  public static let possibleTypes = ["User"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("fullName", type: .scalar(String.self)),
    GraphQLField("email", type: .scalar(String.self)),
    GraphQLField("roleId", type: .scalar(UserRole.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, fullName: String? = nil, email: String? = nil, roleId: UserRole? = nil) {
    self.init(unsafeResultMap: ["__typename": "User", "id": id, "fullName": fullName, "email": email, "roleId": roleId])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The user's ID
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// User's full name
  public var fullName: String? {
    get {
      return resultMap["fullName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "fullName")
    }
  }

  /// User email address.
  public var email: String? {
    get {
      return resultMap["email"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  /// Text description of the user's role.
  public var roleId: UserRole? {
    get {
      return resultMap["roleId"] as? UserRole
    }
    set {
      resultMap.updateValue(newValue, forKey: "roleId")
    }
  }
}
