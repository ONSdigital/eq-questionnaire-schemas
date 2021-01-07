local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, region_code) = (
  {
    id: 'other-black-black-british-caribbean-or-african-ethnic-group-question',
    title: title,
    type: 'General',
    answers: [
      {
        id: 'other-black-black-british-caribbean-or-african-ethnic-group-answer',
        label: 'Black, Black British or Caribbean ethnic group or background',
        description: 'Enter your own answer or select from suggestions',
        max_length: 100,
        mandatory: false,
        suggestions: { url: '{suggestions_url_root}/ethnic-groups.json' },
        type: 'TextField',
      },
    ],
  }
);

local nonProxyTitle = 'You selected “Any other Black, Black British or Caribbean background”. How would you describe your Black, Black British or Caribbean ethnic group or background?';
local proxyTitle = {
  text: 'You selected “Any other Black, Black British or Caribbean background”. How would <em>{person_name}</em> describe their Black, Black British or Caribbean ethnic group or background?',
  placeholders: [
    placeholders.personName(),
  ],
};

function(region_code) {
  type: 'Question',
  id: 'other-black-black-british-caribbean-or-african-ethnic-group',
  page_title: 'Other Black, Black British or Caribbean ethnic group or background',
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
