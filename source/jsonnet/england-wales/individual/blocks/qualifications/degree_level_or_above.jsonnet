local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'Have you achieved a qualification at degree level or above?';
local proxyTitle = {
  text: 'Has <em>{person_name}</em> achieved a qualification at degree level or above?',
  placeholders: [
    placeholders.personName,
  ],
};

local englandQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside England and Wales';
local walesQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside Wales and England';

local questionGuidance = [
  'This is any higher education qualification, achieved in the UK or another country, at level 4 or above.',
  'Students are usually aged 18 years or over when they begin these qualifications through a college or university.',
  'Examples include level 4 and 5 qualifications, bachelor’s degrees with or without honours, master’s degrees, PhD or other doctorates and professional qualifications, such as PGCE or chartership.',
];

local question(title, region_code) = (
  local questionDescription = if region_code == 'GB-WLS' then walesQuestionDescription else englandQuestionDescription;
  {
    id: 'degree-level-or-above-question',
    title: title,
    description: [
      questionDescription,
    ],
    definitions: [{
      title: 'What we mean by “degree level or above”',
      contents: [
        { description: paragraph }
        for paragraph in questionGuidance
      ],
    }],
    type: 'General',
    answers: [
      {
        id: 'degree-level-or-above-answer',
        mandatory: false,
        type: 'Radio',
        options: [
          {
            label: 'Yes',
            value: 'Yes',
            description: 'For example, degree, foundation degree, HND or HNC, NVQ level 4 and above, teaching or nursing',
          },
          {
            label: 'No',
            value: 'No',
            description: 'Questions on other NVQs, A levels, GCSEs and equivalents will follow',
          },
        ],
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'degree-level-or-above',
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
