local common_rules = import '../../lib/common_rules.libsonnet';

local listIsEmpty(listName) = {
  list: listName,
  condition: 'equals',
  value: 0,
};

local listIsNotEmpty(listName) = {
  list: listName,
  condition: 'greater than',
  value: 0,
};

local isFirstPersonInList(listName) = {
  list: listName,
  id_selector: 'first',
  condition: 'equals',
  comparison: {
    source: 'location',
    id: 'list_item_id',
  },
};

local isNotFirstPersonInList(listName) = {
  list: listName,
  id_selector: 'first',
  condition: 'not equals',
  comparison: {
    source: 'location',
    id: 'list_item_id',
  },
};

{
  isNotProxy: {
    id: 'proxy-answer',
    condition: 'equals',
    value: 'Yes, I am',
  },
  isProxy: {
    id: 'proxy-answer',
    condition: 'equals',
    value: 'No, I am answering on their behalf',
  },
  listIsEmpty: listIsEmpty,
  listIsNotEmpty: listIsNotEmpty,
  isFirstPersonInList: isFirstPersonInList,
  isNotFirstPersonInList: isNotFirstPersonInList,
} + common_rules
