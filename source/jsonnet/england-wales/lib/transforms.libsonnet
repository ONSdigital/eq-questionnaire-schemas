local firstNameFirstListItem(listName) = {
  source: 'answers',
  identifier: 'first-name',
  list_item_selector: {
    id: listName,
    id_selector: 'first',
    source: 'list',
  },
};

local middleNamesFirstListItem(listName) = {
  source: 'answers',
  identifier: 'middle-names',
  list_item_selector: {
    id: listName,
    id_selector: 'first',
    source: 'list',
  },
};

local lastNameFirstListItem(listName) = {
  source: 'answers',
  identifier: 'last-name',
  list_item_selector: {
    id: listName,
    id_selector: 'first',
    source: 'list',
  },
};

local firstNameCurrentListItem = {
  source: 'answers',
  identifier: 'first-name',
};

local middleNamesCurrentListItem = {
  source: 'answers',
  identifier: 'middle-names',
};

local lastNameCurrentListItem = {
  source: 'answers',
  identifier: 'last-name',
};

local firstNameToListItem = {
  source: 'answers',
  identifier: 'first-name',
  list_item_selector: {
    source: 'location',
    id: 'to_list_item_id',
  },
};

local middleNamesToListItem = {
  source: 'answers',
  identifier: 'middle-names',
  list_item_selector: {
    source: 'location',
    id: 'to_list_item_id',
  },
};

local lastNameToListItem = {
  source: 'answers',
  identifier: 'last-name',
  list_item_selector: {
    source: 'location',
    id: 'to_list_item_id',
  },
};

local formatPersonName(source='', listName='') = (
  local firstNameSource = if source == 'first_list_item' then firstNameFirstListItem(listName) else if source == 'to_list_item' then firstNameToListItem else firstNameCurrentListItem;
  local middleNamesSource = if source == 'first_list_item' then middleNamesFirstListItem(listName) else if source == 'to_list_item' then middleNamesToListItem else middleNamesCurrentListItem;
  local lastNameSource = if source == 'first_list_item' then lastNameFirstListItem(listName) else if source == 'to_list_item' then lastNameToListItem else lastNameCurrentListItem;
  {
    transform: 'format_name',
    arguments: {
      include_middle_names: {
        source: 'previous_transform',
      },
      first_name: firstNameSource,
      middle_names: middleNamesSource,
      last_name: lastNameSource,
    },
  }
);

local formatPossessive = {
  transform: 'format_possessive',
  arguments: {
    string_to_format: {
      source: 'previous_transform',
    },
  },
};

local isSameName(source='', listName='') = (
  local valueSource = if source == 'first_list_item' then {
    source: 'list',
    id_selector: 'first',
    identifier: listName,
  } else {
    source: 'location',
    identifier: 'list_item_id',
  };

  {
    transform: 'contains',
    arguments: {
      list_to_check: {
        source: 'list',
        id_selector: 'same_name_items',
        identifier: listName,
      },
      value: valueSource,
    },
  }
);

local isCurrentPersonSameName = {
  transform: 'contains',
  arguments: {
    list_to_check: {
      source: 'list',
      id_selector: 'same_name_items',
      identifier: 'household',
    },
    value: {
      source: 'location',
      identifier: 'list_item_id',
    },
  },
};

local listHasSameNameItems = {
  transform: 'list_has_items',
  arguments: {
    list_to_check: {
      source: 'list',
      id_selector: 'same_name_items',
      identifier: 'household',
    },
  },
};

local concatenateNames = {
  transform: 'concatenate_list',
  arguments: {
    list_to_concatenate: {
      source: 'answers',
      identifier: ['first-name', 'last-name'],
    },
    delimiter: ' ',
  },
};

{
  formatPersonName: formatPersonName,
  formatPossessive: formatPossessive,
  isSameName: isSameName,
  listHasSameNameItems: listHasSameNameItems,
  concatenateNames: concatenateNames,
}
