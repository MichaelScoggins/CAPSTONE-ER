DROP TABLE IF EXISTS usersContact, usersAddress, users, usersCredentials, userProfile, strainProfile, preSession, preSessionToDo, preSessionWorries, activeSession, postSession, postSessionLastingInsights;

CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  PRIMARY KEY (id)
);

CREATE TABLE usersContact (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  phone1 VARCHAR(50),
  phone2 VARCHAR(50),
  email VARCHAR(50),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id)
  REFERENCES users (id)
    ON DELETE CASCADE
);

CREATE TABLE usersAddress (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  address VARCHAR(100),
  city VARCHAR(50),
  county VARCHAR(50),
  state VARCHAR(50),
  zip VARCHAR(50),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id)
  REFERENCES users (id)
    ON DELETE CASCADE
);

CREATE TABLE usersCredentials (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(25),
  password VARCHAR(100),
  PRIMARY KEY (id),
  UNIQUE KEY (username)
);

CREATE TABLE userProfile (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  city VARCHAR(50),
  state GEOMETRY,
  email VARCHAR(50),
  localeStatus ENUM('Illegal', 'Legal', 'Decriminalized'),  
  exp ENUM('none', '< 1 year', '1-3 years', '3-5 years', '5+ years'),
  firstExp ENUM('pre-teenager', '13-15 years old', '15-17 years old', '18-21 years old', '21+'),
  freq ENUM('multiple times daily', 'daily', 'weekly', 'occasionally', 'social situations', 'never'),
  effectPrefs SET('relaxed', 'hungry', 'euphoric', 'happy', 'creative', 'energetic', 'talkative', 'uplifted', 'tingly', 'sleepy', 'focused', 'giggly', 'aroused'),
  speciesPref ENUM('indica', 'sativa', 'hybrid'),
  targetedConditions SET('depression', 'insomnia', 'pain', 'stress', 'cramps', 'lack of appetite', 'nausea', 'headache', 'fatigue', 'headaches', 'eye pressure', 'inflammation', 'spasticity', 'seizures', 'muscle spasms'),
  negativeEffects SET('dizzy', 'dry mouth', 'paranoid', 'dry eyes', 'anxious'),
  aromaPrefs SET('Earthy', 'Chemical', 'Pine', 'Spicy/Herbal', 'Pungent', 'Pepper', 'Flowery', 'Citrus', 'Orange', 'Sweet', 'Skunk', 'Grape', 'Minty', 'Woody', 'Cheese', 'Diesel', 'Tropical', 'Grapefruit', 'Nutty', 'Lemon', 'Berry',  'Blueberry', 'Ammonia', 'Apple', 'Rose', 'Butter', 'Honey', 'Tea', 'Lime', 'Lavender', 'Strawberry', 'Mint', 'Chestnut', 'Tree Fruit', 'Pear', 'Apricot', 'Peach', 'Blue Cheese', 'Menthol', 'Coffee', 'Tar', 'Mango', 'Pineapple', 'Sage', 'Vanilla', 'Plum', 'Tobacco', 'Violet'),
  preferredForms SET('inhalation (smoke/vapor)', 'edibles', 'other'),
  activityPrefs SET('sports', 'video games', 'exercise', 'listen to music', 'art', 'socialize', 'space out', 'watch tv/film', 'everyday functioning'),
  nearbyStrains TEXT(99),
  PRIMARY KEY (id, user_id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
  );
    
  CREATE TABLE strainProfile (
  user_id INT NOT NULL,
  strain_name VARCHAR(40) NOT NULL,
  strainDesc TEXT(250),
  strainAromas SET('Earthy', 'Chemical', 'Pine', 'Spicy/Herbal', 'Pungent', 'Pepper', 'Flowery', 'Citrus', 'Orange', 'Sweet', 'Skunk', 'Grape', 'Minty', 'Woody', 'Cheese', 'Diesel', 'Tropical', 'Grapefruit', 'Nutty', 'Lemon', 'Berry',  'Blueberry', 'Ammonia', 'Apple', 'Rose', 'Butter', 'Honey', 'Tea', 'Lime', 'Lavender', "Strawberry", "Mint", "Chestnut", "Tree Fruit", "Pear", "Apricot", "Peach", "Blue Cheese", "Menthol", "Coffee", "Tar", "Mango", "Pineapple", "Sage", "Vanilla", "Plum", "Tobacco", "Violet"),
  positiveEffects SET('relaxed', 'hungry', 'euphoric', 'happy', 'creative', 'energetic', 'talkative', 'uplifted', 'tingly', 'sleepy', 'focused', 'giggly', 'aroused'),
  negativeEffects SET('dizzy', 'dry mouth', 'paranoid', 'dry eyes', 'anxious'),
  itHelpedMy SET('depression', 'insomnia', 'pain', 'stress', 'cramps', 'lack of appetite', 'nausea', 'headache', 'fatigue', 'headaches', 'eye pressure', 'inflammation', 'spasticity', 'seizures', 'muscle spasms'),
  strainColor ENUM('light/green', 'dark/purple'),
  strainDensity ENUM('dense', 'sticky/trichomes', 'both', 'neither'),
  hydroponicallyGrown BOOLEAN,
  PRIMARY KEY (user_id, strain_name),
  UNIQUE KEY (strain_name),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
  );  
   
  CREATE TABLE preSession (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  sessionPurpose SET('stress relief', 'creative boost', 'medical necessity', 'curiosity/research', 'increased appreciation of art', 'altered consciousness in general (mental modularity)'), 
  hopeToAchieve TEXT(250),
  preMood SET('positive', 'neutral', 'anxious'),
  stateOfMind TEXT(500),
  PRIMARY KEY (id, user_id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
  );  
  
  CREATE TABLE preSessionToDo (
  id INT NOT NULL AUTO_INCREMENT,
  session_id INT NOT NULL,
  user_id INT NOT NULL,
  alreadyDone TEXT(500),
  preREM TEXT(500),
  preTomorrow TEXT(500),
  preAppointment TEXT(500),
  PRIMARY KEY (id, user_id, session_id),
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (session_id) REFERENCES preSession (id)
    ON DELETE CASCADE
  );  
  
  CREATE TABLE preSessionWorries (
  id INT NOT NULL AUTO_INCREMENT,
  session_id INT NOT NULL,
  user_id INT NOT NULL,
  lingeringEmotions TEXT(200),
  worriesOnHorizon TEXT(200),
  weeklyDues TEXT(200),
  futureAbstractGoals TEXT(200),
  PRIMARY KEY (id, user_id, session_id),
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (session_id) REFERENCES preSession (id)
    ON DELETE CASCADE
  );
  
  CREATE TABLE activeSession (
  id INT NOT NULL AUTO_INCREMENT,
  session_id INT NOT NULL,
  user_id INT NOT NULL,
  expPositives SET('relaxed', 'hungry', 'euphoric', 'happy', 'creative', 'energetic', 'talkative', 'uplifted', 'tingly', 'sleepy', 'focused', 'giggly', 'aroused'),
  expNegatives SET('dizzy', 'dry mouth', 'paranoid', 'dry eyes', 'anxious'),
  expAromas SET("Earthy", "Chemical", "Pine", "Spicy/Herbal", "Pungent", "Pepper", "Flowery", "Citrus", "Orange", "Sweet", "Skunk", "Grape", "Minty", "Woody", "Cheese", "Diesel", "Tropical", "Grapefruit", "Nutty", "Lemon", "Berry",  "Blueberry", "Ammonia", "Apple", "Rose", "Butter", "Honey", "Tea", "Lime", "Lavender", "Strawberry", "Mint", "Chestnut", "Tree Fruit", "Pear", "Apricot", "Peach", "Blue Cheese", "Menthol", "Coffee", "Tar", "Mango", "Pineapple", "Sage", "Vanilla", "Plum", "Tobacco", "Violet"),
  expStrength ENUM('1','2','3','4','5','6','7','8','9','10'),
  expMood SET('positive', 'neutral', 'anxious'),
  expMentalState TEXT(500),
  cannabisFactor ENUM('1','2','3','4','5','6','7','8','9','10'),
  expectationsFactor ENUM('1','2','3','4','5','6','7','8','9','10'),
  anomaliesLog TEXT(500),
  epiphaniesLog TEXT(500),
  regretsLog TEXT(500),
  PRIMARY KEY (id, user_id, session_id),
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (session_id) REFERENCES preSession (id)
    ON DELETE CASCADE
  );
  
  CREATE TABLE postSession (
  id INT NOT NULL AUTO_INCREMENT,
  session_id INT NOT NULL,
  user_id INT NOT NULL,
  expectationsMet ENUM('1','2','3','4','5','6','7','8','9','10'),
  disappointments TEXT(500),
  wouldChangeNextTime TEXT(500),
  wouldRecommend BOOLEAN,
  PRIMARY KEY (id, user_id, session_id),
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (session_id) REFERENCES preSession (id)
    ON DELETE CASCADE
  );
  
  CREATE TABLE postSessionLastingInsights (
  id INT NOT NULL AUTO_INCREMENT,
  session_id INT NOT NULL,
  user_id INT NOT NULL,
  postSession_id INT NOT NULL,
  mundaneInsights TEXT(500),
  significantInsights TEXT(500),
  profoundInsights TEXT(500),
  PRIMARY KEY (id, user_id, session_id, postSession_id),
  FOREIGN KEY (postSession_id) REFERENCES postSession (id),
  FOREIGN KEY (session_id) REFERENCES preSession (id)
    ON DELETE CASCADE
  );
  
  
  
  
  
  
  
  
  
  
  
  

-- INSERT INTO users
-- 	(first_name, last_name)
-- VALUES 
--   ("James","Butt"),
--   ("Josephine","Darakjy"),
--   ("Art","Venere");

-- INSERT INTO usersContact
-- 	(user_id, phone1, phone2, email)
-- VALUES 
--   (92,"626-572-1096","626-696-2777","cory.gibes@gmail.com"),
--   (332,"607-407-3716","607-350-7690","kirk.herritt@aol.com");


-- INSERT INTO usersAddress
-- 	(user_id, address, city, county, state, zip)
-- VALUES 
--   (92,"6649 N Blue Gum St","New Orleans","Orleans","LA",70116),
--   (332,"4 B Blue Ridge Blvd","Brighton","Livingston","MI",48116);