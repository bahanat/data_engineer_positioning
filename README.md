# Data Engineer course positioning

## Context
While applying to a data engineering course, I was asked to do a small positioning exercice.

## Objectives
- Model a database to meet a specific need.
- Create a relational database in SQL to store customer orders, products, and associated calculations.
- Automate the logic for managing constraints.
- Produce basic analyses to validate the consistency and usefulness of the database.

## Project structure
```bash
project/
│
├── test_insertions/                    # SQL requests to insert fake data in database
│   ├── 01_clients.sql
│   ├── 02_...
│   └── 06_order_details.sql
│
├── trigger_functions/                  # Trigger functions to automatically update some of the fields
│   ├── set_created_at.sql
│   ├── update_finish_price.sql
│   └── update_order_total_price.sql
│
├── README.md
└── tables_creation.sql                 # SQL requests to create the different tables
```

## How to

### 0. Setup PostgreSQL in WSL (optional if you want to use something else)

#### 1. Update your package
```bash
sudo apt update
```

#### 2. Install PostgreSQL and its contrib package
```bash
sudo apt install postgresql postgresql-contrib
```

#### 3. Verify the installation
```bash
psql --version
```

#### 4. Start the PostgreSQL service
```bash
sudo service postgresql start
```

#### 5. Set a password for the default 'postgres' user
```bash
sudo passwd postgres
```

#### Access the PostgreSQL prompt
```bash
sudo -u postgres psql
```

#### To manage PostgreSQL, use these commands  
- Check status: `sudo service postgresql status`
- Start service: `sudo service postgresql start`
- Stop service: `sudo service postgresql stop`

#### To enable PostgreSQL to start automatically, use
```bash
sudo systemctl enable postgresql
```

### 1. Connect your database manager to the database

### 2. Create the tables
Use the SQL requests you can find in the `tables_creation.sql` file. Execute the requests in the correct order, as found in the file.

### 3. Create the trigger functions
There are 3 trigger functions you can add to the database, they can be found in the `trigger_functions` directory.

### 4. Add fake data to test the database
Execute the SQL insertion requests one-by-one, found in the `test_insertions` directory.