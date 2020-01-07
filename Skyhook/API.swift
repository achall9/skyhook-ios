//  This file was automatically generated and should not be edited.

import Apollo

public enum UserRole: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case saAdmin
  case customerAdmin
  case customerUser
  case iaAdmin
  case iaUser
  case fieldAdjuster
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "SA_ADMIN": self = .saAdmin
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
      case .saAdmin: return "SA_ADMIN"
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
      case (.saAdmin, .saAdmin): return true
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
      .saAdmin,
      .customerAdmin,
      .customerUser,
      .iaAdmin,
      .iaUser,
      .fieldAdjuster,
    ]
  }
}

public enum ClaimStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case `open`
  case active
  case closed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "OPEN": self = .open
      case "ACTIVE": self = .active
      case "CLOSED": self = .closed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .open: return "OPEN"
      case .active: return "ACTIVE"
      case .closed: return "CLOSED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ClaimStatus, rhs: ClaimStatus) -> Bool {
    switch (lhs, rhs) {
      case (.open, .open): return true
      case (.active, .active): return true
      case (.closed, .closed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ClaimStatus] {
    return [
      .open,
      .active,
      .closed,
    ]
  }
}

public enum ActivityStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case pending
  case started
  case paused
  case complete
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "PENDING": self = .pending
      case "STARTED": self = .started
      case "PAUSED": self = .paused
      case "COMPLETE": self = .complete
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .pending: return "PENDING"
      case .started: return "STARTED"
      case .paused: return "PAUSED"
      case .complete: return "COMPLETE"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ActivityStatus, rhs: ActivityStatus) -> Bool {
    switch (lhs, rhs) {
      case (.pending, .pending): return true
      case (.started, .started): return true
      case (.paused, .paused): return true
      case (.complete, .complete): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ActivityStatus] {
    return [
      .pending,
      .started,
      .paused,
      .complete,
    ]
  }
}

public enum ActivityType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case onsite
  case travel
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ONSITE": self = .onsite
      case "TRAVEL": self = .travel
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .onsite: return "ONSITE"
      case .travel: return "TRAVEL"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ActivityType, rhs: ActivityType) -> Bool {
    switch (lhs, rhs) {
      case (.onsite, .onsite): return true
      case (.travel, .travel): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ActivityType] {
    return [
      .onsite,
      .travel,
    ]
  }
}

public final class LoginUserMutation: GraphQLMutation {
  /// mutation LoginUser($email: String!, $password: String!, $registrationToken: String!) {
  ///   login(input: {email: $email, password: $password, registrationToken: $registrationToken}) {
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
    "mutation LoginUser($email: String!, $password: String!, $registrationToken: String!) { login(input: {email: $email, password: $password, registrationToken: $registrationToken}) { __typename user { __typename fullName email id roleId jwt } } }"

  public let operationName = "LoginUser"

  public var email: String
  public var password: String
  public var registrationToken: String

  public init(email: String, password: String, registrationToken: String) {
    self.email = email
    self.password = password
    self.registrationToken = registrationToken
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password, "registrationToken": registrationToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["input": ["email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "registrationToken": GraphQLVariable("registrationToken")]], type: .object(Login.selections)),
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
      public static let possibleTypes = ["UserResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .object(User.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserResponse", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
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

        public var fullName: String? {
          get {
            return resultMap["fullName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fullName")
          }
        }

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var roleId: UserRole? {
          get {
            return resultMap["roleId"] as? UserRole
          }
          set {
            resultMap.updateValue(newValue, forKey: "roleId")
          }
        }

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

public final class ClaimsListQuery: GraphQLQuery {
  /// query ClaimsList {
  ///   claims {
  ///     __typename
  ///     edges {
  ///       __typename
  ///       node {
  ///         __typename
  ///         id
  ///         claimNumber
  ///         claimDate
  ///         dueDate
  ///         lossDate
  ///         notes
  ///         uploads {
  ///           __typename
  ///           id
  ///           url
  ///         }
  ///         insured {
  ///           __typename
  ///           name
  ///           phoneM
  ///           phoneB
  ///           email
  ///           address {
  ///             __typename
  ///             street1
  ///             street2
  ///             city
  ///             state
  ///             zip
  ///           }
  ///         }
  ///         claimant {
  ///           __typename
  ///           name
  ///           phone
  ///           address {
  ///             __typename
  ///             street1
  ///             street2
  ///             city
  ///             state
  ///             zip
  ///           }
  ///           legal {
  ///             __typename
  ///             name
  ///             contact
  ///             phone
  ///             address {
  ///               __typename
  ///               street1
  ///               street2
  ///               city
  ///               state
  ///               zip
  ///             }
  ///           }
  ///         }
  ///         customer {
  ///           __typename
  ///           id
  ///           name
  ///           contact
  ///           phone
  ///           email
  ///           address {
  ///             __typename
  ///             street1
  ///             street2
  ///             city
  ///             state
  ///             zip
  ///           }
  ///         }
  ///         ia {
  ///           __typename
  ///           id
  ///           name
  ///           contact
  ///           phone
  ///           email
  ///           address {
  ///             __typename
  ///             street1
  ///             street2
  ///             city
  ///             state
  ///             zip
  ///           }
  ///         }
  ///         status
  ///         activities {
  ///           __typename
  ///           edges {
  ///             __typename
  ///             node {
  ///               __typename
  ///               id
  ///               name
  ///               totalElapsedMillis
  ///               geo
  ///               flags
  ///               notes {
  ///                 __typename
  ///                 note
  ///                 posted
  ///               }
  ///               status
  ///               uploads {
  ///                 __typename
  ///                 uploadId
  ///                 url
  ///               }
  ///             }
  ///           }
  ///         }
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query ClaimsList { claims { __typename edges { __typename node { __typename id claimNumber claimDate dueDate lossDate notes uploads { __typename id url } insured { __typename name phoneM phoneB email address { __typename street1 street2 city state zip } } claimant { __typename name phone address { __typename street1 street2 city state zip } legal { __typename name contact phone address { __typename street1 street2 city state zip } } } customer { __typename id name contact phone email address { __typename street1 street2 city state zip } } ia { __typename id name contact phone email address { __typename street1 street2 city state zip } } status activities { __typename edges { __typename node { __typename id name totalElapsedMillis geo flags notes { __typename note posted } status uploads { __typename uploadId url } } } } } } } }"

  public let operationName = "ClaimsList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("claims", type: .object(Claim.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(claims: Claim? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "claims": claims.flatMap { (value: Claim) -> ResultMap in value.resultMap }])
    }

    public var claims: Claim? {
      get {
        return (resultMap["claims"] as? ResultMap).flatMap { Claim(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "claims")
      }
    }

    public struct Claim: GraphQLSelectionSet {
      public static let possibleTypes = ["ClaimsConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("edges", type: .list(.object(Edge.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(edges: [Edge?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "ClaimsConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var edges: [Edge?]? {
        get {
          return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes = ["ClaimsEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(node: Node? = nil) {
          self.init(unsafeResultMap: ["__typename": "ClaimsEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var node: Node? {
          get {
            return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Claim"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("claimNumber", type: .scalar(String.self)),
            GraphQLField("claimDate", type: .scalar(String.self)),
            GraphQLField("dueDate", type: .scalar(String.self)),
            GraphQLField("lossDate", type: .scalar(String.self)),
            GraphQLField("notes", type: .scalar(String.self)),
            GraphQLField("uploads", type: .list(.nonNull(.object(Upload.selections)))),
            GraphQLField("insured", type: .object(Insured.selections)),
            GraphQLField("claimant", type: .object(Claimant.selections)),
            GraphQLField("customer", type: .object(Customer.selections)),
            GraphQLField("ia", type: .object(Ium.selections)),
            GraphQLField("status", type: .scalar(ClaimStatus.self)),
            GraphQLField("activities", type: .object(Activity.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, claimNumber: String? = nil, claimDate: String? = nil, dueDate: String? = nil, lossDate: String? = nil, notes: String? = nil, uploads: [Upload]? = nil, insured: Insured? = nil, claimant: Claimant? = nil, customer: Customer? = nil, ia: Ium? = nil, status: ClaimStatus? = nil, activities: Activity? = nil) {
            self.init(unsafeResultMap: ["__typename": "Claim", "id": id, "claimNumber": claimNumber, "claimDate": claimDate, "dueDate": dueDate, "lossDate": lossDate, "notes": notes, "uploads": uploads.flatMap { (value: [Upload]) -> [ResultMap] in value.map { (value: Upload) -> ResultMap in value.resultMap } }, "insured": insured.flatMap { (value: Insured) -> ResultMap in value.resultMap }, "claimant": claimant.flatMap { (value: Claimant) -> ResultMap in value.resultMap }, "customer": customer.flatMap { (value: Customer) -> ResultMap in value.resultMap }, "ia": ia.flatMap { (value: Ium) -> ResultMap in value.resultMap }, "status": status, "activities": activities.flatMap { (value: Activity) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var claimNumber: String? {
            get {
              return resultMap["claimNumber"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "claimNumber")
            }
          }

          public var claimDate: String? {
            get {
              return resultMap["claimDate"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "claimDate")
            }
          }

          public var dueDate: String? {
            get {
              return resultMap["dueDate"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "dueDate")
            }
          }

          public var lossDate: String? {
            get {
              return resultMap["lossDate"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lossDate")
            }
          }

          public var notes: String? {
            get {
              return resultMap["notes"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "notes")
            }
          }

          public var uploads: [Upload]? {
            get {
              return (resultMap["uploads"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Upload] in value.map { (value: ResultMap) -> Upload in Upload(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Upload]) -> [ResultMap] in value.map { (value: Upload) -> ResultMap in value.resultMap } }, forKey: "uploads")
            }
          }

          public var insured: Insured? {
            get {
              return (resultMap["insured"] as? ResultMap).flatMap { Insured(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "insured")
            }
          }

          public var claimant: Claimant? {
            get {
              return (resultMap["claimant"] as? ResultMap).flatMap { Claimant(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "claimant")
            }
          }

          public var customer: Customer? {
            get {
              return (resultMap["customer"] as? ResultMap).flatMap { Customer(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "customer")
            }
          }

          public var ia: Ium? {
            get {
              return (resultMap["ia"] as? ResultMap).flatMap { Ium(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "ia")
            }
          }

          public var status: ClaimStatus? {
            get {
              return resultMap["status"] as? ClaimStatus
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }

          public var activities: Activity? {
            get {
              return (resultMap["activities"] as? ResultMap).flatMap { Activity(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "activities")
            }
          }

          public struct Upload: GraphQLSelectionSet {
            public static let possibleTypes = ["ClaimUpload"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("url", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, url: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "ClaimUpload", "id": id, "url": url])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var url: String? {
              get {
                return resultMap["url"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "url")
              }
            }
          }

          public struct Insured: GraphQLSelectionSet {
            public static let possibleTypes = ["Insured"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("phoneM", type: .nonNull(.scalar(String.self))),
              GraphQLField("phoneB", type: .nonNull(.scalar(String.self))),
              GraphQLField("email", type: .nonNull(.scalar(String.self))),
              GraphQLField("address", type: .nonNull(.object(Address.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String, phoneM: String, phoneB: String, email: String, address: Address) {
              self.init(unsafeResultMap: ["__typename": "Insured", "name": name, "phoneM": phoneM, "phoneB": phoneB, "email": email, "address": address.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            public var phoneM: String {
              get {
                return resultMap["phoneM"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "phoneM")
              }
            }

            public var phoneB: String {
              get {
                return resultMap["phoneB"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "phoneB")
              }
            }

            public var email: String {
              get {
                return resultMap["email"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }

            public var address: Address {
              get {
                return Address(unsafeResultMap: resultMap["address"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "address")
              }
            }

            public struct Address: GraphQLSelectionSet {
              public static let possibleTypes = ["Address"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("street1", type: .scalar(String.self)),
                GraphQLField("street2", type: .scalar(String.self)),
                GraphQLField("city", type: .scalar(String.self)),
                GraphQLField("state", type: .scalar(String.self)),
                GraphQLField("zip", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(street1: String? = nil, street2: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Address", "street1": street1, "street2": street2, "city": city, "state": state, "zip": zip])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var street1: String? {
                get {
                  return resultMap["street1"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street1")
                }
              }

              public var street2: String? {
                get {
                  return resultMap["street2"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street2")
                }
              }

              public var city: String? {
                get {
                  return resultMap["city"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "city")
                }
              }

              public var state: String? {
                get {
                  return resultMap["state"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "state")
                }
              }

              public var zip: String? {
                get {
                  return resultMap["zip"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "zip")
                }
              }
            }
          }

          public struct Claimant: GraphQLSelectionSet {
            public static let possibleTypes = ["Claimant"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("phone", type: .nonNull(.scalar(String.self))),
              GraphQLField("address", type: .nonNull(.object(Address.selections))),
              GraphQLField("legal", type: .object(Legal.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String, phone: String, address: Address, legal: Legal? = nil) {
              self.init(unsafeResultMap: ["__typename": "Claimant", "name": name, "phone": phone, "address": address.resultMap, "legal": legal.flatMap { (value: Legal) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            public var phone: String {
              get {
                return resultMap["phone"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "phone")
              }
            }

            public var address: Address {
              get {
                return Address(unsafeResultMap: resultMap["address"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "address")
              }
            }

            public var legal: Legal? {
              get {
                return (resultMap["legal"] as? ResultMap).flatMap { Legal(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "legal")
              }
            }

            public struct Address: GraphQLSelectionSet {
              public static let possibleTypes = ["Address"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("street1", type: .scalar(String.self)),
                GraphQLField("street2", type: .scalar(String.self)),
                GraphQLField("city", type: .scalar(String.self)),
                GraphQLField("state", type: .scalar(String.self)),
                GraphQLField("zip", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(street1: String? = nil, street2: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Address", "street1": street1, "street2": street2, "city": city, "state": state, "zip": zip])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var street1: String? {
                get {
                  return resultMap["street1"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street1")
                }
              }

              public var street2: String? {
                get {
                  return resultMap["street2"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street2")
                }
              }

              public var city: String? {
                get {
                  return resultMap["city"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "city")
                }
              }

              public var state: String? {
                get {
                  return resultMap["state"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "state")
                }
              }

              public var zip: String? {
                get {
                  return resultMap["zip"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "zip")
                }
              }
            }

            public struct Legal: GraphQLSelectionSet {
              public static let possibleTypes = ["ClaimantLegal"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("contact", type: .nonNull(.scalar(String.self))),
                GraphQLField("phone", type: .nonNull(.scalar(String.self))),
                GraphQLField("address", type: .nonNull(.object(Address.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String, contact: String, phone: String, address: Address) {
                self.init(unsafeResultMap: ["__typename": "ClaimantLegal", "name": name, "contact": contact, "phone": phone, "address": address.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              public var contact: String {
                get {
                  return resultMap["contact"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "contact")
                }
              }

              public var phone: String {
                get {
                  return resultMap["phone"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "phone")
                }
              }

              /// email: String!
              public var address: Address {
                get {
                  return Address(unsafeResultMap: resultMap["address"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "address")
                }
              }

              public struct Address: GraphQLSelectionSet {
                public static let possibleTypes = ["Address"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("street1", type: .scalar(String.self)),
                  GraphQLField("street2", type: .scalar(String.self)),
                  GraphQLField("city", type: .scalar(String.self)),
                  GraphQLField("state", type: .scalar(String.self)),
                  GraphQLField("zip", type: .scalar(String.self)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(street1: String? = nil, street2: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Address", "street1": street1, "street2": street2, "city": city, "state": state, "zip": zip])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var street1: String? {
                  get {
                    return resultMap["street1"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "street1")
                  }
                }

                public var street2: String? {
                  get {
                    return resultMap["street2"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "street2")
                  }
                }

                public var city: String? {
                  get {
                    return resultMap["city"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "city")
                  }
                }

                public var state: String? {
                  get {
                    return resultMap["state"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "state")
                  }
                }

                public var zip: String? {
                  get {
                    return resultMap["zip"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "zip")
                  }
                }
              }
            }
          }

          public struct Customer: GraphQLSelectionSet {
            public static let possibleTypes = ["Customer"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("contact", type: .scalar(String.self)),
              GraphQLField("phone", type: .scalar(String.self)),
              GraphQLField("email", type: .scalar(String.self)),
              GraphQLField("address", type: .object(Address.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String? = nil, contact: String? = nil, phone: String? = nil, email: String? = nil, address: Address? = nil) {
              self.init(unsafeResultMap: ["__typename": "Customer", "id": id, "name": name, "contact": contact, "phone": phone, "email": email, "address": address.flatMap { (value: Address) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            public var contact: String? {
              get {
                return resultMap["contact"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "contact")
              }
            }

            public var phone: String? {
              get {
                return resultMap["phone"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "phone")
              }
            }

            public var email: String? {
              get {
                return resultMap["email"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }

            public var address: Address? {
              get {
                return (resultMap["address"] as? ResultMap).flatMap { Address(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "address")
              }
            }

            public struct Address: GraphQLSelectionSet {
              public static let possibleTypes = ["Address"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("street1", type: .scalar(String.self)),
                GraphQLField("street2", type: .scalar(String.self)),
                GraphQLField("city", type: .scalar(String.self)),
                GraphQLField("state", type: .scalar(String.self)),
                GraphQLField("zip", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(street1: String? = nil, street2: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Address", "street1": street1, "street2": street2, "city": city, "state": state, "zip": zip])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var street1: String? {
                get {
                  return resultMap["street1"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street1")
                }
              }

              public var street2: String? {
                get {
                  return resultMap["street2"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street2")
                }
              }

              public var city: String? {
                get {
                  return resultMap["city"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "city")
                }
              }

              public var state: String? {
                get {
                  return resultMap["state"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "state")
                }
              }

              public var zip: String? {
                get {
                  return resultMap["zip"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "zip")
                }
              }
            }
          }

          public struct Ium: GraphQLSelectionSet {
            public static let possibleTypes = ["IndependentAdjuster"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("contact", type: .scalar(String.self)),
              GraphQLField("phone", type: .scalar(String.self)),
              GraphQLField("email", type: .scalar(String.self)),
              GraphQLField("address", type: .object(Address.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String? = nil, contact: String? = nil, phone: String? = nil, email: String? = nil, address: Address? = nil) {
              self.init(unsafeResultMap: ["__typename": "IndependentAdjuster", "id": id, "name": name, "contact": contact, "phone": phone, "email": email, "address": address.flatMap { (value: Address) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            @available(*, deprecated, message: "No longer supported")
            public var contact: String? {
              get {
                return resultMap["contact"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "contact")
              }
            }

            public var phone: String? {
              get {
                return resultMap["phone"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "phone")
              }
            }

            public var email: String? {
              get {
                return resultMap["email"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }

            public var address: Address? {
              get {
                return (resultMap["address"] as? ResultMap).flatMap { Address(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "address")
              }
            }

            public struct Address: GraphQLSelectionSet {
              public static let possibleTypes = ["Address"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("street1", type: .scalar(String.self)),
                GraphQLField("street2", type: .scalar(String.self)),
                GraphQLField("city", type: .scalar(String.self)),
                GraphQLField("state", type: .scalar(String.self)),
                GraphQLField("zip", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(street1: String? = nil, street2: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Address", "street1": street1, "street2": street2, "city": city, "state": state, "zip": zip])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var street1: String? {
                get {
                  return resultMap["street1"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street1")
                }
              }

              public var street2: String? {
                get {
                  return resultMap["street2"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "street2")
                }
              }

              public var city: String? {
                get {
                  return resultMap["city"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "city")
                }
              }

              public var state: String? {
                get {
                  return resultMap["state"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "state")
                }
              }

              public var zip: String? {
                get {
                  return resultMap["zip"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "zip")
                }
              }
            }
          }

          public struct Activity: GraphQLSelectionSet {
            public static let possibleTypes = ["ActivitiesConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("edges", type: .list(.object(Edge.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(edges: [Edge?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "ActivitiesConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var edges: [Edge?]? {
              get {
                return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
              }
            }

            public struct Edge: GraphQLSelectionSet {
              public static let possibleTypes = ["ActivitiesEdge"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("node", type: .object(Node.selections)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(node: Node? = nil) {
                self.init(unsafeResultMap: ["__typename": "ActivitiesEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var node: Node? {
                get {
                  return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "node")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes = ["Activity"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                  GraphQLField("totalElapsedMillis", type: .scalar(Int.self)),
                  GraphQLField("geo", type: .scalar(String.self)),
                  GraphQLField("flags", type: .scalar(String.self)),
                  GraphQLField("notes", type: .list(.nonNull(.object(Note.selections)))),
                  GraphQLField("status", type: .scalar(ActivityStatus.self)),
                  GraphQLField("uploads", type: .list(.nonNull(.object(Upload.selections)))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String? = nil, totalElapsedMillis: Int? = nil, geo: String? = nil, flags: String? = nil, notes: [Note]? = nil, status: ActivityStatus? = nil, uploads: [Upload]? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Activity", "id": id, "name": name, "totalElapsedMillis": totalElapsedMillis, "geo": geo, "flags": flags, "notes": notes.flatMap { (value: [Note]) -> [ResultMap] in value.map { (value: Note) -> ResultMap in value.resultMap } }, "status": status, "uploads": uploads.flatMap { (value: [Upload]) -> [ResultMap] in value.map { (value: Upload) -> ResultMap in value.resultMap } }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: GraphQLID {
                  get {
                    return resultMap["id"]! as! GraphQLID
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var name: String? {
                  get {
                    return resultMap["name"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }

                public var totalElapsedMillis: Int? {
                  get {
                    return resultMap["totalElapsedMillis"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "totalElapsedMillis")
                  }
                }

                @available(*, deprecated, message: "geodata provides parsed data along with additional information")
                public var geo: String? {
                  get {
                    return resultMap["geo"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "geo")
                  }
                }

                public var flags: String? {
                  get {
                    return resultMap["flags"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "flags")
                  }
                }

                public var notes: [Note]? {
                  get {
                    return (resultMap["notes"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Note] in value.map { (value: ResultMap) -> Note in Note(unsafeResultMap: value) } }
                  }
                  set {
                    resultMap.updateValue(newValue.flatMap { (value: [Note]) -> [ResultMap] in value.map { (value: Note) -> ResultMap in value.resultMap } }, forKey: "notes")
                  }
                }

                public var status: ActivityStatus? {
                  get {
                    return resultMap["status"] as? ActivityStatus
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "status")
                  }
                }

                public var uploads: [Upload]? {
                  get {
                    return (resultMap["uploads"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Upload] in value.map { (value: ResultMap) -> Upload in Upload(unsafeResultMap: value) } }
                  }
                  set {
                    resultMap.updateValue(newValue.flatMap { (value: [Upload]) -> [ResultMap] in value.map { (value: Upload) -> ResultMap in value.resultMap } }, forKey: "uploads")
                  }
                }

                public struct Note: GraphQLSelectionSet {
                  public static let possibleTypes = ["ActivityNote"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("note", type: .nonNull(.scalar(String.self))),
                    GraphQLField("posted", type: .nonNull(.scalar(String.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(note: String, posted: String) {
                    self.init(unsafeResultMap: ["__typename": "ActivityNote", "note": note, "posted": posted])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var note: String {
                    get {
                      return resultMap["note"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "note")
                    }
                  }

                  public var posted: String {
                    get {
                      return resultMap["posted"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "posted")
                    }
                  }
                }

                public struct Upload: GraphQLSelectionSet {
                  public static let possibleTypes = ["ActivityUpload"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("uploadId", type: .scalar(String.self)),
                    GraphQLField("url", type: .scalar(String.self)),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(uploadId: String? = nil, url: String? = nil) {
                    self.init(unsafeResultMap: ["__typename": "ActivityUpload", "uploadId": uploadId, "url": url])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var uploadId: String? {
                    get {
                      return resultMap["uploadId"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "uploadId")
                    }
                  }

                  public var url: String? {
                    get {
                      return resultMap["url"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "url")
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class CreateActivityMutation: GraphQLMutation {
  /// mutation CreateActivity($claimId: ID!, $name: String!, $status: ActivityStatus, $type: ActivityType) {
  ///   createActivity(input: {claimId: $claimId, name: $name, status: $status, type: $type}) {
  ///     __typename
  ///     activity {
  ///       __typename
  ///       id
  ///       name
  ///       totalElapsedMillis
  ///       geo
  ///       flags
  ///       notes {
  ///         __typename
  ///         note
  ///         posted
  ///       }
  ///       status
  ///       started
  ///       completed
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation CreateActivity($claimId: ID!, $name: String!, $status: ActivityStatus, $type: ActivityType) { createActivity(input: {claimId: $claimId, name: $name, status: $status, type: $type}) { __typename activity { __typename id name totalElapsedMillis geo flags notes { __typename note posted } status started completed } } }"

  public let operationName = "CreateActivity"

  public var claimId: GraphQLID
  public var name: String
  public var status: ActivityStatus?
  public var type: ActivityType?

  public init(claimId: GraphQLID, name: String, status: ActivityStatus? = nil, type: ActivityType? = nil) {
    self.claimId = claimId
    self.name = name
    self.status = status
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["claimId": claimId, "name": name, "status": status, "type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createActivity", arguments: ["input": ["claimId": GraphQLVariable("claimId"), "name": GraphQLVariable("name"), "status": GraphQLVariable("status"), "type": GraphQLVariable("type")]], type: .object(CreateActivity.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createActivity: CreateActivity? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createActivity": createActivity.flatMap { (value: CreateActivity) -> ResultMap in value.resultMap }])
    }

    public var createActivity: CreateActivity? {
      get {
        return (resultMap["createActivity"] as? ResultMap).flatMap { CreateActivity(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createActivity")
      }
    }

    public struct CreateActivity: GraphQLSelectionSet {
      public static let possibleTypes = ["ActivityResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("activity", type: .object(Activity.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(activity: Activity? = nil) {
        self.init(unsafeResultMap: ["__typename": "ActivityResponse", "activity": activity.flatMap { (value: Activity) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var activity: Activity? {
        get {
          return (resultMap["activity"] as? ResultMap).flatMap { Activity(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "activity")
        }
      }

      public struct Activity: GraphQLSelectionSet {
        public static let possibleTypes = ["Activity"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("totalElapsedMillis", type: .scalar(Int.self)),
          GraphQLField("geo", type: .scalar(String.self)),
          GraphQLField("flags", type: .scalar(String.self)),
          GraphQLField("notes", type: .list(.nonNull(.object(Note.selections)))),
          GraphQLField("status", type: .scalar(ActivityStatus.self)),
          GraphQLField("started", type: .scalar(String.self)),
          GraphQLField("completed", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String? = nil, totalElapsedMillis: Int? = nil, geo: String? = nil, flags: String? = nil, notes: [Note]? = nil, status: ActivityStatus? = nil, started: String? = nil, completed: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Activity", "id": id, "name": name, "totalElapsedMillis": totalElapsedMillis, "geo": geo, "flags": flags, "notes": notes.flatMap { (value: [Note]) -> [ResultMap] in value.map { (value: Note) -> ResultMap in value.resultMap } }, "status": status, "started": started, "completed": completed])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var totalElapsedMillis: Int? {
          get {
            return resultMap["totalElapsedMillis"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalElapsedMillis")
          }
        }

        @available(*, deprecated, message: "geodata provides parsed data along with additional information")
        public var geo: String? {
          get {
            return resultMap["geo"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "geo")
          }
        }

        public var flags: String? {
          get {
            return resultMap["flags"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "flags")
          }
        }

        public var notes: [Note]? {
          get {
            return (resultMap["notes"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Note] in value.map { (value: ResultMap) -> Note in Note(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Note]) -> [ResultMap] in value.map { (value: Note) -> ResultMap in value.resultMap } }, forKey: "notes")
          }
        }

        public var status: ActivityStatus? {
          get {
            return resultMap["status"] as? ActivityStatus
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public var started: String? {
          get {
            return resultMap["started"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "started")
          }
        }

        public var completed: String? {
          get {
            return resultMap["completed"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "completed")
          }
        }

        public struct Note: GraphQLSelectionSet {
          public static let possibleTypes = ["ActivityNote"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("note", type: .nonNull(.scalar(String.self))),
            GraphQLField("posted", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(note: String, posted: String) {
            self.init(unsafeResultMap: ["__typename": "ActivityNote", "note": note, "posted": posted])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var note: String {
            get {
              return resultMap["note"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "note")
            }
          }

          public var posted: String {
            get {
              return resultMap["posted"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "posted")
            }
          }
        }
      }
    }
  }
}

public final class UpdateActivityStartMutation: GraphQLMutation {
  /// mutation UpdateActivityStart($activityId: ID!) {
  ///   updateActivityStart(input: {activityId: $activityId}) {
  ///     __typename
  ///     success
  ///     message
  ///   }
  /// }
  public let operationDefinition =
    "mutation UpdateActivityStart($activityId: ID!) { updateActivityStart(input: {activityId: $activityId}) { __typename success message } }"

  public let operationName = "UpdateActivityStart"

  public var activityId: GraphQLID

  public init(activityId: GraphQLID) {
    self.activityId = activityId
  }

  public var variables: GraphQLMap? {
    return ["activityId": activityId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateActivityStart", arguments: ["input": ["activityId": GraphQLVariable("activityId")]], type: .object(UpdateActivityStart.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateActivityStart: UpdateActivityStart? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateActivityStart": updateActivityStart.flatMap { (value: UpdateActivityStart) -> ResultMap in value.resultMap }])
    }

    public var updateActivityStart: UpdateActivityStart? {
      get {
        return (resultMap["updateActivityStart"] as? ResultMap).flatMap { UpdateActivityStart(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateActivityStart")
      }
    }

    public struct UpdateActivityStart: GraphQLSelectionSet {
      public static let possibleTypes = ["ActivityResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool, message: String) {
        self.init(unsafeResultMap: ["__typename": "ActivityResponse", "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class UpdateActivityEndMutation: GraphQLMutation {
  /// mutation UpdateActivityEnd($activityId: ID!) {
  ///   updateActivityEnd(input: {activityId: $activityId}) {
  ///     __typename
  ///     success
  ///     message
  ///   }
  /// }
  public let operationDefinition =
    "mutation UpdateActivityEnd($activityId: ID!) { updateActivityEnd(input: {activityId: $activityId}) { __typename success message } }"

  public let operationName = "UpdateActivityEnd"

  public var activityId: GraphQLID

  public init(activityId: GraphQLID) {
    self.activityId = activityId
  }

  public var variables: GraphQLMap? {
    return ["activityId": activityId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateActivityEnd", arguments: ["input": ["activityId": GraphQLVariable("activityId")]], type: .object(UpdateActivityEnd.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateActivityEnd: UpdateActivityEnd? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateActivityEnd": updateActivityEnd.flatMap { (value: UpdateActivityEnd) -> ResultMap in value.resultMap }])
    }

    public var updateActivityEnd: UpdateActivityEnd? {
      get {
        return (resultMap["updateActivityEnd"] as? ResultMap).flatMap { UpdateActivityEnd(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateActivityEnd")
      }
    }

    public struct UpdateActivityEnd: GraphQLSelectionSet {
      public static let possibleTypes = ["ActivityResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool, message: String) {
        self.init(unsafeResultMap: ["__typename": "ActivityResponse", "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class UpdateActivityGeoInputMutation: GraphQLMutation {
  /// mutation UpdateActivityGeoInput($activityId: ID!, $path: String!, $flag: String!) {
  ///   updateActivityGeo(input: {activityId: $activityId, path: $path, flag: $flag}) {
  ///     __typename
  ///     success
  ///     message
  ///   }
  /// }
  public let operationDefinition =
    "mutation UpdateActivityGeoInput($activityId: ID!, $path: String!, $flag: String!) { updateActivityGeo(input: {activityId: $activityId, path: $path, flag: $flag}) { __typename success message } }"

  public let operationName = "UpdateActivityGeoInput"

  public var activityId: GraphQLID
  public var path: String
  public var flag: String

  public init(activityId: GraphQLID, path: String, flag: String) {
    self.activityId = activityId
    self.path = path
    self.flag = flag
  }

  public var variables: GraphQLMap? {
    return ["activityId": activityId, "path": path, "flag": flag]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateActivityGeo", arguments: ["input": ["activityId": GraphQLVariable("activityId"), "path": GraphQLVariable("path"), "flag": GraphQLVariable("flag")]], type: .object(UpdateActivityGeo.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateActivityGeo: UpdateActivityGeo? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateActivityGeo": updateActivityGeo.flatMap { (value: UpdateActivityGeo) -> ResultMap in value.resultMap }])
    }

    public var updateActivityGeo: UpdateActivityGeo? {
      get {
        return (resultMap["updateActivityGeo"] as? ResultMap).flatMap { UpdateActivityGeo(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateActivityGeo")
      }
    }

    public struct UpdateActivityGeo: GraphQLSelectionSet {
      public static let possibleTypes = ["ActivityResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool, message: String) {
        self.init(unsafeResultMap: ["__typename": "ActivityResponse", "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class UpdateNotesMutation: GraphQLMutation {
  /// mutation UpdateNotes($activityId: ID!, $note: String!) {
  ///   updateActivityNotes(input: {activityId: $activityId, note: $note}) {
  ///     __typename
  ///     success
  ///     message
  ///   }
  /// }
  public let operationDefinition =
    "mutation UpdateNotes($activityId: ID!, $note: String!) { updateActivityNotes(input: {activityId: $activityId, note: $note}) { __typename success message } }"

  public let operationName = "UpdateNotes"

  public var activityId: GraphQLID
  public var note: String

  public init(activityId: GraphQLID, note: String) {
    self.activityId = activityId
    self.note = note
  }

  public var variables: GraphQLMap? {
    return ["activityId": activityId, "note": note]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateActivityNotes", arguments: ["input": ["activityId": GraphQLVariable("activityId"), "note": GraphQLVariable("note")]], type: .object(UpdateActivityNote.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateActivityNotes: UpdateActivityNote? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateActivityNotes": updateActivityNotes.flatMap { (value: UpdateActivityNote) -> ResultMap in value.resultMap }])
    }

    public var updateActivityNotes: UpdateActivityNote? {
      get {
        return (resultMap["updateActivityNotes"] as? ResultMap).flatMap { UpdateActivityNote(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateActivityNotes")
      }
    }

    public struct UpdateActivityNote: GraphQLSelectionSet {
      public static let possibleTypes = ["ActivityNoteResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool, message: String) {
        self.init(unsafeResultMap: ["__typename": "ActivityNoteResponse", "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class ActivityFileUploadMutation: GraphQLMutation {
  /// mutation ActivityFileUpload($activityId: ID!, $file: Upload!) {
  ///   updateActivityUpload(input: {activityId: $activityId, file: $file}) {
  ///     __typename
  ///     upload {
  ///       __typename
  ///       id
  ///       path
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation ActivityFileUpload($activityId: ID!, $file: Upload!) { updateActivityUpload(input: {activityId: $activityId, file: $file}) { __typename upload { __typename id path } } }"

  public let operationName = "ActivityFileUpload"

  public var activityId: GraphQLID
  public var file: String

  public init(activityId: GraphQLID, file: String) {
    self.activityId = activityId
    self.file = file
  }

  public var variables: GraphQLMap? {
    return ["activityId": activityId, "file": file]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateActivityUpload", arguments: ["input": ["activityId": GraphQLVariable("activityId"), "file": GraphQLVariable("file")]], type: .object(UpdateActivityUpload.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateActivityUpload: UpdateActivityUpload? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateActivityUpload": updateActivityUpload.flatMap { (value: UpdateActivityUpload) -> ResultMap in value.resultMap }])
    }

    public var updateActivityUpload: UpdateActivityUpload? {
      get {
        return (resultMap["updateActivityUpload"] as? ResultMap).flatMap { UpdateActivityUpload(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateActivityUpload")
      }
    }

    public struct UpdateActivityUpload: GraphQLSelectionSet {
      public static let possibleTypes = ["ActivityUploadResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("upload", type: .object(Upload.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(upload: Upload? = nil) {
        self.init(unsafeResultMap: ["__typename": "ActivityUploadResponse", "upload": upload.flatMap { (value: Upload) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var upload: Upload? {
        get {
          return (resultMap["upload"] as? ResultMap).flatMap { Upload(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "upload")
        }
      }

      public struct Upload: GraphQLSelectionSet {
        public static let possibleTypes = ["ActivityUpload"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("path", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, path: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ActivityUpload", "id": id, "path": path])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        @available(*, deprecated, message: "Going away")
        public var path: String? {
          get {
            return resultMap["path"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "path")
          }
        }
      }
    }
  }
}

public final class UpdateClaimEndMutation: GraphQLMutation {
  /// mutation UpdateClaimEnd($claimId: ID!) {
  ///   updateClaimEnd(input: {claimId: $claimId}) {
  ///     __typename
  ///     success
  ///     message
  ///   }
  /// }
  public let operationDefinition =
    "mutation UpdateClaimEnd($claimId: ID!) { updateClaimEnd(input: {claimId: $claimId}) { __typename success message } }"

  public let operationName = "UpdateClaimEnd"

  public var claimId: GraphQLID

  public init(claimId: GraphQLID) {
    self.claimId = claimId
  }

  public var variables: GraphQLMap? {
    return ["claimId": claimId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateClaimEnd", arguments: ["input": ["claimId": GraphQLVariable("claimId")]], type: .object(UpdateClaimEnd.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateClaimEnd: UpdateClaimEnd? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateClaimEnd": updateClaimEnd.flatMap { (value: UpdateClaimEnd) -> ResultMap in value.resultMap }])
    }

    public var updateClaimEnd: UpdateClaimEnd? {
      get {
        return (resultMap["updateClaimEnd"] as? ResultMap).flatMap { UpdateClaimEnd(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateClaimEnd")
      }
    }

    public struct UpdateClaimEnd: GraphQLSelectionSet {
      public static let possibleTypes = ["ClaimResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool, message: String) {
        self.init(unsafeResultMap: ["__typename": "ClaimResponse", "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
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

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var fullName: String? {
    get {
      return resultMap["fullName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "fullName")
    }
  }

  public var email: String? {
    get {
      return resultMap["email"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  public var roleId: UserRole? {
    get {
      return resultMap["roleId"] as? UserRole
    }
    set {
      resultMap.updateValue(newValue, forKey: "roleId")
    }
  }
}
