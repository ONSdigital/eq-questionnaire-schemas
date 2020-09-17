local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, region_code) = (
  {
    id: 'other-asian-or-asian-british-ethnic-group-question',
    title: title,
    type: 'General',
    answers: [
      {
        id: 'other-asian-or-asian-british-ethnic-group-answer',
        label: 'Asian or Asian British ethnic group or background',
        description: 'Enter your own answer or select from suggestions',
        max_length: 100,
        mandatory: false,
        suggestions_url: '{suggestions_url_root}/ethnic-groups.json',
        type: 'TextField',
      },
    ],
  }
);

local nonProxyTitle = 'You selected “Any other Asian background”. How would you describe your Asian or Asian British ethnic group or background?';
local proxyTitle = {
  text: 'You selected “Any other Asian background”. How would <em>{person_name}</em> describe their Asian or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};

function(region_code) {
  type: 'Question',
  id: 'other-asian-or-asian-british-ethnic-group',
  question_variants: [
    {
      question: question(nonProxyTitle, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, region_code),
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
