local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'another-address-outside-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'another-address-outside-uk-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'another-address-outside-uk',
  question_variants: [
    {
      question: question('Which country outside of the UK do you stay at for more than 30 days a year?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'Which country outside of the UK does <em>{person_name}</em> stay at for more than 30 days a year?',
        placeholders: [
          placeholders.personName,
        ],
      }),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'address-type',
      },
    },
  ],
}
