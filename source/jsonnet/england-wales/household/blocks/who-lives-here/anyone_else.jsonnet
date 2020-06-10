local rules = import '../../../lib/common_rules.libsonnet';
local placeholders = import '../../lib/placeholders.libsonnet';

local questionTitle(hasPrimary) = (
  if hasPrimary then {
    text: 'Do any of the following people also live at {household_address} on Sunday {census_date}?',
    placeholders: [
      placeholders.address,
      placeholders.censusDate,
    ],
  } else {
    text: 'Do any of the following people live at {household_address} on Sunday {census_date}?',
    placeholders: [
      placeholders.address,
      placeholders.censusDate,
    ],
  }
);

local anyoneElseAnswerExclusiveText(hasPrimary) = (
  if hasPrimary then {
    label: 'None of these apply, I am the only person who usually lives here',
    value: 'None of these apply, I am the only person who usually lives here',
  } else {
    label: 'None of these apply, no-one usually lives here',
    value: 'None of these apply, no-one usually lives here',
    description: 'For example, this is a second address or holiday home',
  }
);

local question(hasPrimary) = {
  type: 'MutuallyExclusive',
  id: 'anyone-else-driving-question',
  title: questionTitle(hasPrimary),
  definitions: [
    {
      title: 'Who to include',
      contents: [
        { description: 'This is often their permanent or family home.' },
        {
          description: {
            text: 'If someone has more than one home address, include them at this address if they generally spend most of their time here. For example, children whose parents live apart. If they split their time equally then include them at this address if they are staying overnight on Sunday {census_date}.',
            placeholders: [
              placeholders.censusDate,
            ],
          },
        },
        {
          description: 'Remember to include',
        },
        {
          list: [
            '<strong>students</strong>, if this is either their term-time <strong>or</strong> their out of term-time address',
            '<strong>people with a second address for work</strong>, if this is their home address',
            '<strong>armed forces members</strong>, if this is their home address',
          ],
        },

      ],
    },
  ],
  mandatory: true,
  answers: [
    {
      label: 'Select all that apply. You can select more than one for each person',
      id: 'anyone-else-driving-question-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'Family members and partners',
          value: 'Family members and partners',
          description: {
            text: 'Include babies born on or before {census_date}, children, students and schoolchildren who live away from home during term time',
            placeholders: [
              placeholders.censusDate,
            ],
          },
          action: {
            type: 'RedirectToListAddQuestion',
            params: {
              block_id: 'add-person',
              list_name: 'household',
            },
          },
        },
        {
          label: 'Housemates, tenants or lodgers',
          value: 'Housemates, tenants or lodgers',
          action: {
            type: 'RedirectToListAddQuestion',
            params: {
              block_id: 'add-person',
              list_name: 'household',
            },
          },
        },
        {
          label: 'People who usually live outside the UK who are staying in the UK for 3 months or more',
          value: 'People who usually live outside the UK who are staying in the UK for 3 months or more',
          action: {
            type: 'RedirectToListAddQuestion',
            params: {
              block_id: 'add-person',
              list_name: 'household',
            },
          },
        },
        {
          label: 'People temporarily away',
          value: 'People temporarily away',
          description: 'For example, working away, on holiday, in the armed forces, living in an establishment such as a care home for up to 6 months, abroad for up to a year',
          action: {
            type: 'RedirectToListAddQuestion',
            params: {
              block_id: 'add-person',
              list_name: 'household',
            },
          },
        },
        {
          label: 'People staying temporarily who usually live in the UK but do not have another UK address',
          value: 'People staying temporarily who usually live in the UK but do not have another UK address',
          description: 'For example, UK residents between addresses or currently without a home',
          action: {
            type: 'RedirectToListAddQuestion',
            params: {
              block_id: 'add-person',
              list_name: 'household',
            },
          },
        },
      ],
    },
    {
      id: 'anyone-else-driving-question-answer-exclusive',
      mandatory: false,
      type: 'Checkbox',
      options: [anyoneElseAnswerExclusiveText(hasPrimary)],
    },
  ],
};

{
  type: 'ListCollectorDrivingQuestion',
  for_list: 'household',
  id: 'anyone-else-driving-question',
  question_variants: [
    {
      question: question(hasPrimary=true),
      when: [rules.hasPrimary],
    },
    {
      question: question(hasPrimary=false),
      when: [rules.hasNoPrimary],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'anyone-else-temp-away-list-collector',
        when: [
          {
            id: 'anyone-else-driving-question-answer-exclusive',
            condition: 'set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'anyone-else-list-collector',
      },
    },
  ],

}
