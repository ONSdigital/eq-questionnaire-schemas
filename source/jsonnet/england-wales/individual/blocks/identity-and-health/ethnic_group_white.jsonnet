local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'Which one best describes your White ethnic group or background?';
local proxyTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> White ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local englandOption = 'English, Welsh, Scottish, Northern Irish or British';
local walesOption = 'Welsh, English, Scottish, Northern Irish or British';

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(title, guidance, description, region_code, whiteBackgroundDescription) = (
  local radioOptions = if region_code == 'GB-WLS' then walesOption else englandOption;
  {
    id: 'white-ethnic-group-question',
    title: title,
    type: 'General',
    answers: [
      {
        guidance: {
          show_guidance: guidance,
          hide_guidance: guidance,
          contents: [
            {
              description: description,
              list: [
                'provide services and share funding fairly',
                'understand and represent everyone’s interests',
              ],
            },
          ],
        },
        id: 'white-ethnic-group-answer',
        mandatory: false,
        options: [
          {
            label: radioOptions,
            value: radioOptions,
          },
          {
            label: 'Irish',
            value: 'Irish',
          },
          {
            label: 'Gypsy or Irish Traveller',
            value: 'Gypsy or Irish Traveller',
          },
          {
            label: 'Roma',
            value: 'Roma',
          },
          {
            label: 'Any other White background',
            value: 'Any other White background',
            description: whiteBackgroundDescription,
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'white-ethnic-group',
  page_title: 'White ethnic group or background',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidance, nonProxyDescription, region_code, 'You can enter your ethnic group or background on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidance, proxyDescription, region_code, 'You can enter their ethnic group or background on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'ethnic-group-white-other',
        when: [
          {
            id: 'white-ethnic-group-answer',
            condition: 'equals',
            value: 'Any other White background',
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
