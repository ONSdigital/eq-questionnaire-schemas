local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'Have you achieved an AS, A level or equivalent qualification?';
local proxyTitle = {
  text: 'Has <em>{person_name}</em> achieved an AS, A level or equivalent qualification?',
  placeholders: [
    placeholders.personName,
  ],
};

local englandQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside England and Wales';
local walesQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside Wales and England';

local englandGuidanceNonProxy = [
  'These are advanced-level, subject-based qualifications that are often needed to get a place at university. Students in England and Wales usually complete AS levels by the age of 17 years and A levels by the age of 18 years.',
  'If you have achieved similar qualifications outside of England and Wales, choose the options you think are the closest match.',
  'An International Baccalaureate diploma is equivalent to three A levels.',
];
local englandGuidanceProxy = [
  'These are advanced-level, subject-based qualifications that are often needed to get a place at university. Students in England and Wales usually complete AS levels by the age of 17 years and A levels by the age of 18 years.',
  'If they have achieved similar qualifications outside of England and Wales, choose the options they think are the closest match.',
  'An International Baccalaureate diploma is equivalent to three A levels.',
];

local walesGuidanceNonProxy = [
  'These are advanced-level, subject-based qualifications that are often needed to get a place at university. Students in Wales and England usually complete AS levels by the age of 17 years and A levels by the age of 18 years.',
  'If you have achieved similar qualifications outside of Wales and England, choose the options you think are the closest match.',
  'An International Baccalaureate diploma is equivalent to three A levels.',
];
local walesGuidanceProxy = [
  'These are advanced-level, subject-based qualifications that are often needed to get a place at university. Students in Wales and England usually complete AS levels by the age of 17 years and A levels by the age of 18 years',
  'If they have achieved similar qualifications outside of Wales and England, choose the options they think are the closest match.',
  'An International Baccalaureate diploma is equivalent to three A levels.',
];

local walesOption = [{
  label: 'Advanced Welsh Baccalaureate',
  value: 'Advanced Welsh Baccalaureate',
}];

local guidance(region_code, isProxy) = (
  if region_code == 'GB-WLS' then
    if isProxy then walesGuidanceProxy else walesGuidanceNonProxy
  else if isProxy then englandGuidanceProxy else englandGuidanceNonProxy
);

local question(region_code, isProxy) = (
  local questionDescription = if region_code == 'GB-WLS' then walesQuestionDescription else englandQuestionDescription;
  local regionOptions = if region_code == 'GB-WLS' then walesOption else [];
  {
    id: 'a-level-question',
    title: if isProxy then proxyTitle else nonProxyTitle,
    description: questionDescription,
    definitions: [{
      title: 'What we mean by “AS and A level”',
      contents: [
        { description: paragraph }
        for paragraph in guidance(region_code, isProxy)
      ],
    }],
    type: 'MutuallyExclusive',
    mandatory: false,
    answers: [
      {
        id: 'a-level-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: '2 or more A levels',
            value: '2 or more A levels',
            description: 'Include 4 or more AS levels',
          },
          {
            label: '1 A level',
            value: '1 A level',
            description: 'Include 2 to 3 AS levels',
          },
          {
            label: '1 AS level',
            value: '1 AS level',
          },
        ] + regionOptions,
      },
      {
        id: 'a-level-answer-exclusive',
        type: 'Checkbox',
        mandatory: false,
        options: [
          {
            label: 'None of these apply',
            value: 'None of these apply',
            description: 'Questions on GCSEs and equivalents will follow',
          },
        ],
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'a-level',
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
