const String createTableItems = '''
CREATE TABLE clothes.tops (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    warmth_level INTEGER NOT NULL
    CHECK (warmth_level >= 1 and warmth_level <= 5)
);

CREATE TABLE clothes.bottoms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    warmth_level INTEGER NOT NULL
    CHECK (warmth_level >= 1 and warmth_level <= 5),
    bottoms_length VARCHAR(10) 
    CHECK (bottoms_length IN ('short', 'medium', 'long')),
    waterproof BOOLEAN NOT NULL
);

CREATE TABLE clothes.outerwear (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    warmth_level INTEGER NOT NULL,
    waterproof BOOLEAN NOT NULL
);

CREATE TABLE clothes.shoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    waterproof BOOLEAN NOT NULL
);
''';