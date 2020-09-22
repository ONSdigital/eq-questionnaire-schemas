local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'responsible-for-establishment',
  page_title: 'Manager of this establishment',
  question: {
    id: 'responsible-for-establishment-question',
    title: 'Who is responsible for the management of this establishment?',
    type: 'General',
    answers: [{
      id: 'responsible-for-establishment-answer',
      mandatory: false,
      options: [
        {
          label: 'NHS',
          value: 'NHS',
        },
        {
          label: 'Local authority',
          value: 'Local authority',
        },
        {
          label: 'Government department or agency',
          value: 'Government department or agency',
        },
        {
          label: 'Registered social landlord or housing association',
          value: 'Registered social landlord or housing association',
        },
        {
          label: 'Charity or voluntary organisation',
          value: 'Charity or voluntary organisation',
        },
        {
          label: 'Private owner or company',
          value: 'Private owner or company',
        },
        {
          label: 'Higher or further education institution',
          value: 'Higher or further education institution',
        },
        {
          label: 'Other',
          value: 'Other',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'people-in-establishment',
      },
    },
  ],
}
