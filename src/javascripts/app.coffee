$ = require("jquery")
React = require("react")
_ = require("underscore")
Backbone = require("backbone")
require("backbone-computed-fields")
Generator = require("./views/generator.coffee")

skillList = [
  {id: 1, name: "Accounting", base: 10}
  {id: 2, name: "Anthropology", base: 0}
  {id: 3, name: "Archaelogy", base: 0}
  {id: 4, name: "Art", base: 5}
  {id: 5, name: "Astronomy", base: 0}
  {id: 6, name: "Bargain", base: 5}
  {id: 7, name: "Biology", base: 0}
  {id: 8, name: "Chemistry", base: 0}
  {id: 9, name: "Climb", base: 40}
  {id: 10, name: "Conceal", base: 15}
  {id: 11, name: "Credit Rating", base: 15}
  {id: 12, name: "Cthulhu Mythos", base: 0}
  {id: 13, name: "Dodge", depends: ["dexterity"], base: (character) -> character.get("dexterity") * 2}
  {id: 14, name: "Drive Auto", base: 20}
  {id: 15, name: "Electrical Repair", base: 10}
  {id: 16, name: "Fast Talk", base: 5}
  {id: 17, name: "First Aid", base: 30}
  {id: 18, name: "Geology", base: 0}
  {id: 19, name: "Hide", base: 10}
  {id: 20, name: "History", base: 20}
  {id: 21, name: "Jump", base: 25}
  {id: 22, name: "Law", base: 5}
  {id: 23, name: "Library Use", base: 25}
  {id: 24, name: "Listen", base: 25}
  {id: 25, name: "Locksmith", base: 0}
  {id: 26, name: "Martial Arts", base: 0}
  {id: 27, name: "Mechanical Repair", base: 20}
  {id: 28, name: "Medicine", base: 5}
  {id: 29, name: "Natural History", base: 10}
  {id: 30, name: "Navigate", base: 10}
  {id: 31, name: "Occult", base: 5}
  {id: 32, name: "Operate Heavy Machinery", base: 0}
  {id: 33, name: "Other Language", base: 0}
  {id: 34, name: "Own Language", depends: ["education"], base: (character) -> character.get("education") * 5}
  {id: 35, name: "Persuade", base: 15}
  {id: 36, name: "Pharmacy", base: 0}
  {id: 37, name: "Photography", base: 10}
  {id: 38, name: "Physics", base: 0}
  {id: 39, name: "Pilot", base: 0}
  {id: 40, name: "Psychoanalysis", base: 0}
  {id: 41, name: "Psychology", base: 5}
  {id: 42, name: "Ride", base: 5}
  {id: 43, name: "Sneak", base: 10}
  {id: 44, name: "Spot Hidden", base: 25}
  {id: 45, name: "Swim", base: 25}
  {id: 46, name: "Throw", base: 25}
  {id: 47, name: "Track", base: 10}
  {id: 48, name: "Axe", base: 20}
  {id: 49, name: "Blackjack", base: 40}
  {id: 50, name: "Club", base: 25}
  {id: 51, name: "Knife", base: 25}
  {id: 52, name: "Sabre", base: 15}
  {id: 53, name: "Sword", base: 20}
  {id: 54, name: "Handgun", base: 20}
  {id: 55, name: "Machine Gun", base: 15}
  {id: 56, name: "Rifle", base: 25}
  {id: 58, name: "Shotgun", base: 30}
  {id: 58, name: "Submachine Gun", base: 15}
  {id: 59, name: "Punch", base: 50}
  {id: 60, name: "Head Butt", base: 10}
  {id: 61, name: "Kick", base: 25}
  {id: 62, name: "Grapple", base: 25}
  {id: 63, name: "Block", base: 0}
  {id: 64, name: "Roping", base: 0}
  {id: 65, name: "Disguise", base: 0}
  {id: 66, name: "Forensics", base: 0}
  {id: 67, name: "Hypnotism", base: 0}
]

occupationsList = [
  {name: "Accountant", skills: ["Accounting", "Credit Rating"]}
  {name: "Film Crew", skills: ["Art", "Climb", "Drive Auto", "Electrical Repair", "Mechanical Repair", "Photography"]}
  {name: "Professional Athlete", skills: ["Block", "Club", "Dodge", "Grapple", "Head Butt", "Jump", "Kick", "Spot Hidden", "Throw"]}
  {name: "Acrobat", skills: ["Bargain", "Climb", "Dodge", "Jump", "Other language", "Throw"]}
  {name: "Film Star", skills: ["Art", "Bargain", "Disguise", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Agency Detective", skills: ["Bargain", "Fast Talk", "Punch", "Grapple", "Handgun", "Hide", "Law", "Library Use", "Persuade", "Psychology", "Sneak", "Track"]}
  {name: "Fireman", skills: ["Axe", "Climb", "Dodge", "First Aid", "Jump", "Roping"]}
  {name: "Prosecuting Attorney", skills: ["Bargain", "Credit Rating", "English", "Fast Talk", "Law", "Library Use", "Persuade", "Psychology"]}
  {name: "Alienist", skills: ["Accounting", "Bargain", "Biology", "Fast Talk", "Hypnotism", "Library Use", "Medicine", "Other Language", "Persuade", "Pharmacy", "Psychoanalysis", "Psychology"]}
  {name: "Flapper", skills: ["Bargain", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Prospector", skills: ["Climb", "First Aid", "Geology", "History", "Jump", "Natural History", "Navigate", "Spot Hidden"]}
  {name: "Ambassador", skills: ["Bargain", "Credit Rating", "English", "Fast Talk", "Other Language", "Persuade"]}
  {name: "Foreign Correspondant", skills: ["Bargain", "Conceal", "Fast Talk", "Hide", "Other Language", "Persuade", "Psychology", "Sneak"]}
  {name: "Protestant Minister", skills: ["Accounting", "Bargain", "Credit Rating", "English", "Library Use", "Persuade", "Psychology"]}
  {name: "Antique Dealer", skills: ["Accounting", "Bargain", "Credit Rating", "Drive Auto", "English", "History", "Library Use", "Navigate", "Other Language", "Persuade"]}
  {name: "Forensic Specialist", skills: ["Chemistry", "Forensics", "Law", "Medicine", "Pharmacy", "Photography", "Spot Hidden"]}
  {name: "Psychologist", skills: ["Account", "Bargain", "Library Use", "Persuade", "Psychoanalysis", "Psychology"]}
  {name: "Architect", skills: ["Accounting", "Art", "Bargain", "Electrical Repair", "Mechanical Repair", "Photography", "Psychology"]}
  {name: "Forensic Surgeon", skills: ["Biology", "Credit Rating", "First Aid", "Forensic Surgery", "Library Use", "Medicine", "Pharmacy"]}
  {name: "Punk", skills: ["Club", "Punch", "Grapple", "Head Butt", "Kick", "Knife", "Pick Pocket", "Throw"]}
  {name: "Aviator", skills: ["Accounting", "Bargain", "Credit Rating", "Electrical Repair", "Listen", "Mechanical Repair", "Navigate", "Parachute", "Pilot", "Spot Hidden"]}
  {name: "Forger/Counterfeiter", skills: ["Accounting", "Art", "Bargain", "Conceal", "Spot Hidden", "Persuade", "Psychology"]}
  {name: "Rabbi", skills: ["English", "Credit Rating", "Hebrew", "History", "Library Use", "Occult", "Other Language", "Persuade", "Psychology"]}
  {name: "Bail Bondsman", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Law", "Persuade", "Psychology"]}
  {name: "Gambler", skills: ["Bargain", "Conceal", "Fast Talk", "Listen", "Persuade", "Psychology", "Spot Hidden"]}
  {name: "Radical", skills: ["Club", "Fast Talk", "Punch", "Grapple", "Handgun", "Head Butt", "Kick", "Other Language", "Persuade", "Psychology"]}
  {name: "Bank Robber", skills: ["Club", "Conceal", "Drive Auto", "Firearms", "Punch", "Grapple", "Head Butt", "Kick", "Knife"]}
  {name: "Gangster", skills: ["Bargain", "Club", "Conceal", "Drive Auto", "Firearms", "Punch", "Grapple", "Head Butt", "Kick", "Knife", "Persuade", "Psychology"]}
  {name: "Radio Announcer", skills: ["Bargain", "Credit Rating", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Barber", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology", "Straight Razor"]}
  {name: "Bartender", skills: ["Accounting", "Club", "Fast Talk", "Punch", "Persuade", "Psychology"]}
  {name: "Golf Pro", skills: ["Bargain", "Club", "Credit Rating", "Persuade", "Psychology", "Spot Hidden"]}
  {name: "Reporter", skills: ["Bargain", "Climb", "Conceal", "Disguise", "English", "Fast Talk", "Hide", "Jump", "Listen", "Persuade", "Psychology", "Sneak", "Spot Hidden"]}
  {name: "Bible Salesman", skills: ["Accounting", "Bargain", "Persuade", "Psychology"]}
  {name: "Gardener/Grave Digger", skills: ["Bargain"]}
  {name: "Researcher", skills: ["Credit Rating", "English", "Library Use"]}
  {name: "Big Game Hunter", skills: ["Bargain", "Firearms", "First Aid", "Hide", "Jump", "Knife", "Listen", "Natural History", "Navigate", "Other Language", "Sneak", "Track"]}
  {name: "Hit Man", skills: ["Bargain", "Club", "Conceal", "Firearms", "Punch", "Grapple", "Head Butt", "Kick", "Knife", "Sneak", "Hide"]}
  {name: "Sailor", skills: ["Climb", "Punch", "Grapple", "Handgun", "Head Butt", "Jump", "Kick", "Navigate", "Rifle", "Swim"]}
  {name: "Book Dealer", skills: ["Accounting", "Bargain", "Credit Rating", "Drive Auto", "English", "History", "Library Use", "Navigate", "Other Language", "Persuade"]}
  {name: "Hobo", skills: ["Bargain", "Climb", "Fast Talk", "Hide", "Jump", "Listen", "Natural History", "Sneak", "Spot Hidden", "Persuade"]}
  {name: "Salesman", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Bookie", skills: ["Accounting", "Bargain", "Conceal", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Hooker", skills: ["Bargain", "Conceal", "Fast Talk", "Hide", "Persuade", "Pick Pocket", "Psychology"]}
  {name: "Bootlegger/Thug", skills: ["Club", "Conceal", "Drive Auto", "Firearms", "Punch", "Grapple", "Head Butt", "Kick", "Knife"]}
  {name: "Secretary", skills: ["Accounting", "Credit Rating", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Bounty Hunter", skills: ["Accounting", "Bargain", "Climb", "Drive Auto", "Electrical Repair", "Fast Talk", "Firearms", "Punch", "Grapple", "Head Butt", "Hide", "Jump", "Kick", "Law", "Persuade", "Psychology", "Sneak"]}
  {name: "Itinerant Preacher", skills: ["Bargain", "English", "Fast Talk", "Hide", "Persuade", "Psychology", "Sneak"]}
  {name: "Shifty Accountant/Lawyer", skills: ["Account", "Bargain", "Credit Rating", "English", "Fast Talk", "Law", "Persuade", "Psychology"]}
  {name: "Boxer/Wrestler", skills: ["Block", "Punch", "Grapple", "Dodge", "Head Butt", "Kick"]}
  {name: "Judge", skills: ["Bargain", "Credit Rating", "English", "Fast Talk", "Law", "Library Use", "Persuade", "Psychology"]}
  {name: "Shopkeeper", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Burglar", skills: ["Climb", "Hide", "Jump", "Locksmith", "Listen", "Sneak", "Spot Hidden"]}
  {name: "Laborer", skills: ["Operate Heavy Machinery"]}
  {name: "Bus Driver/Streetcar Conductor", skills: ["Accounting", "Drive Auto", "Electrical Repair", "Mechanical Repair", "Navigate", "Persuade", "Psychology"]}
  {name: "Librarian", skills: ["Accounting", "English", "Library Use", "Other Language"]}
  {name: "Small Business Owner", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Catholic Priest", skills: ["Accounting", "Bargain", "Credit Rating", "English", "Latin", "Library Use", "Occult", "Other Language", "Persuade", "Psychology"]}
  {name: "Loan Shark", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Smuggler", skills: ["Accounting", "Bargain", "Conceal", "Fast Talk", "Firearms", "Listen", "Navigate", "Other Language", "Persuade", "Pilot Aircraft", "Pilot Boat", "Psychology", "Spot Hidden"]}
  {name: "Charismatic Cult Leader", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Lumberjack", skills: ["Axe", "Bargain", "Block", "Climb", "Punch", "Grapple", "Head Butt", "Kick", "Jump"]}
  {name: "Soldier", skills: ["Bayonet", "Punch", "Grapple", "Head Butt", "Kick", "Knife", "Rifle", "Throw"]}
  {name: "Charter Boat Captain", skills: ["Accounting", "Bargain", "Credit Rating", "First Aid", "Listen", "Natural History", "Navigate", "Persuade", "Pilot Boat", "Spot Hidden"]}
  {name: "Madhouse Attendant", skills: ["Club", "Fast Talk", "First Aid", "Punch", "Grapple", "Head Butt", "Listen", "Persuade", "Psychology", "Sneak"]}
  {name: "Spy", skills: ["Bargain", "Disguise", "Fast Talk", "Firearms", "Hide", "Knife", "Listen", "Other Language", "Persuade", "Psychology", "Sneak", "Spot Hidden"]}
  {name: "Clerk", skills: ["Accounting", "Bargain", "Credit Rating", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Manager/Coach", skills: ["Accounting", "Bargain", "Block", "Dodge", "Fast Talk", "First Aid", "Head Butt", "Kick", "Persuade", "Psychology"]}
  {name: "Stage Actor", skills: ["Art", "Disguise", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Marine", skills: ["Bayonet", "Punch", "Grapple", "Head Butt", "Kick", "Knife", "Rifle", "Throw"]}
  {name: "Stage Hand", skills: ["Art", "English", "Fast Talk", "Disguise", "Persuade", "Psychology"]}
  {name: "Cocktail Waitress", skills: ["Accounting", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Mechanic", skills: ["Art", "Climb", "Electrical Repair", "Mechanical Repair", "Operate Heavy Machinery"]}
  {name: "Stock Broker", skills: ["Accounting", "Bargain", "Credit Rating", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Columnist", skills: ["Bargain", "Credit Rating", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Mercenary", skills: ["Bargain", "Bayonet", "Climb", "Club", "Firearms", "Punch", "Garrotte", "Grapple", "Head Butt", "Hide", "Jump", "Kick", "Knife", "Navigate", "Track", "Sneak", "Swim"]}
  {name: "Executive/Company Officer", skills: ["Accounting", "Bargain", "Credit Rating", "English", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Merchant Marine", skills: ["Anthropology", "Climb", "Electrical Repair", "Jump", "Mechaincal Repair", "Operate Heavy Machinery", "Other Language"]}
  {name: "Student/Intern", skills: ["English", "Library Use", "Art", "Astronomy", "Physics", "Natural History", "Anthropology", "Archeology"]}
  {name: "Con Man", skills: ["Bargain", "Disguise", "Fast Talk", "Listen", "Persuade", "Psychology", "Spot Hidden"]}
  {name: "Military Offier", skills: ["Bargain", "Credit Rating", "Dodge", "Fast Talk", "Punch", "Grapple", "Handgun", "Head Butt", "Hide", "Jump", "Kick", "Navigate", "Persuade", "Psychology", "Sneak"]}
  {name: "Stunt Man", skill: ["Climb", "Disguise", "Dodge", "Drive Auto", "Electrical Repair", "First Aid", "Punch", "Grapple", "Head Butt", "Jump", "Kick", "Mechanical Repair", "Pilot Aircraft", "Pilot Boat", "Ride", "Swim", "Throw"]}
  {name: "Miner", skills: ["Climb", "Geology", "Jump", "Operate Heavy Machinery", "Spot Hidden"]}
  {name: "Surveyor", skills: ["Accounting", "Bargain", "Library Use", "NAtural History", "Navigate", "Photography", "Spot Hidden"]}
  {name: "Missionary", skills: ["Anthropology", "Bargain", "English", "Occult", "Other Language", "Persuade", "Psychology"]}
  {name: "Swimmer/Diver", skills: ["Other Language", "Swim", "Jump", "Kick", "Grapple", "Hide", "Dodge"]}
  {name: "Cowboy", skills: ["Accounting", "Bargain", "Credit Rating", "Drive Auto", "Firearms", "First Aid", "Jump", "Medicine", "Natural History", "Ride", "Rope"]}
  {name: "Mountain Climber", skills: ["Climb", "First Aid", "Jump", "Listen", "Navigate", "Other Language", "Photography", "Roping", "Track"]}
  {name: "Switchboard Operator", skills: ["Credit Rating", "English", "Fast Talk", "Listen", "Persuade", "Psychology"]}
  {name: "Deacon/Elder", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Museum Curator", skills: ["Accounting", "Bargain", "Credit Rating", "English", "Library Use", "Persuade"]}
  {name: "Talent Agent", skills: ["Accounting", "Bargain", "Fast Talk", "Law", "Persuade", "Psychology"]}
  {name: "Deep-Sea Diver", skills: ["Diving", "Mechanical Repair", "Natural History", "Pilot Boat", "Spot Hidden", "Swim"]}
  {name: "Musician, Jazz", skills: ["Art", "Bargain", "Listen", "Persuade", "Psychology"]}
  {name: "Taxi Driver", skills: ["Accounting", "Bargain", "Drive Auto", "Electrical Repair", "Fast Talk", "Mechanical Repair", "Navigate", "Persuade", "Psychology"]}
  {name: "Race Driver", skills: ["Drive Auto", "Electrical Repair", "MEchanical Repair", "Pilot Boat", "Psychology", "Spot Hidden"]}
  {name: "Dentist", skills: ["Accounting", "Bargain", "Credit Rating", "First Aid", "Library Use", "Medicine", "Persuade", "Pharmacy", "Psychology"]}
  {name: "Musician, Legitimate", skills: ["Accounting", "Art", "Bargain", "Listen", "Persuade", "Psychology"]}
  {name: "Professor/Teacher", skills: ["Credit Rating", "English", "Library Use", "Persuade"]}
  {name: "Designer", skills: ["Accounting", "Art", "Bargain", "Electrical Repair", "Mechanical Repair", "Photography", "Psychology"]}
  {name: "Nurse", skills: ["Biology", "Credit Rating", "First Aid", "Medicine", "Persuade", "Pharmacy", "Psychology"]}
  {name: "Technician", skills: ["Biology", "Chemistry", "Electrical Repair", "Library Use", "Mechanical Repair", "Medicine", "Pharmacy", "Photography"]}
  {name: "Dilettante", skills: ["Credit Rating"]}
  {name: "Occultist", skills: ["Anthropology", "Electrical Repair", "Hypnotism", "Library Use", "Mechanical Repair", "Occult", "Photography"]}
  {name: "Tennis Pro", skills: ["Bargain", "Club", "Credit Rating", "Dodge", "Jump", "Persuade", "Psychology", "Spot Hidden"]}
  {name: "Orderly", skills: ["Electrical Repair", "Fast Talk", "First Aid", "Mechanical Repair", "Sneak"]}
  {name: "Editor", skills: ["Accounting", "Bargain", "Credit Rating", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Painter/Sculptor", skills: ["Art", "Bargain", "History", "Library Use", "Persuade", "Photography", "Psychology"]}
  {name: "Track and Field", skills: ["Climb", "Dodge", "Jump", "Other Language", "Throw"]}
  {name: "Parapsychologist", skills: ["Accounting", "Bargain", "Library Use", "Natural History", "Navigate", "Photography", "Spot Hidden"]}
  {name: "Trainer", skills: ["Fast Talk", "First Aid", "Medicine", "Persuade", "Pharmacy", "Psychology"]}
  {name: "Elected Official", skills: ["Bargain", "Credit Rating", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Pharmacist", skills: ["Accounting", "Bargain", "Biology", "Credit Rating", "English", "First Aid", "Latin", "Library Use", "Pharmacy", "Persuade", "Psychology"]}
  {name: "Traveling Salesman", skills: ["Accounting", "Bargain", "Drive Auto", "Fast Talk", "Navigate", "Persuade", "Psychology"]}
  {name: "Entertainer", skills: ["Art", "Disguise", "English", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Photographer", skills: ["Accounting", "Chemistry", "Photography", "Persuade", "Physics", "Psychology"]}
  {name: "Treasure Hunter", skills: ["Bargain", "Climb", "Drive Auto", "Electrical Repair", "History", "Jump", "Mechanical Repair", "Persuade", "Pilot Aircraft", "Pilot Boat", "Spot Hidden"]}
  {name: "Photojournalist", skills: ["Climb", "Bargain", "English", "Fast Talk", "Jump", "Other Language", "Persuade", "Photography", "Psychology"]}
  {name: "Undertaker", skills: ["Accounting", "Bargain", "Biology", "Credit Rating", "Persuade", "Psychology"]}
  {name: "Explorer", skills: ["Climb", "Dodge", "Firearms", "First Aid", "History", "Jump", "Medicine", "Natural History", "Navigate", "Other Language", "Photography", "Swim"]}
  {name: "Physician", skills: ["Accounting", "Bargain", "Biology", "Credit Rating", "First Aid", "LAtin", "Library Use", "Medicine", "Persuade", "Pharmacy", "Psychoanalysis", "Psychology"]}
  {name: "Uniformed Police Officer", skills: ["Club", "Drive Auto", "Firearms", "Punch", "Grapple", "Kick", "Law", "Persuade", "Track"]}
  {name: "Pick Pocket", skills: ["Conceal", "Fast Talk", "Hide", "Listen", "Pick Pocket", "Sneak", "Spot Hidden"]}
  {name: "Union Activist", skills: ["Accounting", "Bargain", "Club", "Conceal", "English", "Fast Talk", "Punch", "Grapple", "Head Butt", "Kick", "Law", "Operate Heavy Machinery", "Persuade", "Psychology"]}
  {name: "Farmer/Farm Hand", skills: ["Accounting", "Axe", "Bargain", "Climb", "Credit Rating", "Drive Auto", "Electrical Repair", "First Aid", "Jump", "Mechanical Repair", "Medicine", "Natural History", "Operate Heavy Machinery"]}
  {name: "Plastic Surgeon", skills: ["Accounting", "Bargain", "Biology", "Credit Rating", "First Aid", "Latin", "Library Use", "Medicine", "Pharmacy", "Persuade", "Psychology"]}
  {name: "Western Lawman", skills: ["Drive Auto", "Firearms", "Punch", "Grapple", "Head Butt", "Kick", "Law", "Persuade", "Psychology", "Ride", "Rope", "Track"]}
  {name: "Federal Agent", skills: ["Bargain", "Drive Auto", "Fast Talk", "Firearms", "Punch", "Forensics", "Grapple", "Hide", "Law", "Persuade", "Sneak" ,"Spot Hidden" ,"Track"]}
  {name: "Police Detective", skills: ["Bargain", "Drive Auto", "Fast Talk", "Forensics", "Handgun", "Law", "Listen", "Persuade", "Psychology", "Spot Hidden", "Track"]}
  {name: "Fence", skills: ["Accounting", "Bargain", "Conceal", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Political Boss", skills: ["Accounting", "Bargain", "Credit Rating", "Fast Talk", "Persuade", "Psychology"]}
  {name: "Writer", skills: ["Art", "English", "Fast Talk", "Library Use", "Other Language", "Persuade", "Psychology"]}
  {name: "Field Researcher", skills: ["Accounting", "Bargain", "Climb", "Credit Rating", "First Aid", "Jump", "Library Use", "Other Language", "Persuade"]}
  {name: "Practicing Attorney", skills: ["Accounting", "Bargain", "Credit Rating", "English", "Fast Talk", "Law", "Library Use", "Persuade", "Psychology"]}
  {name: "Zookeeper", skills: ["Accounting", "Biology", "First Aid", "Natural History", "Medicine", "Pharmacy"]}
  {name: "Private Eye", skills: ["Accounting", "Bargain", "Climb", "Disguise", "Drive Auto", "Fast Talk", "Punch", "Forensics", "Grapple", "Head Butt", "Hide", "Jump", "Kick", "Law", "Library Use", "Persuade", "Sneak", "Swim", "Track"]}
  {name: "Copywriter", skills: ["English", "Fast Talk", "Listen", "Persuade", "Psychology"]}
]


Characters = require("./collections/characters.coffee")
Occupations = require("./collections/occupations.coffee")
Skills = require("./collections/skills.coffee")
skills = new Skills(skillList)

generator = Generator
  character: Characters.generateRandom()
  skills: skills
  occupations: new Occupations(occupationsList.map((occupation, i) ->
    occupationSkills = []
    if occupation.skills
      for skillName in occupation.skills
        skill = skills.findWhere(name: skillName)
        occupationSkills.push(skill.id) if skill
    _.extend occupation, id: i, skills: occupationSkills
  ))

React.renderComponent generator, $('body').get(0)
