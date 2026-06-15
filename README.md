# Rails Addressbok Project - Complete Guide

**Project Type:** Full-stack Rails application  
**Framework:** Rails 8.1  

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Features List](#features-list)
2. [Prerequisites](#prerequisites)
3. [Setup instructions](#setup-instructions)
4. [Environment Setup](#environment-setup)
5. [Key Commands](#key-commands)
6. [Architecture notes](#architecture-notes)
7. [Roadmap/pending](#roadmap)
8. [Resources](#resources)
---

### Project Overview
A fullstack contact management application built with Rails 8, featuring:

- User Accont Management
- CSV import/export
- Admin Panel

![Homepage](.\app\assets\images\homepage-screenshot.png)

### Features List
#### Client
1. Create,view,update and delete contacts.
2. Edit and delete user account.
3. Import or export a selection of or all contacts.
4. User validation on sign up.
5. Search, sort and filter contacts.

#### Admin
1. View application statistics.
2. Create new users and admins.
3. Promote or demote user roles.
4. View advanced user statistics (date joined, number of signups, last sign in).
6. View contacts linked to user
5. Lock and unlock user accounts.
6. Search users and contacts.

### Prerequisites

- Ruby 3.4.x
- Rails 8.0+
- PostgreSQL 14+
- Node.js 18+
- Bundler 2.x

> **Note**: If you are using Windows, ensure you have **WSL2** (Windows Subsystem for Linux) or Git Bash installed for optimal compatibility.

## Setup instructions
### 1. Clone the Repository
```bash
git clone <repository-url>
cd addressbook
```
### 2. Install dependencies
```bash
bundle install
```
### 3.Configure Environment variables
Creat a .env file in the project root
```bash
touch .env
```
Populate the env with the following variables

```env
ADDRESSBOOK_DATABASE_PASSWORD=password
ADDRESSBOOK_DATABASE_USERNAME=db_username
DEV_DB_NAME=(any db name of your choice)
TEST_DB_NAME=(any db name of your choice)
```

## Long commit message style
For longer commit messages, use the convention below

Use a short, clear commit message in the format:

    type(scope): short description

Then add an optional body with the what and why, and an optional footer for
issue references or breaking-change notes.

A local commit template file is included at `.gitmessage.txt`.

To enable it for this repository, run:

    git config commit.template .gitmessage.txt
    
Then run:
   
    git commit

The template file would open, type your commit message in it.

Example:

    fix(contacts): validate duplicate phone numbers

    Prevent duplicate contact records by validating phone numbers at the model
    level.

    


