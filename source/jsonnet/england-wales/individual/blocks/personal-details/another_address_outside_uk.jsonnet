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
      mandatory: true,
      suggestions_url: "https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/countries-of-birth.json",
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'another-address-outside-uk',
  question_variants: [
    {
      question: question('In which country outside of the UK is the address you stay at for more than 30 days a year?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'In which country outside of the UK is the address <em>{person_name}</em> stays at for more than 30 days a year?',
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
