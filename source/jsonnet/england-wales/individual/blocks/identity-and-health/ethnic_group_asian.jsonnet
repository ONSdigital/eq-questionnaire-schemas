local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDefinitionDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDefinitionDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(englandTitle, walesTitle, region_code, guidance, definitionDescription, otherAsianBackgroundDescription) = (
  local title = if region_code == 'GB-WLS' then walesTitle else englandTitle;
  {
    id: 'asian-or-asian-british-ethnic-group-question',
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
        id: 'asian-or-asian-british-ethnic-group-answer',
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
            description: otherAsianBackgroundDescription,
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

local englandPageTitle = 'Asian or Asian British ethnic group or background';
local nonProxyEnglandTitle = 'Which one best describes your Asian or Asian British ethnic group or background?';
local proxyEnglandTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Asian or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local walesPageTitle = 'Asian, Asian Welsh or Asian British ethnic group or background';
local nonProxyWalesTitle = 'Which one best describes your Asian, Asian Welsh or Asian British ethnic group or background?';
local proxyWalesTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Asian, Asian Welsh or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

function(region_code) {
  type: 'Question',
  id: 'asian-or-asian-british-ethnic-group',
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
        block: 'other-asian-or-asian-british-ethnic-group',
        when: [
          {
            id: 'asian-or-asian-british-ethnic-group-answer',
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
