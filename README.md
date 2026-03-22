# CheeseTracker - Cheese Discovery App

A cheese discovery and tracking app that displays photos of different cheese varieties and allows users to log their tasting experiences. The app helps cheese enthusiasts explore new types and maintain a personal tasting journal.

## Features

- **Cheese Photo Gallery**: Browse beautiful photos of different cheese varieties with detailed information
- **Personal Tasting Journal**: Log your tasting experiences with ratings and detailed notes
- **Smart Recommendations**: Get personalized cheese recommendations based on your history
- **Search & Filter**: Find cheeses by type, origin, and other characteristics
- **Wishlist**: Keep track of cheeses you want to try next

## Target Users

- Cheese enthusiasts who want to systematically track their tastings
- Foodies exploring new culinary experiences
- Culinary explorers looking to expand their cheese knowledge

## Tech Stack

- **Framework**: Next.js 15 with App Router
- **Authentication & Database**: Supabase
- **Styling**: Tailwind CSS
- **Language**: TypeScript

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
   - Copy `.env.example` to `.env.local`
   - Add your Supabase project credentials

4. Run the development server:
   ```bash
   npm run dev
   ```

5. Open [http://localhost:3000](http://localhost:3000) in your browser

## Project Structure

```
├── app/
│   ├── (auth)/
│   │   ├── login/page.tsx
│   │   └── signup/page.tsx
│   ├── dashboard/page.tsx
│   ├── globals.css
│   ├── layout.tsx
│   └── page.tsx
├── lib/
│   └── supabase/
│       ├── client.ts
│       └── server.ts
├── supabase/
│   └── migrations/
│       └── 001_initial.sql
└── README.md
```

## Database Schema

The app uses the following main tables:
- `profiles`: User profile information
- `cheeses`: Cheese varieties with details
- `tasting_logs`: User tasting entries with ratings and notes
- `wishlist`: Cheeses users want to try

## Contributing

This is a learning project. Feel free to explore the code and suggest improvements!

## License

MIT License