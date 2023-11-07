// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserEntityTable extends UserEntity
    with TableInfo<$UserEntityTable, UserEntityData> {
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
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
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
  VerificationContext validateIntegrity(Insertable<UserEntityData> instance,
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {id, email},
      ];
  @override
  UserEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserEntityData(
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

class UserEntityData extends DataClass implements Insertable<UserEntityData> {
  final int id;
  final String email;
  final String name;
  final String password;
  final bool isAuthenticated;
  const UserEntityData(
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

  factory UserEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserEntityData(
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

  UserEntityData copyWith(
          {int? id,
          String? email,
          String? name,
          String? password,
          bool? isAuthenticated}) =>
      UserEntityData(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      );
  @override
  String toString() {
    return (StringBuffer('UserEntityData(')
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
      (other is UserEntityData &&
          other.id == this.id &&
          other.email == this.email &&
          other.name == this.name &&
          other.password == this.password &&
          other.isAuthenticated == this.isAuthenticated);
}

class UserEntityCompanion extends UpdateCompanion<UserEntityData> {
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
  static Insertable<UserEntityData> custom({
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

class $AuthorEntityTable extends AuthorEntity
    with TableInfo<$AuthorEntityTable, AuthorEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthorEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'author_entity';
  @override
  String get actualTableName => 'author_entity';
  @override
  VerificationContext validateIntegrity(Insertable<AuthorEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuthorEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthorEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AuthorEntityTable createAlias(String alias) {
    return $AuthorEntityTable(attachedDatabase, alias);
  }
}

class AuthorEntityData extends DataClass
    implements Insertable<AuthorEntityData> {
  final int id;
  final String name;
  const AuthorEntityData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AuthorEntityCompanion toCompanion(bool nullToAbsent) {
    return AuthorEntityCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory AuthorEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthorEntityData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  AuthorEntityData copyWith({int? id, String? name}) => AuthorEntityData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('AuthorEntityData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthorEntityData &&
          other.id == this.id &&
          other.name == this.name);
}

class AuthorEntityCompanion extends UpdateCompanion<AuthorEntityData> {
  final Value<int> id;
  final Value<String> name;
  const AuthorEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  AuthorEntityCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<AuthorEntityData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  AuthorEntityCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return AuthorEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthorEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $BookEntityTable extends BookEntity
    with TableInfo<$BookEntityTable, BookEntityData> {
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
  VerificationContext validateIntegrity(Insertable<BookEntityData> instance,
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
  BookEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
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
}

class BookEntityData extends DataClass implements Insertable<BookEntityData> {
  final String id;
  final String title;
  final int? pageCount;
  final String publisher;
  final DateTime? publishedDate;
  final String description;
  final String imageLink;
  final String language;
  const BookEntityData(
      {required this.id,
      required this.title,
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

  factory BookEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
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
      'pageCount': serializer.toJson<int?>(pageCount),
      'publisher': serializer.toJson<String>(publisher),
      'publishedDate': serializer.toJson<DateTime?>(publishedDate),
      'description': serializer.toJson<String>(description),
      'imageLink': serializer.toJson<String>(imageLink),
      'language': serializer.toJson<String>(language),
    };
  }

  BookEntityData copyWith(
          {String? id,
          String? title,
          Value<int?> pageCount = const Value.absent(),
          String? publisher,
          Value<DateTime?> publishedDate = const Value.absent(),
          String? description,
          String? imageLink,
          String? language}) =>
      BookEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
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
    return (StringBuffer('BookEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
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
  int get hashCode => Object.hash(id, title, pageCount, publisher,
      publishedDate, description, imageLink, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.pageCount == this.pageCount &&
          other.publisher == this.publisher &&
          other.publishedDate == this.publishedDate &&
          other.description == this.description &&
          other.imageLink == this.imageLink &&
          other.language == this.language);
}

class BookEntityCompanion extends UpdateCompanion<BookEntityData> {
  final Value<String> id;
  final Value<String> title;
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
    this.pageCount = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedDate = const Value.absent(),
    this.description = const Value.absent(),
    this.imageLink = const Value.absent(),
    required String language,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        language = Value(language);
  static Insertable<BookEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
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

class $BookAuthorEntityTable extends BookAuthorEntity
    with TableInfo<$BookAuthorEntityTable, BookAuthorEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookAuthorEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<int> authorId = GeneratedColumn<int>(
      'author_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES author_entity (id)'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES book_entity (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, authorId, bookId];
  @override
  String get aliasedName => _alias ?? 'book_author_entity';
  @override
  String get actualTableName => 'book_author_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<BookAuthorEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {authorId, bookId},
      ];
  @override
  BookAuthorEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookAuthorEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}author_id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
    );
  }

  @override
  $BookAuthorEntityTable createAlias(String alias) {
    return $BookAuthorEntityTable(attachedDatabase, alias);
  }
}

class BookAuthorEntityData extends DataClass
    implements Insertable<BookAuthorEntityData> {
  final int id;
  final int authorId;
  final String bookId;
  const BookAuthorEntityData(
      {required this.id, required this.authorId, required this.bookId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['author_id'] = Variable<int>(authorId);
    map['book_id'] = Variable<String>(bookId);
    return map;
  }

  BookAuthorEntityCompanion toCompanion(bool nullToAbsent) {
    return BookAuthorEntityCompanion(
      id: Value(id),
      authorId: Value(authorId),
      bookId: Value(bookId),
    );
  }

  factory BookAuthorEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookAuthorEntityData(
      id: serializer.fromJson<int>(json['id']),
      authorId: serializer.fromJson<int>(json['authorId']),
      bookId: serializer.fromJson<String>(json['bookId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'authorId': serializer.toJson<int>(authorId),
      'bookId': serializer.toJson<String>(bookId),
    };
  }

  BookAuthorEntityData copyWith({int? id, int? authorId, String? bookId}) =>
      BookAuthorEntityData(
        id: id ?? this.id,
        authorId: authorId ?? this.authorId,
        bookId: bookId ?? this.bookId,
      );
  @override
  String toString() {
    return (StringBuffer('BookAuthorEntityData(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('bookId: $bookId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, authorId, bookId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookAuthorEntityData &&
          other.id == this.id &&
          other.authorId == this.authorId &&
          other.bookId == this.bookId);
}

class BookAuthorEntityCompanion extends UpdateCompanion<BookAuthorEntityData> {
  final Value<int> id;
  final Value<int> authorId;
  final Value<String> bookId;
  const BookAuthorEntityCompanion({
    this.id = const Value.absent(),
    this.authorId = const Value.absent(),
    this.bookId = const Value.absent(),
  });
  BookAuthorEntityCompanion.insert({
    this.id = const Value.absent(),
    required int authorId,
    required String bookId,
  })  : authorId = Value(authorId),
        bookId = Value(bookId);
  static Insertable<BookAuthorEntityData> custom({
    Expression<int>? id,
    Expression<int>? authorId,
    Expression<String>? bookId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authorId != null) 'author_id': authorId,
      if (bookId != null) 'book_id': bookId,
    });
  }

  BookAuthorEntityCompanion copyWith(
      {Value<int>? id, Value<int>? authorId, Value<String>? bookId}) {
    return BookAuthorEntityCompanion(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      bookId: bookId ?? this.bookId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<int>(authorId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookAuthorEntityCompanion(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('bookId: $bookId')
          ..write(')'))
        .toString();
  }
}

class $UserBookEntityTable extends UserBookEntity
    with TableInfo<$UserBookEntityTable, UserBookEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserBookEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user_entity (id)'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES book_entity (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, userId, bookId];
  @override
  String get aliasedName => _alias ?? 'user_book_entity';
  @override
  String get actualTableName => 'user_book_entity';
  @override
  VerificationContext validateIntegrity(Insertable<UserBookEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {userId, bookId},
      ];
  @override
  UserBookEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserBookEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
    );
  }

  @override
  $UserBookEntityTable createAlias(String alias) {
    return $UserBookEntityTable(attachedDatabase, alias);
  }
}

class UserBookEntityData extends DataClass
    implements Insertable<UserBookEntityData> {
  final int id;
  final int userId;
  final String bookId;
  const UserBookEntityData(
      {required this.id, required this.userId, required this.bookId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['book_id'] = Variable<String>(bookId);
    return map;
  }

  UserBookEntityCompanion toCompanion(bool nullToAbsent) {
    return UserBookEntityCompanion(
      id: Value(id),
      userId: Value(userId),
      bookId: Value(bookId),
    );
  }

  factory UserBookEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserBookEntityData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      bookId: serializer.fromJson<String>(json['bookId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'bookId': serializer.toJson<String>(bookId),
    };
  }

  UserBookEntityData copyWith({int? id, int? userId, String? bookId}) =>
      UserBookEntityData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        bookId: bookId ?? this.bookId,
      );
  @override
  String toString() {
    return (StringBuffer('UserBookEntityData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('bookId: $bookId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, bookId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserBookEntityData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.bookId == this.bookId);
}

class UserBookEntityCompanion extends UpdateCompanion<UserBookEntityData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> bookId;
  const UserBookEntityCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.bookId = const Value.absent(),
  });
  UserBookEntityCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String bookId,
  })  : userId = Value(userId),
        bookId = Value(bookId);
  static Insertable<UserBookEntityData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? bookId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (bookId != null) 'book_id': bookId,
    });
  }

  UserBookEntityCompanion copyWith(
      {Value<int>? id, Value<int>? userId, Value<String>? bookId}) {
    return UserBookEntityCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserBookEntityCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('bookId: $bookId')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $UserEntityTable userEntity = $UserEntityTable(this);
  late final $AuthorEntityTable authorEntity = $AuthorEntityTable(this);
  late final $BookEntityTable bookEntity = $BookEntityTable(this);
  late final $BookAuthorEntityTable bookAuthorEntity =
      $BookAuthorEntityTable(this);
  late final $UserBookEntityTable userBookEntity = $UserBookEntityTable(this);
  late final AuthorDao authorDao = AuthorDao(this as Database);
  late final BookAuthorDao bookAuthorDao = BookAuthorDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userEntity, authorEntity, bookEntity, bookAuthorEntity, userBookEntity];
}
