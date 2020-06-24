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
    {
      transform: 'format_possessive',
      arguments: {
        string_to_format: {
          source: 'previous_transform',
        },
      },
    },
  ],
};

{
  personName: {
    placeholder: 'person_name',
    transforms: [{
      transform: 'concatenate_list',
      arguments: {
        list_to_concatenate: {
          source: 'answers',
          identifier: ['first-name', 'last-name'],
        },
        delimiter: ' ',
      },
    }],
  },
  personNamePossessive: {
    placeholder: 'person_name_possessive',
    transforms: [
      {
        transform: 'concatenate_list',
        arguments: {
          list_to_concatenate: {
            source: 'answers',
            identifier: ['first-name', 'last-name'],
          },
          delimiter: ' ',
        },
      },
      {
        transform: 'format_possessive',
        arguments: {
          string_to_format: {
            source: 'previous_transform',
          },
        },
      },
    ],
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
  otherAddress: {
    placeholder: 'other_address',
    transforms: [
      {
        transform: 'concatenate_list',
        arguments: {
          list_to_concatenate: {
            source: 'answers',
            identifier: ['usual-address-answer-building', 'usual-address-answer-street'],
          },
          delimiter: ', ',
        },
      },
    ],
  },
  getListOrdinality: getListOrdinality,
  getListOrdinalityWithoutDeterminer: getListOrdinalityWithoutDeterminer,
  getListCardinality: getListCardinality,
  firstPersonNameForList: firstPersonNameForList,
  firstPersonNamePossessiveForList: firstPersonNamePossessiveForList,
}
