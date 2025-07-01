
const user = {
  name: 'Alice',
  age: 25,
  city: 'New York'
};

const entries = Object.entries(user); // [['name', 'Alice'], ['age', 25], ['city', 'New York']]

const mapped = entries.map(([key, value]) => `${key.toUpperCase()}: ${value}`);

console.log(mapped);




const users = {
  name: 'Alice',
  age: 25
};

const updated = Object.fromEntries(
  Object.entries(users).map(([key, value]) => [key.toUpperCase(), value])
);

console.log(updated);


const userss = {
  name: 'Alice',
  age: 25
};

const values = Object.keys(userss).map(key => `${key}: ${user[key]}`);


