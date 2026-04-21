// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_preferences_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProfilePreferencesModelCollection on Isar {
  IsarCollection<ProfilePreferencesModel> get profilePreferencesModels =>
      this.collection();
}

const ProfilePreferencesModelSchema = CollectionSchema(
  name: r'ProfilePreferencesModel',
  id: -5776891223489026990,
  properties: {
    r'fearMap': PropertySchema(
      id: 0,
      name: r'fearMap',
      type: IsarType.objectList,
      target: r'FearMapItemEmbedded',
    ),
    r'selectedRhythm': PropertySchema(
      id: 1,
      name: r'selectedRhythm',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 2,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 3,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _profilePreferencesModelEstimateSize,
  serialize: _profilePreferencesModelSerialize,
  deserialize: _profilePreferencesModelDeserialize,
  deserializeProp: _profilePreferencesModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'FearMapItemEmbedded': FearMapItemEmbeddedSchema},
  getId: _profilePreferencesModelGetId,
  getLinks: _profilePreferencesModelGetLinks,
  attach: _profilePreferencesModelAttach,
  version: '3.1.0+1',
);

int _profilePreferencesModelEstimateSize(
  ProfilePreferencesModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fearMap.length * 3;
  {
    final offsets = allOffsets[FearMapItemEmbedded]!;
    for (var i = 0; i < object.fearMap.length; i++) {
      final value = object.fearMap[i];
      bytesCount +=
          FearMapItemEmbeddedSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.selectedRhythm.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _profilePreferencesModelSerialize(
  ProfilePreferencesModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<FearMapItemEmbedded>(
    offsets[0],
    allOffsets,
    FearMapItemEmbeddedSchema.serialize,
    object.fearMap,
  );
  writer.writeString(offsets[1], object.selectedRhythm);
  writer.writeDateTime(offsets[2], object.updatedAt);
  writer.writeString(offsets[3], object.userId);
}

ProfilePreferencesModel _profilePreferencesModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProfilePreferencesModel(
    fearMap: reader.readObjectList<FearMapItemEmbedded>(
          offsets[0],
          FearMapItemEmbeddedSchema.deserialize,
          allOffsets,
          FearMapItemEmbedded(),
        ) ??
        const <FearMapItemEmbedded>[],
    id: id,
    selectedRhythm: reader.readString(offsets[1]),
    updatedAt: reader.readDateTime(offsets[2]),
    userId: reader.readString(offsets[3]),
  );
  return object;
}

P _profilePreferencesModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<FearMapItemEmbedded>(
            offset,
            FearMapItemEmbeddedSchema.deserialize,
            allOffsets,
            FearMapItemEmbedded(),
          ) ??
          const <FearMapItemEmbedded>[]) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _profilePreferencesModelGetId(ProfilePreferencesModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _profilePreferencesModelGetLinks(
    ProfilePreferencesModel object) {
  return [];
}

void _profilePreferencesModelAttach(
    IsarCollection<dynamic> col, Id id, ProfilePreferencesModel object) {
  object.id = id;
}

extension ProfilePreferencesModelByIndex
    on IsarCollection<ProfilePreferencesModel> {
  Future<ProfilePreferencesModel?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  ProfilePreferencesModel? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<ProfilePreferencesModel?>> getAllByUserId(
      List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<ProfilePreferencesModel?> getAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(ProfilePreferencesModel object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(ProfilePreferencesModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<ProfilePreferencesModel> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<ProfilePreferencesModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension ProfilePreferencesModelQueryWhereSort
    on QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QWhere> {
  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProfilePreferencesModelQueryWhere on QueryBuilder<
    ProfilePreferencesModel, ProfilePreferencesModel, QWhereClause> {
  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterWhereClause> userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ProfilePreferencesModelQueryFilter on QueryBuilder<
    ProfilePreferencesModel, ProfilePreferencesModel, QFilterCondition> {
  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> fearMapLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fearMap',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> fearMapIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fearMap',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> fearMapIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fearMap',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> fearMapLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fearMap',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> fearMapLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fearMap',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> fearMapLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fearMap',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedRhythm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedRhythm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedRhythm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedRhythm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selectedRhythm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selectedRhythm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
          QAfterFilterCondition>
      selectedRhythmContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selectedRhythm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
          QAfterFilterCondition>
      selectedRhythmMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selectedRhythm',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedRhythm',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> selectedRhythmIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selectedRhythm',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
          QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
          QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension ProfilePreferencesModelQueryObject on QueryBuilder<
    ProfilePreferencesModel, ProfilePreferencesModel, QFilterCondition> {
  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel,
          QAfterFilterCondition>
      fearMapElement(FilterQuery<FearMapItemEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fearMap');
    });
  }
}

extension ProfilePreferencesModelQueryLinks on QueryBuilder<
    ProfilePreferencesModel, ProfilePreferencesModel, QFilterCondition> {}

extension ProfilePreferencesModelQuerySortBy
    on QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QSortBy> {
  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      sortBySelectedRhythm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedRhythm', Sort.asc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      sortBySelectedRhythmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedRhythm', Sort.desc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ProfilePreferencesModelQuerySortThenBy on QueryBuilder<
    ProfilePreferencesModel, ProfilePreferencesModel, QSortThenBy> {
  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenBySelectedRhythm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedRhythm', Sort.asc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenBySelectedRhythmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedRhythm', Sort.desc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ProfilePreferencesModelQueryWhereDistinct on QueryBuilder<
    ProfilePreferencesModel, ProfilePreferencesModel, QDistinct> {
  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QDistinct>
      distinctBySelectedRhythm({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedRhythm',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ProfilePreferencesModel, ProfilePreferencesModel, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension ProfilePreferencesModelQueryProperty on QueryBuilder<
    ProfilePreferencesModel, ProfilePreferencesModel, QQueryProperty> {
  QueryBuilder<ProfilePreferencesModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProfilePreferencesModel, List<FearMapItemEmbedded>,
      QQueryOperations> fearMapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fearMap');
    });
  }

  QueryBuilder<ProfilePreferencesModel, String, QQueryOperations>
      selectedRhythmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedRhythm');
    });
  }

  QueryBuilder<ProfilePreferencesModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ProfilePreferencesModel, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FearMapItemEmbeddedSchema = Schema(
  name: r'FearMapItemEmbedded',
  id: 5708823546269982860,
  properties: {
    r'intensity': PropertySchema(
      id: 0,
      name: r'intensity',
      type: IsarType.long,
    ),
    r'subtitle': PropertySchema(
      id: 1,
      name: r'subtitle',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 2,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _fearMapItemEmbeddedEstimateSize,
  serialize: _fearMapItemEmbeddedSerialize,
  deserialize: _fearMapItemEmbeddedDeserialize,
  deserializeProp: _fearMapItemEmbeddedDeserializeProp,
);

int _fearMapItemEmbeddedEstimateSize(
  FearMapItemEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.subtitle.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _fearMapItemEmbeddedSerialize(
  FearMapItemEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.intensity);
  writer.writeString(offsets[1], object.subtitle);
  writer.writeString(offsets[2], object.title);
}

FearMapItemEmbedded _fearMapItemEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FearMapItemEmbedded(
    intensity: reader.readLongOrNull(offsets[0]) ?? 1,
    subtitle: reader.readStringOrNull(offsets[1]) ?? '',
    title: reader.readStringOrNull(offsets[2]) ?? '',
  );
  return object;
}

P _fearMapItemEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FearMapItemEmbeddedQueryFilter on QueryBuilder<FearMapItemEmbedded,
    FearMapItemEmbedded, QFilterCondition> {
  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      intensityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intensity',
        value: value,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      intensityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intensity',
        value: value,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      intensityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intensity',
        value: value,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      intensityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intensity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subtitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subtitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitle',
        value: '',
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      subtitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subtitle',
        value: '',
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<FearMapItemEmbedded, FearMapItemEmbedded, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension FearMapItemEmbeddedQueryObject on QueryBuilder<FearMapItemEmbedded,
    FearMapItemEmbedded, QFilterCondition> {}
