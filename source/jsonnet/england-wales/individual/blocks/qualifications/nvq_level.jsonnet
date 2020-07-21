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

local englandGuidanceNonProxy = [
  'This is a National Vocational Qualification. NVQs are competency and skills-based qualifications that can be achieved in school, college or at work.',
  'If you have achieved similar qualifications, such as Scottish Vocational Qualifications or other vocational qualifications outside of the UK, choose the options you think are the closest match.',
];
local englandGuidanceProxy = [
  'This is a National Vocational Qualification. NVQs are competency and skills-based qualifications that can be achieved in school, college or at work.',
  'If they have achieved similar qualifications, such as Scottish Vocational Qualifications or other vocational qualifications outside of the UK, choose the options they think are the closest match.',
];
local walesGuidanceNonProxy = [
  'This is a National Vocational Qualification. NVQs are competency and skills-based qualifications that can be achieved in school, college or at work.',
  'If you have achieved similar qualifications, such as Scottish Vocational Qualifications or other vocational qualifications outside of the UK, choose the options you think are the closest match.',
];
local walesGuidanceProxy = [
  'This is a National Vocational Qualification. NVQs are competency and skills-based qualifications that can be achieved in school, college or at work.',
  'If they have achieved similar qualifications, such as Scottish Vocational Qualifications or other vocational qualifications outside of the UK, choose the options they think are the closest match.',
];

local guidance(region_code, isProxy) = (
  if region_code == 'GB-WLS' then
    if isProxy then walesGuidanceProxy else walesGuidanceNonProxy
  else if isProxy then englandGuidanceProxy else englandGuidanceNonProxy
);

local question(region_code, isProxy) = (
  local questionDescription = if region_code == 'GB-WLS' then walesQuestionDescription else englandQuestionDescription;
  {
    id: 'nvq-level-question',
    title: if isProxy then proxyTitle else nonProxyTitle,
    type: 'MutuallyExclusive',
    description: [
      questionDescription,
    ],
    definitions: [{
      title: 'What we mean by “NVQ”',
      contents: [
        { description: paragraph }
        for paragraph in guidance(region_code, isProxy)
      ],
    }],
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
      question: question(region_code, isProxy=false),
      when: [rules.isNotProxy],
    },
    {
      question: question(region_code, isProxy=true),
      when: [rules.isProxy],
    },
  ],
}
