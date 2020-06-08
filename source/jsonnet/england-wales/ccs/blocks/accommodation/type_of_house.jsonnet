local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'type-of-house-question',
  title: title,
  type: 'General',
  answers: [{
    id: 'type-of-house-answer',
    mandatory: false,
    options: [
      {
        label: 'Detached',
        value: 'Detached',
      },
      {
        label: 'Semi-detached',
        value: 'Semi-detached',
      },
      {
        label: 'Terraced',
        value: 'Terraced',
        description: 'Including end-terrace',
      },
    ],
    type: 'Radio',
  }],
};

{
  type: 'Question',
  id: 'type-of-house',
  question_variants: [
    {
      question: question('Which of the following is your house or bungalow?'),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('Which of the following was your house or bungalow?'),
      when: [rules.livingAtDifferentAddress],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'self-contained',
      },
    },
  ],
}
