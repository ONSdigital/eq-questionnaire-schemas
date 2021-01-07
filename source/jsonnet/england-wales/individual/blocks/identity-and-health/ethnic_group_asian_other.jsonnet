local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'You selected “Any other Asian background”. How would <em>{person_name}</em> describe their Asian ethnic group or background?',
    placeholders: [
      placeholders.personName(),
    ],
  } else 'You selected “Any other Asian background”. How would you describe your Asian ethnic group or background?'
);

local question(isProxy) = (
  {
    id: 'other-asian-or-asian-british-ethnic-group-question',
    title: questionTitle(isProxy),
    type: 'General',
    answers: [
      {
        id: 'other-asian-or-asian-british-ethnic-group-answer',
        label: 'Asian ethnic group or background',
        description: 'Enter your own answer or select from suggestions',
        max_length: 100,
        mandatory: false,
        suggestions: { url: '{suggestions_url_root}/ethnic-groups.json' },
        type: 'TextField',
      },
    ],
  }
);


{
  type: 'Question',
  id: 'other-asian-or-asian-british-ethnic-group',
  page_title: 'Other Asian ethnic group or background',
  question_variants: [
    {
      question: question(isProxy=false),
      when: [rules.isNotProxy],
    },
    {
      question: question(isProxy=true),
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
