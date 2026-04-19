# TechParenthesis Finance Hub - Project Guide

## Overview

A professional financial management dashboard for **TechParenthesis** online training institute. This tool tracks student enrollments (Income) and operational costs (Expenses) with real-time syncing to Supabase.

## Tech Stack

* **Frontend:** React (Vite), Tailwind CSS, Lucide Icons
* **Database/Backend:** Supabase (PostgreSQL)
* **Deployment:** GitHub -> Vercel

## Naming Conventions

* **Files/Components:** PascalCase (e.g., `IncomeDashboard.jsx`)
* **Database Tables/Columns:** snake\_case (e.g., `course\_name`, `student\_name`)
* **Variables/Functions:** camelCase (e.g., `fetchIncomeData`)

## Core Business Logic

* **Currency:** All financial figures must be displayed in **INR (₹)**.
* **Income Categories:** Python Launchpad, Data Science \& AI, Jira Mastery.
* **Expense Categories:** Salaries, Meta/Google Ads, Website Maintenance, Zoom, Claude Subscription.

## Common Commands

* `npm install` - Install dependencies
* `npm run dev` - Start local development server
* `npm run build` - Build for production
* `git add . \&\& git commit -m "update" \&\& git push` - Push changes to GitHub

## Environment Variables (Required)

* `VITE\_SUPABASE\_URL`
* `VITE\_SUPABASE\_ANON\_KEY`

