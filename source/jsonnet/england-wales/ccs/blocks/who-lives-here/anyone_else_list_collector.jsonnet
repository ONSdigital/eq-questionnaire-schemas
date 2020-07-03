local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle = {
  text: 'Did anyone else usually live in your household on Sunday {census_date}?',
  placeholders: [
    placeholders.address,
    placeholders.censusDate,
  ],
};

local primaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em> (You)',
  placeholders: [
    placeholders.personName,
  ],
};

local nonPrimaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em>',
  placeholders: [
    placeholders.personName,
  ],
};

local editQuestion(questionTitle) = {
  id: 'edit-question',
  type: 'General',
  title: questionTitle,
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
    },
    {
      id: 'middle-names',
      label: 'Middle names',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'last-name',
      label: 'Last name',
      mandatory: true,
      type: 'TextField',
    },
  ],
};

{
  id: 'anyone-else-list-collector',
  type: 'ListCollector',
  for_list: 'household',
  add_answer: {
    id: 'anyone-else-answer',
    value: 'Yes',
  },
  remove_answer: {
    id: 'remove-confirmation',
    value: 'Yes, I want to remove this person',
  },
  question_variants: [
    {
      question: {
        type: 'General',
        id: 'anyone-usually-live-at-question',
        title: questionTitle,
        description: 'Remember to only include those people who share cooking facilities <strong>and</strong> share a living room, <strong>or</strong> sitting room, <strong>or</strong> dining area.<p><strong>Anyone else is not part of your household and will be interviewed separately.</strong></p>',
        instruction: 'Tell the respondent to turn to <strong>Showcard 2</strong> or show them the Electronic Showcard below',
        definitions: [
          {
            title: 'Electronic Showcard',
            contents: [
              {
                description: 'Include',
              },
              {
                list: [
                  {
                    text: 'family members (including partners, children and babies born on or before {census_date} even if still in hospital)',
                    placeholders: [
                      placeholders.censusDate,
                    ],
                  },
                  'students and schoolchildren who lived away from home during term time ',
                  'housemates, tenants or lodgers',
                  {
                    text: 'people who usually lived here on {census_date} but have since moved out',
                    placeholders: [
                      placeholders.censusDate,
                    ],
                  },
                ],
              },
            ],
          },
        ],
        answers: [
          {
            id: 'anyone-else-answer',
            mandatory: true,
            type: 'Radio',
            options: [
              {
                label: 'Yes',
                value: 'Yes',
              },
              {
                label: 'No',
                value: 'No',
              },
            ],
          },
        ],
      },
      when: [rules.listIsEmpty('household')],
    },
    {
      question: {
        id: 'anyone-usually-live-at-question',
        type: 'General',
        title: {
          text: 'Did anyone else usually live in your household on Sunday {census_date}?',
          placeholders: [
            placeholders.censusDate,
          ],
        },
        description: 'Remember to only include those people who share cooking facilities <strong>and</strong> share a living room, <strong>or</strong> sitting room, <strong>or</strong> dining area.<p><strong>Anyone else is not part of your household and will be interviewed separately.</strong></p>',
        instruction: 'Tell the respondent to turn to <strong>Showcard 2</strong> or show them the Electronic Showcard below',
        definitions: [
          {
            title: 'Electronic Showcard',
            contents: [
              {
                description: 'Include',
              },
              {
                list: [
                  {
                    text: 'family members (including partners, children and babies born on or before {census_date} even if still in hospital)',
                    placeholders: [
                      placeholders.censusDate,
                    ],
                  },
                  'students and schoolchildren who lived away from home during term time ',
                  'housemates, tenants or lodgers',
                  {
                    text: 'people who usually lived here on {census_date} but have since moved out',
                    placeholders: [
                      placeholders.censusDate,
                    ],
                  },
                ],
              },
            ],
          },
        ],
        answers: [
          {
            id: 'anyone-else-answer',
            mandatory: true,
            type: 'Radio',
            options: [
              {
                label: 'Yes',
                value: 'Yes',
              },
              {
                label: 'No',
                value: 'No',
              },
            ],
          },
        ],
      },
      when: [rules.listIsNotEmpty('household')],
    },
  ],
  add_block: {
    id: 'add-person',
    type: 'ListAddQuestion',
    question_variants: [
      {
        question: {
          id: 'add-question',
          type: 'General',
          title: 'What is your full name?',
          answers: [
            {
              id: 'first-name',
              label: 'First name',
              mandatory: true,
              type: 'TextField',
            },
            {
              id: 'middle-names',
              label: 'Middle names',
              mandatory: false,
              type: 'TextField',
            },
            {
              id: 'last-name',
              label: 'Last name',
              mandatory: true,
              type: 'TextField',
            },
          ],
        },
        when: [rules.listIsEmpty('household')],
      },
      {
        question: {
          id: 'add-question',
          type: 'General',
          title: 'Who do you need to add?',
          instruction: 'Enter a full stop (.) if the respondent does not know a person’s “First name” or “Last name”',
          answers: [
            {
              id: 'first-name',
              label: 'First name',
              mandatory: true,
              type: 'TextField',
            },
            {
              id: 'middle-names',
              label: 'Middle names',
              mandatory: false,
              type: 'TextField',
            },
            {
              id: 'last-name',
              label: 'Last name',
              mandatory: true,
              type: 'TextField',
            },
          ],
        },
        when: [rules.listIsNotEmpty('household')],
      },
    ],
  },
  edit_block: {
    id: 'edit-person',
    type: 'ListEditQuestion',
    question_variants: [
      {
        question: editQuestion(primaryEditPersonQuestionTitle),
        when: [rules.isPrimary],
      },
      {
        question: editQuestion(nonPrimaryEditPersonQuestionTitle),
        when: [rules.isNotPrimary],
      },
    ],
  },
  remove_block: {
    id: 'remove-person',
    type: 'ListRemoveQuestion',
    question: {
      id: 'remove-question',
      type: 'General',
      guidance: {
        contents: [{
          title: 'All of the data entered about this person will be deleted',
        }],
      },
      title: {
        text: 'Are you sure you want to remove <em>{person_name}</em>?',
        placeholders: [
          placeholders.personName,
        ],
      },
      answers: [
        {
          id: 'remove-confirmation',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes, I want to remove this person',
              value: 'Yes, I want to remove this person',
            },
            {
              label: 'No, I do not want to remove this person',
              value: 'No, I do not want to remove this person',
            },
          ],
        },
      ],
    },
  },
  summary: {
    title: 'Household members',
    item_title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName,
      ],
    },
  },
}
