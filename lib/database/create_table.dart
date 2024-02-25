const String createTableItems = '''
CREATE TABLE clothes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    warmth_level INTEGER NOT NULL
    CHECK (warmth_level >= 1 and warmth_level <= 5),
    type VARCHAR(255) NOT NULL
    CHECK (type IN ('Tops', 'Bottoms', 'Outerwear', 'Shoes'))
);

CREATE TABLE bottoms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    warmth_level INTEGER NOT NULL
    CHECK (warmth_level >= 1 and warmth_level <= 5),
    bottoms_length VARCHAR(10) 
    CHECK (bottoms_length IN ('short', 'medium', 'long')),
    waterproof BOOLEAN NOT NULL
);

CREATE TABLE outerwear (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    warmth_level INTEGER NOT NULL,
    waterproof BOOLEAN NOT NULL
);

CREATE TABLE shoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    waterproof BOOLEAN NOT NULL
);
''';