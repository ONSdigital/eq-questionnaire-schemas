{
  type: 'Interstitial',
  id: 'who-to-interview-note',
  content: {
    title: '<em>Interviewer Note</em>',
    instruction: 'If the respondent was not living at the property on census night, but other current household members were, you must speak to one of those household members instead. <p>If none of those household members are available, you must return to the address to interview one of them at a later date.</p>',
  },
  routing_rules: [
    {
      goto: {
        block: 'primary-person-list-collector',
      },
    },
  ],
}
