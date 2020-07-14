local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'outside-uk-note',
  content: {
    title: 'Interviewer Note',
    instruction: {
      text: 'If the respondent was living outside the UK on Sunday {census_date}, please explain that they do not need to complete the questionnaire and end interview',
      placeholders: [
        placeholders.censusDate,
      ],
    },
  },
  routing_rules: [
    {
      goto: {
        section: 'End',
      },
    },
  ],
}
