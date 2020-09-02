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
      max_length: 100,
      mandatory: true,
      suggestions_url: {
        text: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v3.0.0/gb/{language_code}/countries-of-birth.json',
        placeholders: [
          placeholders.languageCode,
        ],
      },
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a country',
        },
      },
    },
  ],
};

{
  type: 'Question',
  id: 'another-address-outside-uk',
  question_variants: [
    {
      question: question('In which country outside the UK is the address you stay at for more than 30 days a year?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'In which country outside the UK is the address <em>{person_name}</em> stays at for more than 30 days a year?',
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
