local common_rules = import '../../lib/common_rules.libsonnet';

{
  isNotProxy: {
    id: 'confirm-who-is-answering-answer',
    condition: 'equals',
    value: 'For myself',
  },
  isProxy: {
    id: 'confirm-who-is-answering-answer',
    condition: 'equals',
    value: 'For someone else',
  },
} + common_rules
