local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'Have you achieved a GCSE or equivalent qualification?';
local proxyTitle = {
  text: 'Has <em>{person_name}</em> achieved a GCSE or equivalent qualification?',
  placeholders: [
    placeholders.personName,
  ],
};

local englandQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside England and Wales';
local walesQuestionDescription = 'This could be equivalent qualifications achieved anywhere outside Wales and England';

local englandGuidanceList = [
  'This is a General Certificate of Secondary Education. GCSEs are subject based. Students in England and Wales usually complete GCSEs at school by the age of 16 years.',
  'If they have achieved CSEs, O levels or any other similar qualifications outside of England and Wales, choose the options they think are the closest match.',
];
local walesGuidanceList = [
  'This is a General Certificate of Secondary Education. GCSEs are subject based. Students in Wales and England usually complete GCSEs at school by the age of 16 years.',
  'If you have achieved CSEs, O levels or any other similar qualifications outside of Wales and England, choose the options you think are the closest match.',
];

local walesOptions = [
  {
    label: 'Intermediate or National Welsh Baccalaureate',
    value: 'Intermediate or National Welsh Baccalaureate',
  },
  {
    label: 'Foundation Welsh Baccalaureate',
    value: 'Foundation Welsh Baccalaureate',
  },
];

local question(title, region_code) = (
  local regionGuidanceList = if region_code == 'GB-WLS' then walesGuidanceList else englandGuidanceList;
  local questionDescription = if region_code == 'GB-WLS' then walesQuestionDescription else englandQuestionDescription;
  local regionOptions = if region_code == 'GB-WLS' then walesOptions else [];
  {
    id: 'gcse-question',
    title: title,
    description: questionDescription,
    type: 'MutuallyExclusive',
    mandatory: false,
    guidance: {
      contents: [
        {
          list: regionGuidanceList,
        },
      ],
    },
    answers: [
      {
        id: 'gcse-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: '5 or more GCSEs grades A* to C or 9 to 4',
            value: '5 or more GCSEs grades A* to C or 9 to 4',
            description: 'Include 5 or more O level passes or CSEs grades 1',
          },
          {
            label: 'Any other GCSEs',
            value: 'Any other GCSEs',
            description: 'Include any other O levels or CSEs at any grades',
          },
          {
            label: 'Basic Skills course',
            value: 'Basic Skills course',
            description: 'Skills for life, literacy, numeracy and language',
          },
        ] + regionOptions,
      },
      {
        id: 'gcse-answer-exclusive',
        type: 'Checkbox',
        mandatory: false,
        options: [
          {
            label: 'None of these apply',
            value: 'None of these apply',
          },
        ],
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'gcse',
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
  routing_rules: [
    {
      goto: {
        group: 'employment-group',
        when: [
          {
            id: 'degree-answer',
            condition: 'equals',
            value: 'Yes',
          },
        ],
      },
    },
    {
      goto: {
        group: 'employment-group',
        when: [
          {
            id: 'gcse-answer',
            condition: 'set',
          },
        ],
      },
    },
    {
      goto: {
        group: 'employment-group',
        when: [
          {
            id: 'a-level-answer',
            condition: 'set',
          },
        ],
      },
    },
    {
      goto: {
        group: 'employment-group',
        when: [
          {
            id: 'nvq-level-answer',
            condition: 'set',
          },
        ],
      },
    },
    {
      goto: {
        group: 'employment-group',
        when: [
          {
            id: 'apprenticeship-answer',
            condition: 'equals',
            value: 'Yes',
          },
        ],
      },
    },
    {
      goto: {
        block: 'other-qualifications',
      },
    },
  ],
}
