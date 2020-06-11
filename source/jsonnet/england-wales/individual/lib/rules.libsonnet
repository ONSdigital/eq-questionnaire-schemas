local common_rules = import '../../lib/common_rules.libsonnet';

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
    value: 'For myself',
  },
  isProxy: {
    id: 'proxy-answer',
    condition: 'equals',
    value: 'For someone else',
  },
  isFirstPersonInList: isFirstPersonInList,
  isNotFirstPersonInList: isNotFirstPersonInList,
} + common_rules
