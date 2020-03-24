local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyDefinitionDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDefinitionDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(englandTitle, walesTitle, region_code, definitionDescription) = (
  local title = if region_code == 'GB-WLS' then walesTitle else englandTitle;
  {
    id: 'asian-ethnic-group-question',
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
        id: 'asian-ethnic-group-answer',
        mandatory: false,
        options: [
          {
            label: 'Indian',
            value: 'Indian',
          },
          {
            label: 'Pakistani',
            value: 'Pakistani',
          },
          {
            label: 'Bangladeshi',
            value: 'Bangladeshi',
          },
          {
            label: 'Chinese',
            value: 'Chinese',
          },
          {
            label: 'Any other Asian background',
            value: 'Any other Asian background',
            description: 'You can enter your ethnic group or background on the next question',
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

local nonProxyEnglandTitle = 'Which one best describes your Asian or Asian British ethnic group or background?';
local proxyEnglandTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Asian or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local nonProxyWalesTitle = 'Which one best describes your Asian, Asian Welsh or Asian British ethnic group or background?';
local proxyWalesTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Asian, Asian Welsh or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

function(region_code) {
  type: 'Question',
  id: 'asian-ethnic-group',
  question_variants: [
    {
      question: question(nonProxyEnglandTitle, nonProxyWalesTitle, region_code, nonProxyDefinitionDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyEnglandTitle, proxyWalesTitle, region_code, proxyDefinitionDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'ethnic-group-asian-other',
        when: [
          {
            id: 'asian-ethnic-group-answer',
            condition: 'equals',
            value: 'Any other Asian background',
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
