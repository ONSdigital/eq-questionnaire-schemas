local placeholders = import '../../../lib/placeholders.libsonnet';
local transforms = import '../../../lib/transforms.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle = {
  text_plural: {
    forms: {
      one: 'You said {cardinality} person lives at {household_address}. Do you need to add anyone?',
      other: 'You said {cardinality} people live at {household_address}. Do you need to add anyone?',
    },
    count: {
      source: 'list',
      identifier: 'household',
    },
  },
  placeholders: [
    placeholders.address,
    placeholders.getListCardinality('household'),
  ],
};

local primaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em> (You)',
  placeholders: [
    placeholders.personName([transforms.listHasSameNameItems, transforms.formatFirstPersonName]),
  ],
};

local nonPrimaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em>',
  placeholders: [
    placeholders.personName([transforms.listHasSameNameItems, transforms.formatFirstPersonName]),
  ],
};

local editQuestion(questionTitle) = {
  id: 'any-more-people-living-here-edit-person-question',
  type: 'General',
  title: questionTitle,
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a first name',
        },
      },
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
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a last name',
        },
      },
    },
  ],
};

local addMorePeopleLivingHereTitle(listIsEmpty) = (
  if listIsEmpty then {
    text: 'Who lives at {household_address}?',
    placeholders: [
      placeholders.address,
    ],
  } else {
    text: 'Who else lives at {household_address}?',
    placeholders: [
      placeholders.address,
    ],
  }
);

local addMorePeopleLivingHere(listIsEmpty) = {
  id: 'any-more-people-living-here-add-person-question',
  type: 'General',
  title: addMorePeopleLivingHereTitle(listIsEmpty),
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a first name',
        },
      },
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
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a last name',
        },
      },
    },
  ],
};

{
  id: 'any-more-people-living-here',
  type: 'ListCollector',
  for_list: 'household',
  same_name_answer_ids: ['first-name', 'last-name'],
  page_title: 'Any more people living here',
  question: {
    id: 'any-more-people-living-here-question',
    type: 'General',
    title: questionTitle,
    guidance: {
      contents: [
        {
          title: '<p>Remember to include people who are</p>',
        },
        {
          title: 'Temporarily away',
        },
        {
          list: [
            'people who work away from home within the UK if this is their permanent or family home',
            'members of the armed forces if this is their permanent or family home',
            'people who are temporarily outside the UK for <strong>less than 12 months</strong>',
            'people staying, or expecting to stay, in an establishment such as a hospital, care home or hostel for <strong>less than 6 months</strong>',
            'other people who usually live here but are temporarily away from home',
          ],
        },
        {
          title: 'Temporarily staying',
        },
        {
          list: [
            'people staying temporarily who usually live in the UK but do not have another UK address for example, relatives, friends',
            'people who usually live outside the UK who are staying in the UK for <strong>3 months or more</strong>',
          ],
        },
      ],
    },
    answers: [
      {
        id: 'any-more-people-living-here-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes, I need to add someone',
            value: 'Yes, I need to add someone',
            action: {
              type: 'RedirectToListAddBlock',
            },
          },
          {
            label: {
              text_plural: {
                forms: {
                  one: 'No, there is {cardinality} person living here',
                  other: 'No, there are {cardinality} people living here',
                },
                count: {
                  source: 'list',
                  identifier: 'household',
                },
              },
              placeholders: [
                placeholders.getListCardinality('household'),
              ],
            },
            value: 'No, I do not need to add anyone',
          },
        ],
        guidance: {
          show_guidance: 'Why we ask this question',
          hide_guidance: 'Why we ask this question',
          contents: [
            {
              description: 'We ask this question to ensure that everyone is correctly counted in the census. This includes people who are staying temporarily or are away.',
            },
            {
              description: 'The information is vital for planning services, whether it is for hospital beds, school places, GP and dental services or where to build houses and roads.',
            },
          ],
        },
      },
    ],
  },
  add_block: {
    id: 'any-more-people-living-here-add-person',
    page_title: 'Add name of Person {list_item_position}',
    type: 'ListAddQuestion',
    question_variants: [
      {
        question: addMorePeopleLivingHere(listIsEmpty=false),
        when: [rules.listIsNotEmpty('household')],
      },
      {
        question: addMorePeopleLivingHere(listIsEmpty=true),
        when: [rules.listIsEmpty('household')],
      },
    ],
  },
  edit_block: {
    id: 'any-more-people-living-here-edit-person',
    page_title: 'Change details for Person {list_item_position}',
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
    id: 'any-more-people-living-here-remove-person',
    page_title: 'Remove Person {list_item_position}',
    type: 'ListRemoveQuestion',
    question: {
      id: 'any-more-people-living-here-remove-person-question',
      type: 'General',
      title: {
        text: 'Are you sure you want to remove <em>{person_name}</em>?',
        placeholders: [
          placeholders.personName([transforms.listHasSameNameItems, transforms.formatFirstPersonName]),
        ],
      },
      warning: 'All of the information entered about this person will be deleted',
      answers: [
        {
          id: 'any-more-people-living-here-remove-person-answer',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes, I want to remove this person',
              value: 'Yes, I want to remove this person',
              action: {
                type: 'RemoveListItemAndAnswers',
              },
            },
            {
              label: 'No, I don‘t want to remove this person',
              value: 'No, I don‘t want to remove this person',
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
        placeholders.personName(transforms.listHasSameNameItems),
      ],
    },
  },
}
