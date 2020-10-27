local formatFirstPersonName(listName) = {
  transform: 'format_name',
  arguments: {
    include_middle_names: {
      source: 'previous_transform',
    },
    first_name: {
      source: 'answers',
      identifier: 'first-name',
      list_item_selector: {
        id: listName,
        id_selector: 'first',
        source: 'list',
      },
    },
    middle_names: {
      source: 'answers',
      identifier: 'middle-names',
      list_item_selector: {
        id: listName,
        id_selector: 'first',
        source: 'list',
      },
    },
    last_name: {
      source: 'answers',
      identifier: 'last-name',
      list_item_selector: {
        id: listName,
        id_selector: 'first',
        source: 'list',
      },
    },
  },
};

local formatCurrentPersonName = {
  transform: 'format_name',
  arguments: {
    include_middle_names: { source: 'previous_transform' },
    first_name: {
      source: 'answers',
      identifier: 'first-name',
    },
    middle_names: {
      source: 'answers',
      identifier: 'middle-names',
    },
    last_name: {
      source: 'answers',
      identifier: 'last-name',
    },
  },
};

local formatSecondPersonName = {
  transform: 'format_name',
  arguments: {
    include_middle_names: { source: 'previous_transform' },
    first_name: {
      source: 'answers',
      identifier: 'first-name',
      list_item_selector: {
        source: 'location',
        id: 'to_list_item_id',
      },
    },
    middle_names: {
      source: 'answers',
      identifier: 'middle-names',
      list_item_selector: {
        source: 'location',
        id: 'to_list_item_id',
      },
    },
    last_name: {
      source: 'answers',
      identifier: 'last-name',
      list_item_selector: {
        source: 'location',
        id: 'to_list_item_id',
      },
    },
  },
};

local formatPossessive = {
  transform: 'format_possessive',
  arguments: {
    string_to_format: {
      source: 'previous_transform',
    },
  },
};

local isFirstPersonSameName(listName) = {
  transform: 'contains',
  arguments: {
    list_to_check: {
      source: 'list',
      id_selector: 'same_name_items',
      identifier: listName,
    },
    value: {
      source: 'list',
      id_selector: 'first',
      identifier: listName,
    },
  },
};

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
  formatFirstPersonName: formatFirstPersonName,
  formatCurrentPersonName: formatCurrentPersonName,
  formatSecondPersonName: formatSecondPersonName,
  formatPossessive: formatPossessive,
  isFirstPersonSameName: isFirstPersonSameName,
  isCurrentPersonSameName: isCurrentPersonSameName,
  listHasSameNameItems: listHasSameNameItems,
  concatenateNames: concatenateNames,
}
