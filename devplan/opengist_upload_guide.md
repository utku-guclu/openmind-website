# Guide to Uploading Files and Folders to Opengist

Opengist is a powerful, self-hosted pastebin powered by Git. Because every snippet is backed by a Git repository, it supports robust developer workflows. You can upload files and entire folder structures natively using **Git commands** or manually via the **Web UI**.

This guide details how to upload your files and folders to your Opengist instance at:
`https://official-omp-opengist.ra1zsf.easypanel.host/TT`

---

## Method 1: Uploading via Git (Recommended for Folders & Bulk Uploads)

Since Opengist stores snippets as standard Git repositories, the native Git CLI is the most powerful way to upload multiple files, preserve nested directory structures, and manage version history.

### Step 1: Initialize your local folder
Prepare the files and folders you want to upload on your local machine:
```bash
# Create a workspace directory
mkdir my-opengist-snippet
cd my-opengist-snippet

# Initialize it as a Git repository
git init
```

### Step 2: Add files and nested folders
Copy or create the files and folders you want to upload into this folder. For example:
```bash
# Create nested folders and files
mkdir -p src/utils config
echo "console.log('Hello, World!');" > src/index.js
echo "module.exports = { port: 3000 };" > config/app.js
echo "const format = (val) => val.trim();" > src/utils/format.js
```

Stage and commit your files:
```bash
git add .
git commit -m "Initial commit with files and nested folders"
```

### Step 3: Configure the Remote URL
Opengist allows two different paths when pushing a new snippet:

#### Option A: Auto-generated Snippet ID (Random Slug)
If you want Opengist to generate a unique random URL for your gist, point your remote to `/init`:
```bash
git remote add origin https://official-omp-opengist.ra1zsf.easypanel.host/init
```

#### Option B: Custom Snippet URL
If you want a specific custom URL identifier (e.g., `https://official-omp-opengist.ra1zsf.easypanel.host/TT/my-project`), use your username (`TT`) followed by the slug:
```bash
git remote add origin https://official-omp-opengist.ra1zsf.easypanel.host/TT/my-project
```
> [!IMPORTANT]
> The username in the URL (`TT`) must match your authenticated Opengist username.

### Step 4: Push to Opengist with Metadata (Push Options)
When you push to Opengist, you can configure metadata such as **Title**, **Description**, and **Visibility** dynamically using Git's `-o` (or `--push-option`) flags.

Run the push command:
```bash
git push -u origin master \
  -o title="My Project Snippet" \
  -o description="A collection of project configuration and utility scripts" \
  -o visibility=public
```

#### Available Push Options:
*   `-o title="Your Title"`: Sets the snippet title (defaults to the custom slug or Git folder name).
*   `-o description="Your Description"`: Sets the descriptive text.
*   `-o visibility=public|unlisted|private`: Sets access levels.
*   `-o url="custom-identifier"`: Overwrites the URL slug.

### Step 5: Authentication
During the `git push` command, you will be prompted for your credentials:
1.  **Username:** Your Opengist username (e.g., `TT`).
2.  **Password/Token:** Your account password. If you set up OAuth (GitHub/Gitlab) or running v1.12.0+, you can also use a personal **Access Token** generated in your Opengist User Settings.

---

## Method 2: Uploading via the Web UI (Best for Quick Single-File Edits)

For smaller edits or single-file additions, the Web UI provides a clean drag-and-drop experience.

### Step 1: Create a New Snippet
1.  Navigate to `https://official-omp-opengist.ra1zsf.easypanel.host/`
2.  Log in and click the **New** button at the top header.
3.  Specify the Title, Description, and Visibility settings.

### Step 2: Add Files
*   **Drag and Drop:** You can drag files directly from your system file manager and drop them onto the web editor to upload them.
*   **Add File Button:** Click the **Add File** button in the editor interface to open a file chooser.

> [!WARNING]
> **Nested Folder Limitation:** The Web UI is primarily designed for individual files. To maintain deep, complex directory structures (like nested folders), the Git CLI method (Method 1) is highly recommended.

---

## Programmatic Uploads (Access Tokens & API)

If you are running **Opengist v1.12.0** or newer, you can leverage the **REST API** and personal **Access Tokens** for automated script-based uploads:

1.  **Generate Access Token:** Go to your Opengist account dashboard, navigate to **Settings**, and generate a new **Access Token**.
2.  **Git Authentication:** Use the token as your password when running Git automated scripts.
3.  **JSON API:** Interact with the snippet routes programmatically by including your token in the `Authorization: Bearer <TOKEN>` header.
