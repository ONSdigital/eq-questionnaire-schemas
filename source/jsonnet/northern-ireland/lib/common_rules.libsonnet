local over16 = {
  id: 'date-of-birth-answer',
  condition: 'less than or equal to',
  date_comparison: {
    value: std.extVar('census_date'),
    offset_by: {
      years: -16,
    },
  },
};

local over5 = {
  id: 'date-of-birth-answer',
  condition: 'less than or equal to',
  date_comparison: {
    value: std.extVar('census_date'),
    offset_by: {
      years: -5,
    },
  },
};

local under4 = {
  id: 'date-of-birth-answer',
  condition: 'greater than',
  date_comparison: {
    value: std.extVar('census_date'),
    offset_by: {
      years: -4,
    },
  },
};

local under3 = {
  id: 'date-of-birth-answer',
  condition: 'greater than',
  date_comparison: {
    value: std.extVar('census_date'),
    offset_by: {
      years: -3,
    },
  },
};

local under1 = {
  id: 'date-of-birth-answer',
  condition: 'greater than',
  date_comparison: {
    value: std.extVar('census_date'),
    offset_by: {
      years: -1,
    },
  },
};

{
  over16: over16,
  over5: over5,
  under4: under4,
  under3: under3,
  under1: under1,
  mainJob: {
    id: 'employment-status-answer-exclusive',
    condition: 'not set',
  },
  lastMainJob: {
    id: 'employment-status-answer-exclusive',
    condition: 'contains',
    value: 'None of these apply',
  },
  hasWorked: {
    id: 'ever-worked-answer',
    condition: 'not equals any',
    values: ['No, has never worked', 'No, have never worked'],
  },
  accommodationIsHouse: {
    id: 'accommodation-type-answer',
    condition: 'equals',
    value: 'Whole house or bungalow',
  },
  accommodationIsFlat: {
    id: 'accommodation-type-answer',
    condition: 'equals',
    value: 'Flat, maisonette or apartment',
  },
  isPrimary: {
    list: 'household',
    id_selector: 'primary_person',
    condition: 'equals',
    comparison: {
      source: 'location',
      id: 'list_item_id',
    },
  },
  isNotPrimary: {
    list: 'household',
    id_selector: 'primary_person',
    condition: 'not equals',
    comparison: {
      source: 'location',
      id: 'list_item_id',
    },
  },
  hasPrimary: {
    id: 'you-live-here-answer',
    condition: 'equals',
    value: 'Yes, I usually live here',
  },
}
