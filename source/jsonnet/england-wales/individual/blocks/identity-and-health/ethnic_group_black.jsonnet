local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(englandTitle, walesTitle, region_code) = (
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
              description: 'Your answer will help to support equality and fairness in your community. Councils and government use information on ethnic group to make sure they',
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
            label: 'Any other Black, Black British or Caribbean background',
            value: 'Any other Black, Black British or Caribbean background',
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

function(region_code) {
  type: 'Question',
  id: 'black-ethnic-group',
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
        block: 'ethnic-group-black-other',
        when: [
          {
            id: 'black-ethnic-group-answer',
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
