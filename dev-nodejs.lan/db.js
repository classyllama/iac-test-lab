const { Pool } = require('pg')
const pool = new Pool({
    user: process.env.POSTGRES_USER,
    host: process.env.POSTGRES_HOST,
    database: process.env.POSTGRES_DB,
    password: process.env.POSTGRES_PASSWORD,
    port: process.env.POSTGRES_PORT,
})


/**
 * Perform Postgres Query
 * @returns {Array} Query Result
 * @async
 * @param {string} query SQL Query
 */
module.exports = exports.db = async (query) => (await pool.query(query)).rows

/**
 * Perform Postgres Query
 * @returns {number} Number rows affected
 * @async
 * @param {string} query SQL Query
 */
exports.run = async (query) => (await pool.query(query)).rowCount

process.on('exit', async _=>pool.end())