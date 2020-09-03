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
local suggestionsUrl(listName) = {
  placeholder: 'suggestions_url',
  transforms: [
    {
      transform: 'format_nisra_suggestions_url',
      arguments: {
        url: {
          value: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v4.0.0/ni/en/',
        },
        list_json: {
          value: listName,
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
  firstPersonPlaceholder: {
    placeholder: 'first_person_name',
    transforms: [{
      transform: 'concatenate_list',
      arguments: {
        list_to_concatenate: {
          source: 'answers',
          identifier: ['first-name', 'last-name'],
          list_item_selector: {
            source: 'location',
            id: 'list_item_id',
          },
        },
        delimiter: ' ',
      },
    }],
  },
  secondPersonPlaceholder: {
    placeholder: 'second_person_name',
    transforms: [{
      transform: 'concatenate_list',
      arguments: {
        list_to_concatenate: {
          source: 'answers',
          identifier: ['first-name', 'last-name'],
          list_item_selector: {
            source: 'location',
            id: 'to_list_item_id',
          },
        },
        delimiter: ' ',
      },
    }],
  },
  firstPersonNamePossessivePlaceholder: {
    placeholder: 'first_person_name_possessive',
    transforms: [
      {
        transform: 'concatenate_list',
        arguments: {
          list_to_concatenate: {
            source: 'answers',
            identifier: ['first-name', 'last-name'],
            list_item_selector: {
              source: 'location',
              id: 'list_item_id',
            },
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
  suggestionsUrl: suggestionsUrl,
  getListOrdinality: getListOrdinality,
  getListCardinality: getListCardinality,
  firstPersonNameForList: firstPersonNameForList,
  firstPersonNamePossessiveForList: firstPersonNamePossessiveForList,
}
