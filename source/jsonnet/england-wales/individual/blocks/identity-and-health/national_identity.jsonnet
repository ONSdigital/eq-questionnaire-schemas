local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'How would you describe your national identity?';
local nonProxyDescription = 'This relates to where you feel you belong, such as the country or countries you think of as home.<br><br>This could be different from your citizenship or ethnic group.';

local proxyTitle = {
  text: 'How would <em>{person_name}</em> describe their national identity?',
  placeholders: [
    placeholders.personName,
  ],
};
local proxyDescription = 'This relates to where they feel they belong, such as the country or countries they think of as home. <br><br> This could be different from their citizenship or ethnic group';

local englandOptions = [
  {
    label: 'English',
    value: 'English',
  },
  {
    label: 'Welsh',
    value: 'Welsh',
  },
];

local walesOptions = [
  {
    label: 'Welsh',
    value: 'Welsh',
  },
  {
    label: 'English',
    value: 'English',
  },
];

local nonProxyDetailAnswerLabel = 'Describe your national identity';
local proxyDetailAnswerLabel = 'Describe their national identity';

local question(title, description, detailAnswerLabel, region_code) = (
  local regionOptions = if region_code == 'GB-WLS' then walesOptions else englandOptions;
  {
    id: 'national-identity-question',
    title: title,
    type: 'General',
    description: description,
    answers: [
      {
        id: 'national-identity-answer',
        mandatory: false,
        type: 'Checkbox',
        options: regionOptions + [
          {
            label: 'Scottish',
            value: 'Scottish',
          },
          {
            label: 'Northern Irish',
            value: 'Northern Irish',
          },
          {
            label: 'British',
            value: 'British',
          },
          {
            label: 'Other',
            value: 'Other',
            description: 'You can enter your national identity on the next question',
          },
        ],
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'national-identity',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDescription, nonProxyDetailAnswerLabel, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDescription, proxyDetailAnswerLabel, region_code),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'national-identity-other',
        when: [
          {
            condition: 'contains',
            id: 'national-identity-answer',
            value: 'Other',
          },
        ],
      },
    },
    {
      goto: {
        block: 'ethnic-group',
      },
    },
  ],
}
