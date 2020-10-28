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
    transforms.isSameName(source='first_list_item', listName=listName),
    transforms.formatPersonName(source='first_list_item', listName=listName),
    transforms.formatPossessive,
  ],
};

local personName(includeMiddleNames='') = (
  if includeMiddleNames == 'if_is_same_name' then
    {
      placeholder: 'person_name',
      transforms: [transforms.isSameName(), transforms.formatPersonName()],
    }
  else if includeMiddleNames == 'if_same_names_exist' then
    {
      placeholder: 'person_name',
      transforms: [transforms.listHasSameNameItems, transforms.formatPersonName()],
    }
  else
    {
      placeholder: 'person_name',
      transforms: [transforms.concatenateNames],
    }
);

{
  personName: personName,
  personNamePossessive: {
    placeholder: 'person_name_possessive',
    transforms: [transforms.concatenateNames, transforms.formatPossessive],
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
  getListOrdinality: getListOrdinality,
  getListCardinality: getListCardinality,
  firstPersonNameForList: firstPersonNameForList,
  firstPersonNamePossessiveForList: firstPersonNamePossessiveForList,
}
