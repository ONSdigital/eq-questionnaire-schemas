local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'outside-uk-note',
  interviewer_only: true,
  content: {
    title: 'End of interview',
    instruction: {
      text: 'If the respondent was living outside the UK on Sunday {census_date}, please explain that they do not need to complete the questionnaire and end interview <p>You still need to submit this questionnaire.</p><p> Continue past the household members summary page and select Submit.</p>',
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
