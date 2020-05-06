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
  ordinal: {
    placeholder: 'ordinal',
    transforms: [
      {
        transform: 'add',
        arguments: {
          lhs: { source: 'list', identifier: 'household' },
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
  },
  ordinalVisitor: {
    placeholder: 'ordinal_visitor',
    transforms: [
      {
        transform: 'add',
        arguments: {
          lhs: { source: 'list', identifier: 'visitors' },
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
  },
  cardinal: {
    placeholder: 'cardinal',
    transforms: [
      {
        transform: 'add',
        arguments: {
          lhs: { source: 'list', identifier: 'household' },
          rhs: { value: 0 },
        },
      },
    ],
  },
}
