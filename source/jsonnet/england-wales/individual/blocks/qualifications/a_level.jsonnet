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

local englandGuidance = 'These are advanced-level, subject-based qualifications that are often needed to get a place at university. Students in \nEngland and Wales usually complete AS levels by the age of 17 years and A levels by the age of 18 years.\n\nIf they have achieved similar qualifications outside of England and Wales, choose the options they think are \nthe closest match.\n\nAn International Baccalaureate diploma is equivalent to three A levels.';

local walesGuidance = 'These are advanced-level, subject-based qualifications that are often needed to get a place at university. Students in \nWales and England usually complete AS levels by the age of 17 years and A levels by the age of 18 years.\n\nIf you have achieved similar qualifications outside of Wales and England, choose the options you think are\nthe closest match.\n\nAn International Baccalaureate diploma is equivalent to three A levels.';

local walesOption = [{
  label: 'Advanced Welsh Baccalaureate',
  value: 'Advanced Welsh Baccalaureate',
}];

local question(title, region_code) = (
  local regionGuidance = if region_code == 'GB-WLS' then walesGuidance else englandGuidance;
  local questionDescription = if region_code == 'GB-WLS' then walesQuestionDescription else englandQuestionDescription;
  local regionOptions = if region_code == 'GB-WLS' then walesOption else [];
  {
    id: 'a-level-question',
    title: title,
    description: questionDescription,
    guidance: {
      title: 'What we mean by “AS and A level”',
      contents: [
        {
          description: regionGuidance,
        },
      ],
    },
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
      question: question(nonProxyTitle, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, region_code),
      when: [rules.isProxy],
    },
  ],
}
