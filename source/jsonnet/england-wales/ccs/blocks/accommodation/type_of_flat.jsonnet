local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'type-of-flat-question',
  title: title,
  type: 'General',
  answers: [{
    id: 'type-of-flat-answer',
    mandatory: false,
    options: [
      {
        label: 'In a purpose-built block of flats or tenement',
        value: 'In a purpose-built block of flats or tenement',
      },
      {
        label: 'Part of a converted or shared house',
        value: 'Part of a converted or shared house',
        description: 'Including bedsits',
      },
      {
        label: 'Part of another converted building',
        value: 'Part of another converted building',
        description: 'For example, former school, church or warehouse',
      },
      {
        label: 'In a commercial building',
        value: 'In a commercial building',
        description: 'For example, in an office building, hotel, or over a shop',
      },
    ],
    type: 'Radio',
  }],
};

{
  type: 'Question',
  id: 'type-of-flat',
  question_variants: [
    {
      question: question('Where is your flat, maisonette or apartment?'),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('Where was your flat, maisonette or apartment?'),
      when: [rules.livingAtDifferentAddress],
    },
  ],
  routing_rules: [{
    goto: {
      block: 'self-contained',
    },
  }],
}
