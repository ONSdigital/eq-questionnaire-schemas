local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(englandTitle, walesTitle, region_code) = (
  local title = if region_code == 'GB-WLS' then walesTitle else englandTitle;
  local label = if region_code == 'GB-WLS' then 'Asian, Asian Welsh or Asian British ethnic group or background'
  else 'Asian or Asian British ethnic group or background';
  {
    id: 'other-asian-or-asian-british-ethnic-group-question',
    title: title,
    type: 'General',
    answers: [
      {
        id: 'other-asian-or-asian-british-ethnic-group-answer',
        label: label,
        description: 'Enter your own answer or select from suggestions',
        max_length: 100,
        mandatory: false,
        suggestions_url: '{suggestions_url_root}/ethnic-groups.json',
        type: 'TextField',
      },
    ],
  }
);

local nonProxyEnglandTitle = 'You selected “Any other Asian background”. How would you describe your Asian or Asian British ethnic group or background?';
local proxyEnglandTitle = {
  text: 'You selected “Any other Asian background”. How would <em>{person_name}</em> describe their Asian or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};
local nonProxyWalesTitle = 'You selected “Any other Asian background”. How would you describe your Asian, Asian Welsh or Asian British ethnic group or background?';
local proxyWalesTitle = {
  text: 'You selected “Any other Asian background”. How would <em>{person_name}</em> describe their Asian, Asian Welsh or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};

function(region_code) {
  type: 'Question',
  id: 'other-asian-or-asian-british-ethnic-group',
  question_variants: [
    {
      question: question(nonProxyEnglandTitle, nonProxyWalesTitle, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyEnglandTitle, proxyWalesTitle, region_code),
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
