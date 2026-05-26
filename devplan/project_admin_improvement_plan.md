# Project Admin Improvement Plan

## 1. Current State Analysis
The current `app/admin/projects.rb` file uses a very basic top-to-bottom layout for the `Project` model. It lists 15 attributes sequentially in the `show` and `form` blocks, including `title`, `slug`, `summary`, `description`, `content`, `category`, and location data. 

In comparison, the recently improved `VolunteerAudience` admin panel uses a sophisticated layout with tabbed navigation, rich image previews, and inline management for nested relationships.

## 2. The JetEngine "27 Meta Fields" Issue
I analyzed the provided `devplan/projects-Post-Types` document. It correctly shows the configuration for the WordPress JetEngine Custom Post Type for "Projects", including the toggle for "Custom Meta Storage". 

**However, the "Meta fields (27)" accordion in the screenshots on pages 5-8 is collapsed.** 

Because the fields were collapsed when the screenshots were taken, I cannot see the names or data types of the 27 meta fields. The current Rails `Project` model has an empty JSONB `meta` column ready to accept this data, but we need to know what those fields are to map them correctly.

## 3. Proposed Improvements for `app/admin/projects.rb`

### A. Implement a Tabbed Form Layout
To improve the UX for administrators, we should break the long single-column form into logical tabs, similar to the `VolunteerAudience` setup:
1. **Basic Info:** Title, Slug, Status, Category, Position.
2. **Location & Logistics:** Destination, Location dropdown, Location name (legacy), Duration Weeks (Min/Max).
3. **Content & Media:** Cover Image, Summary, Description, Rich Text Content.
4. **Project Details (The 27 Meta Fields):** A dedicated tab for the custom fields once they are identified.

### B. Map the 27 Meta Fields to JSONB
Once you provide the list of the 27 fields, we can use Rails' `store_accessor` on the `Project` model's `meta` JSONB column. 
For example:
```ruby
store_accessor :meta, :project_cost, :accommodation_type, :meals_included, :min_age, ...
```
This allows us to render them easily in ActiveAdmin without running 27 separate database migrations.

### C. Enhance the Show Page (Read-Only View)
- Add image thumbnail previews for the cover image.
- Group attributes into logical `panel` blocks (e.g., "Logistics", "Content").
- Add a panel specifically for rendering the populated JSONB meta fields.

## 4. Next Steps
To proceed with coding this improvement, **I need the list of the 27 meta fields**. 
You can provide this by either:
1. Taking a new screenshot of the expanded "Meta fields" accordion in WordPress.
2. Providing a JSON export of the JetEngine post type.
3. Simply pasting a text list of the fields (and their types, like text, number, gallery, etc.) in the chat.

Once provided, I will immediately write the code to upgrade the `Project` model and the `app/admin/projects.rb` interface.
