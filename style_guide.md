# Jsonnet Style Guide
This style guide documents how we build schemas consistently with Jsonnet. For more general principles and styling rules, we follow the [Databricks Style Guide](https://github.com/databricks/jsonnet-style-guide#databricks-jsonnet-guide).
## Folder structure
- The following structure is used:

    ```
    england-wales/
       lib/
          common_rules.libsonnet
          placeholders.libsonnet
       <questionnaire>/
          <questionniare>.jsonnet
          lib/
             rules.libsonnet
          blocks/
             <section-one>/
                <block-one>.jsonnet
                <block-two>.jsonnet
             <section-two>/
    northern-ireland/   
    ```
- Jsonnet source files are separated into two top-level folders - `england-wales` and `northern-ireland` 
  - The file extension should be `.libsonnet`
  - Each file is grouped by function, currently `common_rules` and `placeholders`
- Each questionnaire has it's own folder, within this:
  - A top-level questionnaire definition Jsonnet file 
  - A `lib/` folder holds common Jsonnet used across multiple blocks
    - The file extension should be `.libsonnet`
    - Each file here can extend common Jsonnet from the questionnaire level lib folder
    - `rules.libsonnet` extends the top level `lib/common_rules.libsonnet`
  - A `blocks` folder:
    - Subdivided into section folders
    - Within each section folder a Jsonnet file per block
  
- We currently have the following questionnaires:

    - `ccs`
    - `communal-establishment`
    - `household`
    - `individual`

- Blocks from the `individual` questionnaire are also used in the `household` questionnaire.

## Global variables

- Global variables are variables known at questionnaire launch. They don't change during the completion of a questionnaire.
- Top-level arguments (`--tla-str`) should be used to pass variables that are used in 5 blocks or less.
- External variables (`--ext-str`) should be used to pass variables that are used in more than 5 blocks.
  - External variables are used for `census_date` and `region_code`.
  - Example of an external variable in `answers`:
    
      ```javascript
      answers: [
        {
          id: 'date-of-birth-answer',
          mandatory: true,
          type: 'Date',
          minimum: {
            value: std.extVar('census_date'),
            offset_by: {
              years: -115,
              months: -2,
              days: -20,
            },
          },
          maximum: {
            value: 'now',
          },
        },
      ],
      ``` 

- Region Code
    - Depending on its value, a different questionnaire structure can be generated. For example, extra questions in the Wales questionnaire.
    - Also used to vary content. For example:
      ```javascript
      local radioOption = (
        if std.extVar('region_code') == 'GB-WLS' then 'Wales description'
        else 'England description';
      );
      ```


## Blocks

- There are two distinct styles of block JSON:
  - Simple (no variants):
  
    ```javascript
    // Imports
    
    {
      // Block JSON
    }
    ```

  - Variants:
    ```javascript
    // Imports
    
    // Variant helper methods
    local questionTitle(variantParam) = (
      // Variables relevant to this method
      // Return relevant string or JSON object
    );
    
    // Main variant method - 'question' or 'content'
    local question(variantParam) = {
      // Variant JSON
    };
    
    {
      // Block JSON
    }
    ```

- Block JSON can be a function if an argument is being passed:

    ```javascript
    function(census_month_year_date) {
      type: 'Question',
      id: 'arrive-in-country',
      question_variants: [
        {
          question: question(isProxy=false),
          when: [rules.isNotProxy],
        },
        {
          question: question(isProxy=true),
          when: [rules.isProxy],
        },
      ],
    } 
    ```
  
### Variants

- When the value of a property needs to vary, a method should be defined that returns an appropriate value.
- A method should not be used if the value is fixed i.e. doesn’t change based on a variable.

#### Single value variants example
- The most common approach in census schemas is to create variants based on a value of a single variable:
    ```javascript
    local questionTitle(isProxy) = (
      if isProxy then 
        {
          text: 'What was <em>{person_name_possessive}</em> age on their last birthday?',
          placeholders: [
            placeholders.personNamePossessive,
        ]} 
      else 'What was your age on your last birthday?';
    );

    local question(isProxy) = {
      title: questionTitle(isProxy)
      id: 'confirm-date-of-birth',
      title: title,
      type: 'General',
      answers: [
      {
        id: 'confirm-date-of-birth-answer',
        mandatory: true,
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
        type: 'Radio',
        },
      ],
    };
    
    {
      type: 'Question',
      id: 'confirm_dob',
      question_variants: [
        {
          question: question(isProxy=false),
          when: [rules.isNotProxy],
        },
        {
          question: question(isProxy=true),
          when: [rules.isProxy],
        },
      ],
    }
    ```
- The `isProxy` variable is passed to the `question` method.
- The `question` method calls `questionTitle(isProxy)` to resolve the question title.
- `questionTitle` returns the appropriate JSON for title.

- The same rules apply to other properties, e.g. question guidance would be:
    ```javascript
    local questionGuidance(isProxy) = (
      if isProxy then 
        'Why we ask this question if they are retired or long-term sick or disabled' 
      else 'Why we ask this question if you are retired or long-term sick or disabled';
    );
    ```
#### Multiple value variants example

- There are occasions where more than one variable is used to create variants. For example:

    ```javascript
    local questionTitle(isProxy, isEmployed) = (
      if isEmployed then (
        if isProxy then 
          {
            text: 'What is the main activity of <em>{person_name_possessive}</em> organisation, business or freelance work?',
            placeholders: [
              placeholders.personNamePossessive,
            ]
          }
        else 'What is the main activity of your organisation, business or freelance work?'
      ) else (
        if isProxy then 
          {
            text: 'What was the main activity of <em>{person_name_possessive}</em> organisation, business or freelance work?',
            placeholders: [
              placeholders.personNamePossessive,
            ]
          }
        else 'What was the main activity of your organisation, business or freelance work?';
      )
    );

    local question(isProxy, isEmployed) = {
      id: 'business-name-question',
      title: questionTitle(isProxy, isEmployed),
      description: description,
      type: 'MutuallyExclusive',
      mandatory: false,
      answers: [
        {
          id: 'business-name-answer',
          label: 'Organisation or business name',
          max_length: 160,
          mandatory: false,
          type: 'TextField',
        },
        {
          id: 'no-business-name-answer',
          mandatory: false,
          type: 'Checkbox',
          options: [
            {
              label: option,
              value: option,
            },
          ],
        },
      ],
    };

    {
      type: 'Question',
      id: 'business-name',
      question_variants: [
        {
          question: question(isProxy=false, isEmployed=true),
          when: [rules.isNotProxy, rules.isEmployed],
        },
        {
          question: question(isProxy=true, isEmployed=true),
          when: [rules.isProxy, rules.isEmployed],
        },
        {
          question: question(isProxy=false, isEmployed=false),
          when: [rules.isNotProxy, rules.isNotEmployed],
        },
        {
          question: question(isProxy=true, isEmployed=false),
          when: [rules.isProxy, rules.isNotEmployed],
        },
      ],
    };
    ```
- The `isProxy` and `isEmployed` variables are passed to the `question` method.
- The `question` method calls `questionTitle(isProxy, isEmployed)` to resolve the question title.
- `questionTitle` returns the appropriate JSON for title.

### Routing

- Every block must have a routing rule, even if the succeeding block is the target. This makes the rules easier to understand.
