local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDefinitionDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDefinitionDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(englandTitle, walesTitle, region_code, guidance, definitionDescription, optionDescriptionAfricanOther) = (
  local title = if region_code == 'GB-WLS' then walesTitle else englandTitle;

  {
    id: 'black-black-british-caribbean-or-african-ethnic-group-question',
    title: title,
    type: 'General',
    answers: [
      {
        guidance: {
          show_guidance: guidance,
          hide_guidance: guidance,
          contents: [
            {
              description: definitionDescription,
              list: [
                'provide services and share funding fairly',
                'understand and represent everyone’s interests',
              ],
            },
          ],
        },
        id: 'black-black-british-caribbean-or-african-ethnic-group-answer',
        mandatory: false,
        options: [
          {
            label: 'Caribbean',
            value: 'Caribbean',
          },
          {
            label: 'African',
            value: 'African',
            description: optionDescriptionAfricanOther,
          },
          {
            label: 'Any other Black, Black British or Caribbean background',
            value: 'Any other Black, Black British or Caribbean background',
            description: optionDescriptionAfricanOther,
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

local englandPageTitle = 'Black, Black British, Caribbean or African ethnic group or background';
local nonProxyEnglandTitle = 'Which one best describes your Black, Black British, Caribbean or African ethnic group or background?';
local proxyEnglandTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black British, Caribbean or African ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local walesPageTitle = 'Black, Black Welsh, Black British, Caribbean or African ethnic group or background';
local nonProxyWalesTitle = 'Which one best describes your Black, Black Welsh, Black British, Caribbean or African ethnic group or background?';
local proxyWalesTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black Welsh, Black British, Caribbean or African ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};


function(region_code) (
  {
    type: 'Question',
    id: 'black-black-british-caribbean-or-african-ethnic-group',
    page_title: if region_code == 'GB-WLS' then walesPageTitle else englandPageTitle,
    question_variants: [
      {
        question: question(nonProxyEnglandTitle, nonProxyWalesTitle, region_code, nonProxyGuidance, nonProxyDefinitionDescription, 'You can enter your ethnic group or background on the next question'),
        when: [rules.isNotProxy],
      },
      {
        question: question(proxyEnglandTitle, proxyWalesTitle, region_code, proxyGuidance, proxyDefinitionDescription, 'You can enter their ethnic group or background on the next question'),
        when: [rules.isProxy],
      },
    ],
    routing_rules: [
      {
        goto: {
          block: 'other-black-black-british-caribbean-or-african-ethnic-group',
          when: [
            {
              id: 'black-black-british-caribbean-or-african-ethnic-group-answer',
              condition: 'equals',
              value: 'Any other Black, Black British or Caribbean background',
            },
          ],
        },
      },
      {
        goto: {
          block: 'ethnic-group-black-african',
          when: [
            {
              id: 'black-black-british-caribbean-or-african-ethnic-group-answer',
              condition: 'equals',
              value: 'African',
            },
          ],
        },
      },
      {
        goto: {
          block: 'religion',
        },
      },
    ],
  }
)
