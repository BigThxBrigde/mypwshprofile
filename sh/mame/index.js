const database = require('./query.json')

const argv = process.argv.slice(2)


let keyword, query;

if (argv.length < 1 || argv.length > 2) {
    console.error("No input keyword is too many or none")
    process.exit(-1);
}
else if (argv.length == 2) {

    if (argv[0] != '-c' && argv[0] != '-e') {
        console.error(`Unknow options: ${argv[0]}`)
        process.exit(-1)
    }

    keyword = argv[1]
    query = (k, v) => {
        let match = argv[0] === '-c' ? v : k
        return match.indexOf(keyword) > -1
    }
}
else {

    keyword = argv[0]
    query = (k, v) => {
        return k.indexOf(keyword) > -1
            || v.indexOf(keyword) > -1
    }
}


const result = []

for (const [key, value] of Object.entries(database)) {
    if (query(key, value)) {
        result.push(`${key}: ${value}`)
    }
}

if (result.length === 0) {
    console.error('No result found!')
} else {
    console.log(`Found results of ${keyword}:`)
    console.log(`  - ${result.join('\n  - ')}`)
}


