import Foundation

/// This would never be exposed in production, and I would prefer to manage Secrets via a secret manager.
/// Given this is part of an interview process, I'll expose this for a few days before cycling the token.
final class Secrets {
    static let accessTokenAuthTMBD = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMDJkOWRiOTJhNmJiNThhNzYxZmFjZTRiYTJmY2MyNiIsInN1YiI6IjY1Yjc1YTZkZDU1YzNkMDE3Y2ZhYmU5MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wX3UaNKliYImjzXdC_h2LYRgdzOHSREfsirQ7rH0mdI"
}

