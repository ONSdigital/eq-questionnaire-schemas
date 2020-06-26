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

local estimatedAge = {
  id: 'date-of-birth-answer',
  condition: 'not set',
};

local livingAtDifferentAddress = {
  id: 'interviewer-note-answer',
  condition: 'equals',
  value: 'No, living at a different address',
};

local livingAtCurrentAddress = {
  id: 'interviewer-note-answer',
  condition: 'equals',
  value: 'Yes, living at this address',
};

local livesAtHouseholdAddress = {
  id: 'you-live-here-answer',
  condition: 'equals',
  value: 'Yes',
};


local doesntLiveAtHouseholdAddress = {
  id: 'you-live-here-answer',
  condition: 'equals',
  value: 'No',
};

{
  isNotProxy: {
    id: 'proxy-answer',
    condition: 'equals',
    value: 'Yes, they are answering for themselves',
  },
  isProxy: {
    id: 'proxy-answer',
    condition: 'equals',
    value: 'No, they are answering on someone else’s behalf',
  },
  listIsEmpty: listIsEmpty,
  listIsNotEmpty: listIsNotEmpty,
  estimatedAge: estimatedAge,
  livingAtDifferentAddress: livingAtDifferentAddress,
  livingAtCurrentAddress: livingAtCurrentAddress,
  isFirstPersonInList: isFirstPersonInList,
  isNotFirstPersonInList: isNotFirstPersonInList,
  livesAtHouseholdAddress: livesAtHouseholdAddress,
  doesntLiveAtHouseholdAddress: doesntLiveAtHouseholdAddress,

} + common_rules
