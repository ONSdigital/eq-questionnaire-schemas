local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(englandTitle, walesTitle, region_code) = (
  local title = if region_code == 'GB-WLS' then walesTitle else englandTitle;
  local label = if region_code == 'GB-WLS' then 'Black, Black Welsh, Black British or Caribbean background'
  else 'Black, Black British or Caribbean background';
  {
    id: 'ethnic-group-black-other-question',
    title: title,
    type: 'General',
    answers: [
      {
        id: 'ethnic-group-black-other-answer',
        label: label,
        description: 'Enter your own answer or select from suggestions',
        mandatory: false,
        type: 'TextField',
      },
    ],
  }
);

local nonProxyEnglandTitle = 'You selected “Any other Black, Black British or Caribbean background”. How would you describe your Black, Black British or Caribbean background?';
local proxyEnglandTitle = {
  text: 'You selected “Any other Black, Black British or Caribbean background”. How would <em>{person_name}</em> describe their Black, Black British or Caribbean background?',
  placeholders: [
    placeholders.personName,
  ],
};
local nonProxyWalesTitle = 'You selected “Any other Black, Black Welsh, Black British or Caribbean”. How would you describe your Black, Black British or Caribbean background?';
local proxyWalesTitle = {
  text: 'You selected “Any other Black, Black Welsh, Black British or Caribbean”. How would <em>{person_name}</em> describe their Black, Black British or Caribbean background?',
  placeholders: [
    placeholders.personName,
  ],
};

function(region_code) {
  type: 'Question',
  id: 'ethnic-group-black-other',
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
