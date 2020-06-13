class SQLTables {
  static const String friendsTable = '''
CREATE TABLE friends (
    id          INTEGER PRIMARY KEY
                        UNIQUE
                        NOT NULL,
    name        TEXT    NOT NULL,
    email       TEXT    NOT NULL,
    photo_url   TEXT,
    photo_local TEXT
);
    ''';

  static const String subjectTable = '''
CREATE TABLE subject (
    id            INTEGER      PRIMARY KEY
                               UNIQUE,
    user_id       INTEGER      REFERENCES user (id) ON DELETE CASCADE
                               NOT NULL,
    title         TEXT (0, 45) NOT NULL,
    explanation   TEXT,
    pic_url       TEXT,
    pic_local     TEXT,
    start_date    TEXT,
    start_time    TEXT,
    end_date      TEXT,
    end_time      TEXT,
    priority      INTEGER,
    completed     BOOLEAN      DEFAULT (0),
    lat           TEXT,
    lng           TEXT,
    location_name TEXT,
    favorite      BOOLEAN      DEFAULT (0)
);

      ''';

  static const String subjectContributorsTable = '''
CREATE TABLE subject_contributors (
    subject_id INTEGER REFERENCES subject (id) ON DELETE CASCADE
                       NOT NULL,
    friend_id  INTEGER NOT NULL
                       REFERENCES friends (id) ON DELETE CASCADE
);
''';

  static const String subjectTagsTable = '''
CREATE TABLE subject_tags (
    subject_id INTEGER NOT NULL
                       REFERENCES subject (id) ON DELETE CASCADE,
    tag_id     INTEGER REFERENCES tags (id) ON DELETE CASCADE
                       NOT NULL
);
''';

  static const String tagsTable = '''
CREATE TABLE tags (
    id       INTEGER UNIQUE
                     PRIMARY KEY,
    name     TEXT    UNIQUE,
    selected BOOLEAN DEFAULT (1) 
);
''';
  static const String todosTable = '''
CREATE TABLE todos (
    id          INTEGER      PRIMARY KEY
                             NOT NULL,
    subject_id  INTEGER      REFERENCES subject (id) ON DELETE CASCADE
                             NOT NULL,
    title       TEXT (1, 45) NOT NULL,
    explanation TEXT (1),
    completed   BOOLEAN      DEFAULT (0) 
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

  static const String triggerRemoveUnusedTags = '''
CREATE TRIGGER removeUnusedTags
         AFTER DELETE
            ON subject_tags
BEGIN
    DELETE FROM tags
          WHERE id NOT IN (
        SELECT f.tag_id
          FROM subject_tags f
    );
END;
''';
  static const String pragmaForeingKey = '''PRAGMA foreign_keys = on;''';
}
