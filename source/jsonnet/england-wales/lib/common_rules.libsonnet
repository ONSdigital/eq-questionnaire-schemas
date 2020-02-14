local over19(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'less than or equal to',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -19,
      },
    },
};

local over16(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'less than or equal to',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -16,
      },
    },
};

local under16(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -16,
      },
    },
};

local over15(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'less than or equal to',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -15,
      },
    },
};

local under5(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -5,
      },
    },
};

local under4(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -4,
      },
    },
};

local under3(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -3,
      },
    },
};

local under1(census_date) = {
    id: 'date-of-birth-answer',
    condition: 'greater than',
    date_comparison: {
      value: census_date,
      offset_by: {
        years: -1,
      },
    },
};

{
  over19: over19,
  over16: over16,
  under16: under16,
  over15: over15,
  under5: under5,
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
  accomodationNotAnswered: {
    id: 'accomodation-type-answer',
    condition: 'not set',
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
