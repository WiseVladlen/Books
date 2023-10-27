// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserEntityTable extends UserEntity
    with TableInfo<$UserEntityTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isAuthenticatedMeta =
      const VerificationMeta('isAuthenticated');
  @override
  late final GeneratedColumn<bool> isAuthenticated = GeneratedColumn<bool>(
      'is_authenticated', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_authenticated" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, email, name, password, isAuthenticated];
  @override
  String get aliasedName => _alias ?? 'user_entity';
  @override
  String get actualTableName => 'user_entity';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('is_authenticated')) {
      context.handle(
          _isAuthenticatedMeta,
          isAuthenticated.isAcceptableOrUnknown(
              data['is_authenticated']!, _isAuthenticatedMeta));
    } else if (isInserting) {
      context.missing(_isAuthenticatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      isAuthenticated: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_authenticated'])!,
    );
  }

  @override
  $UserEntityTable createAlias(String alias) {
    return $UserEntityTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String email;
  final String name;
  final String password;
  final bool isAuthenticated;
  const User(
      {required this.id,
      required this.email,
      required this.name,
      required this.password,
      required this.isAuthenticated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email'] = Variable<String>(email);
    map['name'] = Variable<String>(name);
    map['password'] = Variable<String>(password);
    map['is_authenticated'] = Variable<bool>(isAuthenticated);
    return map;
  }

  UserEntityCompanion toCompanion(bool nullToAbsent) {
    return UserEntityCompanion(
      id: Value(id),
      email: Value(email),
      name: Value(name),
      password: Value(password),
      isAuthenticated: Value(isAuthenticated),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      password: serializer.fromJson<String>(json['password']),
      isAuthenticated: serializer.fromJson<bool>(json['isAuthenticated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'password': serializer.toJson<String>(password),
      'isAuthenticated': serializer.toJson<bool>(isAuthenticated),
    };
  }

  User copyWith(
          {int? id,
          String? email,
          String? name,
          String? password,
          bool? isAuthenticated}) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('password: $password, ')
          ..write('isAuthenticated: $isAuthenticated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, name, password, isAuthenticated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.name == this.name &&
          other.password == this.password &&
          other.isAuthenticated == this.isAuthenticated);
}

class UserEntityCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> name;
  final Value<String> password;
  final Value<bool> isAuthenticated;
  const UserEntityCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.password = const Value.absent(),
    this.isAuthenticated = const Value.absent(),
  });
  UserEntityCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String name,
    required String password,
    required bool isAuthenticated,
  })  : email = Value(email),
        name = Value(name),
        password = Value(password),
        isAuthenticated = Value(isAuthenticated);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? password,
    Expression<bool>? isAuthenticated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (password != null) 'password': password,
      if (isAuthenticated != null) 'is_authenticated': isAuthenticated,
    });
  }

  UserEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? email,
      Value<String>? name,
      Value<String>? password,
      Value<bool>? isAuthenticated}) {
    return UserEntityCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (isAuthenticated.present) {
      map['is_authenticated'] = Variable<bool>(isAuthenticated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserEntityCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('password: $password, ')
          ..write('isAuthenticated: $isAuthenticated')
          ..write(')'))
        .toString();
  }
}

class $BookEntityTable extends BookEntity
    with TableInfo<$BookEntityTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorsMeta =
      const VerificationMeta('authors');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> authors =
      GeneratedColumn<String>('authors', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($BookEntityTable.$converterauthors);
  static const VerificationMeta _pageCountMeta =
      const VerificationMeta('pageCount');
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
      'page_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _publisherMeta =
      const VerificationMeta('publisher');
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
      'publisher', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _publishedDateMeta =
      const VerificationMeta('publishedDate');
  @override
  late final GeneratedColumn<DateTime> publishedDate =
      GeneratedColumn<DateTime>('published_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _imageLinkMeta =
      const VerificationMeta('imageLink');
  @override
  late final GeneratedColumn<String> imageLink = GeneratedColumn<String>(
      'image_link', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        authors,
        pageCount,
        publisher,
        publishedDate,
        description,
        imageLink,
        language
      ];
  @override
  String get aliasedName => _alias ?? 'book_entity';
  @override
  String get actualTableName => 'book_entity';
  @override
  VerificationContext validateIntegrity(Insertable<Book> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_authorsMeta, const VerificationResult.success());
    if (data.containsKey('page_count')) {
      context.handle(_pageCountMeta,
          pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta));
    }
    if (data.containsKey('publisher')) {
      context.handle(_publisherMeta,
          publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta));
    }
    if (data.containsKey('published_date')) {
      context.handle(
          _publishedDateMeta,
          publishedDate.isAcceptableOrUnknown(
              data['published_date']!, _publishedDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_link')) {
      context.handle(_imageLinkMeta,
          imageLink.isAcceptableOrUnknown(data['image_link']!, _imageLinkMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      authors: $BookEntityTable.$converterauthors.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}authors'])!),
      pageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_count']),
      publisher: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}publisher'])!,
      publishedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}published_date']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imageLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_link'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
    );
  }

  @override
  $BookEntityTable createAlias(String alias) {
    return $BookEntityTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterauthors =
      const ListConverter();
}

class Book extends DataClass implements Insertable<Book> {
  final String id;
  final String title;
  final List<String> authors;
  final int? pageCount;
  final String publisher;
  final DateTime? publishedDate;
  final String description;
  final String imageLink;
  final String language;
  const Book(
      {required this.id,
      required this.title,
      required this.authors,
      this.pageCount,
      required this.publisher,
      this.publishedDate,
      required this.description,
      required this.imageLink,
      required this.language});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      final converter = $BookEntityTable.$converterauthors;
      map['authors'] = Variable<String>(converter.toSql(authors));
    }
    if (!nullToAbsent || pageCount != null) {
      map['page_count'] = Variable<int>(pageCount);
    }
    map['publisher'] = Variable<String>(publisher);
    if (!nullToAbsent || publishedDate != null) {
      map['published_date'] = Variable<DateTime>(publishedDate);
    }
    map['description'] = Variable<String>(description);
    map['image_link'] = Variable<String>(imageLink);
    map['language'] = Variable<String>(language);
    return map;
  }

  BookEntityCompanion toCompanion(bool nullToAbsent) {
    return BookEntityCompanion(
      id: Value(id),
      title: Value(title),
      authors: Value(authors),
      pageCount: pageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(pageCount),
      publisher: Value(publisher),
      publishedDate: publishedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedDate),
      description: Value(description),
      imageLink: Value(imageLink),
      language: Value(language),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      authors: serializer.fromJson<List<String>>(json['authors']),
      pageCount: serializer.fromJson<int?>(json['pageCount']),
      publisher: serializer.fromJson<String>(json['publisher']),
      publishedDate: serializer.fromJson<DateTime?>(json['publishedDate']),
      description: serializer.fromJson<String>(json['description']),
      imageLink: serializer.fromJson<String>(json['imageLink']),
      language: serializer.fromJson<String>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'authors': serializer.toJson<List<String>>(authors),
      'pageCount': serializer.toJson<int?>(pageCount),
      'publisher': serializer.toJson<String>(publisher),
      'publishedDate': serializer.toJson<DateTime?>(publishedDate),
      'description': serializer.toJson<String>(description),
      'imageLink': serializer.toJson<String>(imageLink),
      'language': serializer.toJson<String>(language),
    };
  }

  Book copyWith(
          {String? id,
          String? title,
          List<String>? authors,
          Value<int?> pageCount = const Value.absent(),
          String? publisher,
          Value<DateTime?> publishedDate = const Value.absent(),
          String? description,
          String? imageLink,
          String? language}) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        authors: authors ?? this.authors,
        pageCount: pageCount.present ? pageCount.value : this.pageCount,
        publisher: publisher ?? this.publisher,
        publishedDate:
            publishedDate.present ? publishedDate.value : this.publishedDate,
        description: description ?? this.description,
        imageLink: imageLink ?? this.imageLink,
        language: language ?? this.language,
      );
  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('pageCount: $pageCount, ')
          ..write('publisher: $publisher, ')
          ..write('publishedDate: $publishedDate, ')
          ..write('description: $description, ')
          ..write('imageLink: $imageLink, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, authors, pageCount, publisher,
      publishedDate, description, imageLink, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.title == this.title &&
          other.authors == this.authors &&
          other.pageCount == this.pageCount &&
          other.publisher == this.publisher &&
          other.publishedDate == this.publishedDate &&
          other.description == this.description &&
          other.imageLink == this.imageLink &&
          other.language == this.language);
}

class BookEntityCompanion extends UpdateCompanion<Book> {
  final Value<String> id;
  final Value<String> title;
  final Value<List<String>> authors;
  final Value<int?> pageCount;
  final Value<String> publisher;
  final Value<DateTime?> publishedDate;
  final Value<String> description;
  final Value<String> imageLink;
  final Value<String> language;
  final Value<int> rowid;
  const BookEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.authors = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedDate = const Value.absent(),
    this.description = const Value.absent(),
    this.imageLink = const Value.absent(),
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookEntityCompanion.insert({
    required String id,
    required String title,
    required List<String> authors,
    this.pageCount = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedDate = const Value.absent(),
    this.description = const Value.absent(),
    this.imageLink = const Value.absent(),
    required String language,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        authors = Value(authors),
        language = Value(language);
  static Insertable<Book> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? authors,
    Expression<int>? pageCount,
    Expression<String>? publisher,
    Expression<DateTime>? publishedDate,
    Expression<String>? description,
    Expression<String>? imageLink,
    Expression<String>? language,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (authors != null) 'authors': authors,
      if (pageCount != null) 'page_count': pageCount,
      if (publisher != null) 'publisher': publisher,
      if (publishedDate != null) 'published_date': publishedDate,
      if (description != null) 'description': description,
      if (imageLink != null) 'image_link': imageLink,
      if (language != null) 'language': language,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<List<String>>? authors,
      Value<int?>? pageCount,
      Value<String>? publisher,
      Value<DateTime?>? publishedDate,
      Value<String>? description,
      Value<String>? imageLink,
      Value<String>? language,
      Value<int>? rowid}) {
    return BookEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      pageCount: pageCount ?? this.pageCount,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      description: description ?? this.description,
      imageLink: imageLink ?? this.imageLink,
      language: language ?? this.language,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (authors.present) {
      final converter = $BookEntityTable.$converterauthors;
      map['authors'] = Variable<String>(converter.toSql(authors.value));
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (publishedDate.present) {
      map['published_date'] = Variable<DateTime>(publishedDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageLink.present) {
      map['image_link'] = Variable<String>(imageLink.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('pageCount: $pageCount, ')
          ..write('publisher: $publisher, ')
          ..write('publishedDate: $publishedDate, ')
          ..write('description: $description, ')
          ..write('imageLink: $imageLink, ')
          ..write('language: $language, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $UserEntityTable userEntity = $UserEntityTable(this);
  late final $BookEntityTable bookEntity = $BookEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userEntity, bookEntity];
}
