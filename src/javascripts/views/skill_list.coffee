{fieldset, legend, ul, li, label, input} = React.DOM

SkillList = React.createClass

  getInitialState: ->
    console.log @props.occupations.get(0)
    occupation = @props.occupations.get @props.character.get("occupation")
    console.log "OCCUPATION", occupation.get("skills")
    occupation: @props.character.get("occupation")
    occupationSkills: occupation.get("skills")

  componentDidMount: ->
    @props.character.on "change:occupation", (character, occupation) =>
      occupation = @props.occupations.get(occupation)
      skills = occupation.get("skills")
      console.log "Occupational skills", skills
      @setState
        occupation: occupation
        occupationSkills: skills

  render: ->
    fieldset className: "generator-column",
      legend {}, "Investigator skills"
      ul {},
        for skill in @props.skills.models
          li {},
            label {},
              input
                type: "checkbox"
                checked: (skill.id in @state.occupationSkills)
                disabled: true
              skill.get("name")
            input(type: "number", min: 0, max: 99, value: skill.get("base"))

module.exports = SkillList
