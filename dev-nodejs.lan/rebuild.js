require('dotenv').config();
const config = JSON.parse(require('fs').readFileSync('config.json', 'utf8'));
const db = require('./db');
const bcrypt = require('bcrypt');
const e = require('sqlstring').escape;

(async _=>{
    console.log('Creating table: teams')
    await db('drop table if exists teams cascade')
    await db(`create table teams (id serial primary key
        ${config.teams.fields.length > 0 ? ',' : ''}
        ${config.teams.fields.map((field)=>`${field.name} ${field.type}`).join()}
        )`)
    await db(`insert into teams (name, owner) values ('admin', 1)`)

    console.log('Creating table: users')
    await db('drop table if exists users cascade')
    await db(`create table users (id serial primary key, team integer references teams not null
        ${config.users.fields.length > 0 ? ',' : ''}
        ${config.users.fields.map((field)=>`${field.name} ${field.type}`).join()}
        )`)
    await db(`insert into users (team, email, password, role) values (1, ${e(config.users.admin.email)}, ${e(bcrypt.hashSync(config.users.admin.password, parseInt(process.env.PASSWORD_HASH_ROUNDS)))}, 0)`)

    for (let table of config.tables){
        console.log(`Creating table: ${table.name}`)
        await db(`drop table if exists ${table.name} cascade`)
        await db(`create table ${table.name} (id serial primary key, team integer references teams not null
        ${table.fields.length > 0 ? ',' : ''}
        ${table.fields.map((field)=>`${field.name} ${field.type}`).join()}
        )`)
    }

    process.exit()
})();