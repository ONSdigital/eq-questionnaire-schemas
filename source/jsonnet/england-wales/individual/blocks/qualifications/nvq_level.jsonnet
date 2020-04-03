local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'Have you achieved an NVQ or equivalent qualification?';
local proxyTitle = {
  text: 'Has <em>{person_name}</em> achieved an NVQ or equivalent qualification?',
  placeholders: [
    placeholders.personName,
  ],
};

local englandQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside England and Wales';
local walesQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside Wales and England';

local englandGuidance = 'This is a National Vocational Qualification. NVQs are competency and skills-based qualifications that can be achieved \nin school, college or at work.\n\nIf they have achieved similar qualifications, such as Scottish Vocational Qualifications or other vocational qualifications \noutside of the UK, choose the options they think are the closest match.';
local walesGuidance = 'This is a National Vocational Qualification. NVQs are competency and skills-based qualifications that can be achieved \nin school, college or at work.\n\nIf they have achieved similar qualifications, such as Scottish Vocational Qualifications or other vocational qualifications \noutside of the UK, choose the options they think are the closest match.';

local question(title, region_code) = (
  local questionDescription = if region_code == 'GB-WLS' then walesQuestionDescription else englandQuestionDescription;
  local regionGuidance = if region_code == 'GB-WLS' then walesGuidance else englandGuidance;
  {
    id: 'nvq-level-question',
    title: title,
    type: 'MutuallyExclusive',
    guidance: {
      title: 'What we mean by “NVQ”',
      contents: [
        {
          description: regionGuidance,
        },
      ],
    },
    mandatory: false,
    answers: [
      {
        id: 'nvq-level-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'NVQ level 3 or equivalent',
            value: 'NVQ level 3 or equivalent',
            description: 'For example, BTEC National, OND or ONC, City and Guilds Advanced Craft',
          },
          {
            label: 'NVQ level 2 or equivalent',
            value: 'NVQ level 2 or equivalent',
            description: 'For example, BTEC General, City and Guilds Craft',
          },
          {
            label: 'NVQ level 1 or equivalent',
            value: 'NVQ level 1 or equivalent',
          },
        ],
      },
      {
        id: 'nvq-level-answer-exclusive',
        type: 'Checkbox',
        mandatory: false,
        options: [
          {
            label: 'None of these apply',
            value: 'None of these apply',
            description: 'Questions on A levels, GCSEs and equivalents will follow',
          },
        ],
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'nvq-level',
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
}
