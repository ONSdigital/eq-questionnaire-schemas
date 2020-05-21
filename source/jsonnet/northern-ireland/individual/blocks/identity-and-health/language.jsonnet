local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your main language?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> main language?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local nonProxyDefinitionDescription = 'Main language is your first or preferred language.';
local proxyDefinitionDescription = 'Main language is their first or preferred language.';

local question(title, definitionDescription) = {
  id: 'language-question',
  title: title,
  type: 'General',
  definitions: [{
    title: 'What we mean by “main language”',
    contents: [
      {
        description: definitionDescription,
      },
    ],
  }],
  answers: [
    {
      id: 'language-answer',
      mandatory: false,
      type: 'Radio',
      options: [
        {
          label: 'English',
          value: 'English',
        },
        {
          label: 'Other, including British or Irish Sign Language',
          value: 'Other, including British or Irish Sign Language',
          description: 'You can enter your main language on the next question',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'language',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDefinitionDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDefinitionDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'language-other',
        when: [
          {
            id: 'language-answer',
            condition: 'equals',
            value: 'Other, including British or Irish Sign Language',
          },
        ],
      },
    },
    {
      goto: {
        block: 'understand-irish',
        when: [
          {
            id: 'language-answer',
            condition: 'equals',
            value: 'English',
          },
        ],
      },
    },
    {
      goto: {
        block: 'english',
      },
    },
  ],
}
