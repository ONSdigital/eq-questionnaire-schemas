{
  lastBirthdayAgeOver(age): {
    id: 'age-last-birthday-answer',
    condition: 'greater than or equal to',
    value: age,
  },
  lastBirthdayAgeLessThan(age): {
    id: 'age-last-birthday-answer',
    condition: 'less than',
    value: age,
  },
  over16: {
    id: 'date-of-birth-answer',
    condition: 'less than or equal to',
    date_comparison: {
      value: std.extVar('census_date'),
      offset_by: {
        years: -16,
      },
    },
  },
  over5: {
    id: 'date-of-birth-answer',
    condition: 'less than or equal to',
    date_comparison: {
      value: std.extVar('census_date'),
      offset_by: {
        years: -5,
      },
    },
  },
  under4: {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: std.extVar('census_date'),
      offset_by: {
        years: -4,
      },
    },
  },
  under3: {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: std.extVar('census_date'),
      offset_by: {
        years: -3,
      },
    },
  },
  under1: {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: std.extVar('census_date'),
      offset_by: {
        years: -1,
      },
    },
  },
  schoolYearUnder4: {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: '2020-06-30',
      offset_by: {
        years: -4,
      },
    },
  },
  mainJob: {
    id: 'employment-status-last-seven-days-answer-exclusive',
    condition: 'not set',
  },
  lastMainJob: {
    id: 'employment-status-last-seven-days-answer-exclusive',
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
    id: 'do-you-usually-live-here-answer',
    condition: 'equals',
    value: 'Yes, I usually live here',
  },
  hasNoPrimary: {
    id: 'do-you-usually-live-here-answer',
    condition: 'equals',
    value: 'No, I don’t usually live here',
  },
}
