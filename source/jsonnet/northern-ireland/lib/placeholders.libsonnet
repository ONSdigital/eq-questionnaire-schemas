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
  transforms: [transforms.containsSameNameItems, transforms.formatFirstPersonName],
};

local firstPersonNamePossessiveForList(listName) = {
  placeholder: 'first_person_possessive',
  transforms: [
    transforms.containsSameNameItems,
    transforms.formatFirstPersonName,
    transforms.formatPossessive,
  ],
};

local personName(sameNameTransform='') = (
  local transforms = if sameNameTransform == '' then [transforms.concatenateList] else [sameNameTransform, transforms.formatFirstPersonName];
  {
    placeholder: 'person_name',
    transforms: transforms,
  }
);

{
  personName: personName,
  personNamePossessive: {
    placeholder: 'person_name_possessive',
    transforms: [
      transforms.containsSameNameItems,
      transforms.formatFirstPersonName,
      transforms.formatPossessive,
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
  getListOrdinality: getListOrdinality,
  getListCardinality: getListCardinality,
  firstPersonNameForList: firstPersonNameForList,
  firstPersonNamePossessiveForList: firstPersonNamePossessiveForList,
}
