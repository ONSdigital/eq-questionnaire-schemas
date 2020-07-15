local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'respondent-living-at',
  interviewer_only: 'true',
  question: {
    id: 'respondent-living-at-question',
    title: {
      text: 'Was the respondent living at {household_address} on Sunday {census_date}?',
      placeholders: [placeholders.address, placeholders.censusDate],
    },
    type: 'General',
    answers: [{
      id: 'respondent-living-at-answer',
      mandatory: true,
      options: [
        {
          label: 'Yes, living at this address',
          value: 'Yes, living at this address',
        },
        {
          label: 'No, living at a different address',
          value: 'No, living at a different address',
        },
      ],
      type: 'Radio',
    }],
  },
}
