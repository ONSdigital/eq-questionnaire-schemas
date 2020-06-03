local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'interviewer-note',
  question: {
    id: 'interviewer-note-question',
    title: {
      text: 'Interviewer Note: Was the respondent living at {household_address}, on {census_date}?',
      placeholders: [placeholders.address, placeholders.censusDate],
    },
    type: 'General',
    answers: [{
      id: 'interviewer-note-answer',
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
