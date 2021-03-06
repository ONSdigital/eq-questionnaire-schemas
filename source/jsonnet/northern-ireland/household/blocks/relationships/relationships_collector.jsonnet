local placeholders = import '../../../lib/placeholders.libsonnet';
local transforms = import '../../../lib/transforms.libsonnet';
local rules = import 'rules.libsonnet';

local firstPersonPlaceholder = {
  placeholder: 'first_person_name',
  transforms: [transforms.listHasSameNameItems, transforms.formatPersonName()],
};

local secondPersonPlaceholder = {
  placeholder: 'second_person_name',
  transforms: [transforms.listHasSameNameItems, transforms.formatPersonName(source='to_list_item')],
};

local firstPersonNamePossessivePlaceholder = {
  placeholder: 'first_person_name_possessive',
  transforms: [
    transforms.listHasSameNameItems,
    transforms.formatPersonName(),
    transforms.formatPossessive,
  ],
};

local unrelatedQuestionTitle(isPrimary) = (
  if isPrimary then 'Are any of these people related to you?'
  else {
    text: 'Are any of these people related to <em>{person_name}</em>?',
    placeholders: [
      placeholders.personName(includeMiddleNames='if_same_names_exist'),
    ],
  }
);

local unrelatedNoOption(isPrimary) = (
  if isPrimary then {
    label: 'No, none of these people are related to me',
    value: 'No, none of these people are related to me',
    action: {
      type: 'AddUnrelatedRelationships',
    },
  } else {
    label: {
      text: 'No, none of these people are related to {person_name}',
      placeholders: [
        placeholders.personName(includeMiddleNames='if_same_names_exist'),
      ],
    },
    value: 'No, none of these people are related to {person_name}',
    action: {
      type: 'AddUnrelatedRelationships',
    },
  }
);

local unrelatedQuestion(isPrimary) = {
  id: 'related-to-anyone-else-question',
  type: 'General',
  title: unrelatedQuestionTitle(isPrimary),
  guidance: {
    contents: [
      {
        description: 'Remember to include partners, step-parents and stepchildren as related',
      },
    ],
  },
  answers: [
    {
      id: 'related-to-anyone-else-answer',
      mandatory: true,
      type: 'Radio',
      options: [
        {
          label: 'Yes',
          value: 'Yes',
          action: {
            type: 'RemoveUnrelatedRelationships',
          },
        },
        unrelatedNoOption(isPrimary),
      ],
    },
  ],
};


{
  type: 'RelationshipCollector',
  id: 'relationships',
  title: 'Household relationships',
  page_title: 'How Person {list_item_position} is related to Person {to_list_item_position}',
  for_list: 'household',
  question_variants: [
    {
      question: {
        id: 'relationship-question',
        type: 'General',
        title: {
          text: '{second_person_name} is your <em>…</em>',
          placeholders: [secondPersonPlaceholder],
        },
        description: [
          'Complete the sentence by selecting the appropriate relationship.',
        ],
        answers: [
          {
            id: 'relationship-answer',
            mandatory: false,
            type: 'Relationship',
            playback: {
              text: '{second_person_name} is your <em>…</em>',
              placeholders: [secondPersonPlaceholder],
            },
            options: [
              {
                label: 'Husband or wife',
                playback: {
                  text: '{second_person_name} is your <em>husband or wife</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>husband or wife</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Husband or wife',
              },
              {
                label: 'Civil partner',
                playback: {
                  text: '{second_person_name} is your <em>civil partner</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>civil partner</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Civil partner',
              },
              {
                label: 'Partner',
                playback: {
                  text: '{second_person_name} is your <em>partner</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>partner</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Partner',
              },
              {
                label: 'Son or daughter',
                playback: {
                  text: '{second_person_name} is your <em>son or daughter</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>son or daughter</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Son or daughter',
              },
              {
                label: 'Step-child',
                playback: {
                  text: '{second_person_name} is your <em>step-child</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>step-child</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Step-child',
              },
              {
                description: 'Including half-brother or half-sister',
                label: 'Brother or sister',
                playback: {
                  text: '{second_person_name} is your <em>brother or sister</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>brother or sister</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Brother or sister',
              },
              {
                label: 'Step-brother or step-sister',
                playback: {
                  text: '{second_person_name} is your <em>step-brother or step-sister</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>step-brother or step-sister</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Step-brother or step-sister',
              },
              {
                label: 'Mother or father',
                playback: {
                  text: '{second_person_name} is your <em>mother or father</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>mother or father</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Mother or father',
              },
              {
                label: 'Step-mother or step-father',
                playback: {
                  text: '{second_person_name} is your <em>step-mother or step-father</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>step-mother or step-father</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Step-mother or step-father',
              },
              {
                label: 'Grandchild',
                playback: {
                  text: '{second_person_name} is your <em>grandchild</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>grandchild</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Grandchild',
              },
              {
                label: 'Grandparent',
                playback: {
                  text: '{second_person_name} is your <em>grandparent</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>grandparent</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Grandparent',
              },
              {
                label: 'Other relation',
                playback: {
                  text: '{second_person_name} is your <em>other relation</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <em>other relation</em>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Other relation',
              },
              {
                description: 'Including foster child',
                label: 'Unrelated',
                playback: {
                  text: '{second_person_name} is <em>unrelated</em> to you',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is <em>unrelated</em> to you',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Unrelated',
              },
            ],
          },
        ],
      },
      when: [rules.isPrimary],
    },
    {
      question: {
        id: 'relationship-question',
        type: 'General',
        title: {
          text: 'Thinking about {first_person_name}, {second_person_name} is their <em>…</em>',
          placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
        },
        description: [
          'Complete the sentence by selecting the appropriate relationship.',
        ],
        answers: [
          {
            id: 'relationship-answer',
            mandatory: false,
            type: 'Relationship',
            playback: {
              text: '{second_person_name} is {first_person_name_possessive} <em>…</em>',
              placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
            },
            options: [
              {
                label: 'Husband or wife',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>husband or wife</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>husband or wife</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Husband or wife',
              },
              {
                label: 'Civil partner',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>civil partner</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>civil partner</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Civil partner',
              },
              {
                label: 'Partner',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>partner</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>partner</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Partner',
              },
              {
                label: 'Son or daughter',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>son or daughter</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>son or daughter</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Son or daughter',
              },
              {
                label: 'Step-child',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>step-child</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>step-child</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Step-child',
              },
              {
                description: 'Including half-brother or half-sister',
                label: 'Brother or sister',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>brother or sister</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>brother or sister</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Brother or sister',
              },
              {
                label: 'Step-brother or step-sister',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>step-brother or step-sister</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>step-brother or step-sister</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Step-brother or step-sister',
              },
              {
                label: 'Mother or father',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>mother or father</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>mother or father</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Mother or father',
              },
              {
                label: 'Step-mother or step-father',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>step-mother or step-father</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>step-mother or step-father</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Step-mother or step-father',
              },
              {
                label: 'Grandchild',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>grandchild</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>grandchild</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Grandchild',
              },
              {
                label: 'Grandparent',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>grandparent</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>grandparent</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Grandparent',
              },
              {
                label: 'Other relation',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <em>other relation</em>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <em>other relation</em>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Other relation',
              },
              {
                description: 'Including foster child',
                label: 'Unrelated',
                playback: {
                  text: '{second_person_name} is <em>unrelated</em> to {first_person_name}',
                  placeholders: [secondPersonPlaceholder, firstPersonPlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is <em>unrelated</em> to {first_person_name}',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder, firstPersonPlaceholder],
                },
                value: 'Unrelated',
              },
            ],
          },
        ],
      },
      when: [rules.isNotPrimary],
    },
  ],
  unrelated_block: {
    type: 'UnrelatedQuestion',
    id: 'related-to-anyone-else',
    page_title: 'How person {list_item_position} is related to anyone else',
    title: 'Related to anyone else',
    list_summary: {
      for_list: 'household',
      summary: {
        item_title: {
          text: '{person_name}',
          placeholders: [
            placeholders.personName(includeMiddleNames='if_same_names_exist'),
          ],
        },
      },
    },
    question_variants: [
      {
        question: unrelatedQuestion(isPrimary=true),
        when: [rules.isPrimary],
      },
      {
        question: unrelatedQuestion(isPrimary=false),
        when: [rules.isNotPrimary],
      },
    ],
  },
}
