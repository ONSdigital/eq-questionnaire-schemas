local transforms = import 'transforms.libsonnet';

local getListOrdinality(listName) = {
  placeholder: 'ordinality',
  transforms: [
    {
      transform: 'add',
      arguments: {
        lhs: { source: 'list', identifier: listName },
        rhs: { value: 1 },
      },
    },
    {
      arguments: {
        number_to_format: {
          source: 'previous_transform',
        },
        determiner: {
          value: 'a_or_an',
        },
      },
      transform: 'format_ordinal',
    },
  ],
};

local getListOrdinalityWithoutDeterminer(listName) = {
  placeholder: 'ordinality',
  transforms: [
    {
      transform: 'add',
      arguments: {
        lhs: { source: 'list', identifier: listName },
        rhs: { value: 1 },
      },
    },
    {
      arguments: {
        number_to_format: {
          source: 'previous_transform',
        },
      },
      transform: 'format_ordinal',
    },
  ],
};

local getListCardinality(listName) = {
  placeholder: 'cardinality',
  transforms: [
    {
      transform: 'add',
      arguments: {
        lhs: { source: 'list', identifier: listName },
        rhs: { value: 0 },
      },
    },
  ],
};

local firstPersonNameForList(listName) = {
  placeholder: 'first_person',
  transforms: [
    {
      arguments: {
        delimiter: ' ',
        list_to_concatenate: {
          identifier: ['first-name', 'last-name'],
          source: 'answers',
          list_item_selector: {
            source: 'list',
            id: listName,
            id_selector: 'first',
          },
        },
      },
      transform: 'concatenate_list',
    },
  ],
};

local firstPersonNamePossessiveForList(listName) = {
  placeholder: 'first_person_possessive',
  transforms: [
    {
      arguments: {
        delimiter: ' ',
        list_to_concatenate: {
          identifier: ['first-name', 'last-name'],
          source: 'answers',
          list_item_selector: {
            source: 'list',
            id: listName,
            id_selector: 'first',
          },
        },
      },
      transform: 'concatenate_list',
    },
    transforms.formatPossessive
  ],
};

local personName(sameNameTransform='') = (
  if sameNameTransform == 'contains_same_name_items' then
    {
      placeholder: 'person_name',
      transforms: [transforms.containsSameNameItems, transforms.formatFirstPersonName],
    }
  else if sameNameTransform == 'list_has_same_name_items' then
    {
      placeholder: 'person_name',
      transforms: [transforms.listHasSameNameItems, transforms.formatFirstPersonName],
    }
  else
    {
      placeholder: 'person_name',
      transforms: [transforms.concatenateList],
    }
);

{
  personName: personName,
  personNamePossessive: {
    placeholder: 'person_name_possessive',
    transforms: [transforms.concatenateList, transforms.formatPossessive],
  },
  address: {
    placeholder: 'household_address',
    value: {
      identifier: 'display_address',
      source: 'metadata',
    },
  },
  censusDate: {
    placeholder: 'census_date',
    transforms: [{
      transform: 'format_date',
      arguments: {
        date_to_format: {
          value: std.extVar('census_date'),
        },
        date_format: 'd MMMM yyyy',
      },
    }],
  },
  yearBeforeCensusDate: {
    placeholder: 'year_before_census_date',
    transforms: [{
      transform: 'format_date',
      arguments: {
        date_to_format: {
          value: '2020-03-21',
        },
        date_format: 'd MMMM yyyy',
      },
    }],
  },
  getListOrdinality: getListOrdinality,
  getListOrdinalityWithoutDeterminer: getListOrdinalityWithoutDeterminer,
  getListCardinality: getListCardinality,
  firstPersonNameForList: firstPersonNameForList,
  firstPersonNamePossessiveForList: firstPersonNamePossessiveForList,
}
