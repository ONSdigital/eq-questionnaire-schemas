{
  type: 'Interstitial',
  id: 'who-to-interview-note',
  interviewer_only: true,
  content: {
    title: 'Who to interview',
    instruction: ['If the respondent was not living at the property on census night, but other current household members were, you must speak to one of those household members instead. <p>If none of those household members are available, <strong>save and sign out</strong> of the questionnaire. You must return to the address to interview one of them at a later time or date.</p>'],
  },
  routing_rules: [
    {
      goto: {
        block: 'were-you-usually-living-here',
      },
    },
  ],
}
