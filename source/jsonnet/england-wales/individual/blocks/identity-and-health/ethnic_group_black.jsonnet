local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyDefinitionDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDefinitionDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(englandTitle, walesTitle, region_code, definitionDescription, optionLabelValue) = (
  local title = if region_code == 'GB-WLS' then walesTitle else englandTitle;

  {
    id: 'black-ethnic-group-question',
    title: title,
    type: 'General',
    answers: [
      {
        guidance: {
          show_guidance: 'Why your answer is important',
          hide_guidance: 'Why your answer is important',
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
        id: 'black-ethnic-group-answer',
        mandatory: false,
        options: [
          {
            label: 'Caribbean',
            value: 'Caribbean',
          },
          {
            label: 'African',
            value: 'African',
            description: 'You can enter your ethnic group or background on the next question',
          },
          {
            label: optionLabelValue,
            value: optionLabelValue,
            description: 'You can enter your ethnic group or background on the next question',
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

local nonProxyEnglandTitle = 'Which one best describes your Black, Black British, Caribbean or African ethnic group or background?';
local proxyEnglandTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black British, Caribbean or African ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local nonProxyWalesTitle = 'Which one best describes your Black, Black Welsh, Black British, Caribbean or African ethnic group or background?';
local proxyWalesTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black Welsh, Black British, Caribbean or African ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};


function(region_code) (
  local optionLabelValue = if region_code == 'GB-WLS' then 'Any other Black, Black Welsh Black British or Caribbean background'
  else 'Any other Black, Black British or Caribbean background';
  {
    type: 'Question',
    id: 'black-ethnic-group',
    question_variants: [
      {
        question: question(nonProxyEnglandTitle, nonProxyWalesTitle, region_code, nonProxyDefinitionDescription, optionLabelValue),
        when: [rules.isNotProxy],
      },
      {
        question: question(proxyEnglandTitle, proxyWalesTitle, region_code, proxyDefinitionDescription, optionLabelValue),
        when: [rules.isProxy],
      },
    ],
    routing_rules: [
      {
        goto: {
          block: 'ethnic-group-black-other',
          when: [
            {
              id: 'black-ethnic-group-answer',
              condition: 'equals',
              value: optionLabelValue,
            },
          ],
        },
      },
      {
        goto: {
          block: 'ethnic-group-black-african',
          when: [
            {
              id: 'black-ethnic-group-answer',
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
