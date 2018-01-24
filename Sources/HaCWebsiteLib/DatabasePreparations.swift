import Fluent

enum DatabasePreparations {
  /**
    A list of preparations to run, in order, to bring the database to a state
    that is usable on the current codebase.

    ADD NEW PREPARATIONS TO THE END OF THIS LIST

    Preparation is a migration in Fluent (our ORM). Read more on preparations:
      https://docs.vapor.codes/2.0/fluent/database/#preparations
   */
  static let preparations: [Preparation.Type] = [
    GeneralEvent.InitPreparation.self,
  ]
}
