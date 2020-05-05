local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'visitor-sex',
  question: {
    id: 'visitor-sex-question',
    title: {
      text: 'What is <em>{person_name_possessive}</em> sex?',
      placeholders: [
        placeholders.personNamePossessive,
      ],
    },
    type: 'General',
    answers: [
      {
        guidance: {
          show_guidance: 'Why we ask for visitor details',
          hide_guidance: 'Why we ask for visitor details',
          contents: [
            {
              description: 'Your answer helps to ensure that everyone is counted in the census. Add visitor details, even if you think they have been included on a census questionnaire at another address.',
            },
          ],
        },
        id: 'visitor-sex-answer',
        mandatory: false,
        options: [
          {
            label: 'Female',
            value: 'Female',
          },
          {
            label: 'Male',
            value: 'Male',
          },
        ],
        type: 'Radio',
      },
    ],
  },
}
