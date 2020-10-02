local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-other-answer',
      label: 'Ethnic group',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: '{suggestions_url_root}/ethnic-groups.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-other',
  page_title: 'Other ethnic group describe',
  question_variants: [
    {
      question: question('You selected “Any other ethnic group”. How would you describe your ethnic group?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Any other ethnic group”. How would <em>{person_name}</em> describe their ethnic group?',
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
        block: 'religion',
      },
    },
  ],
}
