local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your ethnic group?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> ethnic group?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local englandDescription = 'Includes British, Northern Irish, Irish, Gypsy, Irish Traveller, Roma or any other White background';
local walesDescription = 'Includes Welsh, British, Northern Irish, Irish, Gypsy, Irish Traveller, Roma or any other White background';

local englandAsianEthnicityLabel = 'Asian or Asian British';
local walesAsianEthnicityLabel = 'Asian, Asian Welsh or Asian British';

local englandBlackEthnicityLabel = 'Black, Black British, Caribbean or African';
local walesBlackEthnicityLabel = 'Black, Black Welsh, Black British, Caribbean or African';

local englandAsianEthnicityRoutingRule = {
  block: 'asian-or-asian-british-ethnic-group',
  when: [
    {
      id: 'ethnic-group-answer',
      condition: 'equals any',
      values: [englandAsianEthnicityLabel],
    },
  ],
};

local walesAsianEthnicityRoutingRule = {
  block: 'asian-or-asian-british-ethnic-group',
  when: [
    {
      id: 'ethnic-group-answer',
      condition: 'equals any',
      values: [walesAsianEthnicityLabel],
    },
  ],
};

local englandBlackEthnicityRoutingRule = {
  block: 'black-black-british-caribbean-or-african-ethnic-group',
  when: [
    {
      id: 'ethnic-group-answer',
      condition: 'equals any',
      values: [englandBlackEthnicityLabel],
    },
  ],
};

local walesBlackEthnicityRoutingRule = {
  block: 'black-black-british-caribbean-or-african-ethnic-group',
  when: [
    {
      id: 'ethnic-group-answer',
      condition: 'equals any',
      values: [walesBlackEthnicityLabel],
    },
  ],
};

local question(title, guidance, description, region_code) = (
  local regionDescription = if region_code == 'GB-WLS' then walesDescription else englandDescription;
  local asianEthnicityLabel = if region_code == 'GB-WLS' then walesAsianEthnicityLabel else englandAsianEthnicityLabel;
  local blackEthnicityLabel = if region_code == 'GB-WLS' then walesBlackEthnicityLabel else englandBlackEthnicityLabel;
  {
    id: 'ethnic-group-question',
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
        id: 'ethnic-group-answer',
        mandatory: false,
        options: [
          {
            label: 'White',
            value: 'White',
            description: regionDescription,
          },
          {
            label: 'Mixed or Multiple ethnic groups',
            value: 'Mixed or Multiple ethnic groups',
            description: 'Includes White and Black Caribbean, White and Black African, White and Asian or any other Mixed or Multiple background',
          },
          {
            label: asianEthnicityLabel,
            value: asianEthnicityLabel,
            description: 'Includes Indian, Pakistani, Bangladeshi, Chinese or any other Asian background',
          },
          {
            label: blackEthnicityLabel,
            value: blackEthnicityLabel,
            description: 'Includes Black British, Caribbean, African or any other Black background',
          },
          {
            label: 'Other ethnic group',
            value: 'Other ethnic group',
            description: 'Includes Arab or any other ethnic group',
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

function(region_code) (
  local asianEthnicityRoutingRule = if region_code == 'GB-WLS' then walesAsianEthnicityRoutingRule else englandAsianEthnicityRoutingRule;
  local blackEthnicityRoutingRule = if region_code == 'GB-WLS' then walesBlackEthnicityRoutingRule else englandBlackEthnicityRoutingRule;
  {
    type: 'Question',
    id: 'ethnic-group',
    page_title: 'Ethnic group',
    question_variants: [
      {
        question: question(nonProxyTitle, nonProxyGuidance, nonProxyDescription, region_code),
        when: [rules.isNotProxy],
      },
      {
        question: question(proxyTitle, proxyGuidance, proxyDescription, region_code),
        when: [rules.isProxy],
      },
    ],
    routing_rules: [
      {
        goto: {
          block: 'white-ethnic-group',
          when: [
            {
              id: 'ethnic-group-answer',
              condition: 'equals',
              value: 'White',
            },
          ],
        },
      },
      {
        goto: {
          block: 'mixed-or-multiple-ethnic-group',
          when: [
            {
              id: 'ethnic-group-answer',
              condition: 'equals',
              value: 'Mixed or Multiple ethnic groups',
            },
          ],
        },
      },
      {
        goto: asianEthnicityRoutingRule,
      },
      {
        goto: blackEthnicityRoutingRule,
      },
      {
        goto: {
          block: 'other-ethnic-group',
          when: [
            {
              id: 'ethnic-group-answer',
              condition: 'equals',
              value: 'Other ethnic group',
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
)
