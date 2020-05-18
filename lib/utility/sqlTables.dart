class SQLTables {
  static const String subjectTable = '''
CREATE TABLE subject (
    id          INTEGER      PRIMARY KEY AUTOINCREMENT
                             UNIQUE,
    user_id     INTEGER      REFERENCES user (id) ON DELETE CASCADE
                             NOT NULL,
    title       TEXT (0, 45) NOT NULL,
    explanation TEXT,
    pic_url     TEXT,
    pic_local   TEXT,
    start_date  TEXT,
    start_time  TEXT,
    end_date    TEXT,
    priority    INTEGER,
    completed   BOOLEAN      DEFAULT (0) 
);
      ''';

  static const String subjectTodoTable = '''
CREATE TABLE subject_todos (
    subject_id INTEGER NOT NULL
                       REFERENCES subject (id),
    todo_id    INTEGER NOT NULL
                       REFERENCES todos (id) 
);
''';

  static const String todosTable = '''
CREATE TABLE todos (
    id       INTEGER PRIMARY KEY AUTOINCREMENT
                     UNIQUE,
    name     TEXT    UNIQUE,
    selected BOOLEAN DEFAULT (1) 
);
''';

  static const String userTable = '''
CREATE TABLE user (
    id          INTEGER PRIMARY KEY
                        NOT NULL,
    name        TEXT    NOT NULL,
    email       TEXT    NOT NULL,
    photo_url   TEXT,
    photo_local TEXT
);
''';

  static const String friendsTable = '''
  CREATE TABLE friends (
    users_friend_id INTEGER REFERENCES user (id),
    name            TEXT    NOT NULL,
    email           TEXT    NOT NULL,
    photo_url       TEXT,
    photo_local     TEXT
);
    ''';
}
