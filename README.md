# DbAutoDoc - Database Documentation Automation

![Build Status](https://github.com/nurzhanme/DbAutoDoc/workflows/GenDoc/badge.svg)

**DbAutoDoc** is a sample repository that demonstrates an effective approach to automating the generation of comprehensive HTML documentation for your database schema using the official Docker Image of [SchemeSpy](https://github.com/schemaspy/schemaspy).

The resulting documentation is seamlessly uploaded to GitHub Pages for easy accessibility.

## Sample setup

- Database Engine: PostgreSQL
- Sample Database Script: Explore [Sample script](https://github.com/nurzhanme/DbAutoDoc/blob/master/data.sql) for creating tables and populating them with data.

## GitHub Pages Configuration

To set up the hosting of database documentation using GitHub Pages, follow these steps to configure it:

- Navigate to your repository settings.
- Select the `Pages` tab.
- Under `Build and deployment` select `Deploy from a branch` as `Source`.
- Specify the branch name as `gh-pages` (ensure it's created beforehand) and set the folder to `(root)`.
- Click `Save` to apply your configuration.

## Sample Workflow Pipeline

Below is a sample GitHub Actions workflow designed to automate your database documentation process:

```yml
- name: Checkout code
  uses: actions/checkout@v2
        
- name: Set permissions for output directory
  run: |
    chmod -R 777 $GITHUB_WORKSPACE

- name: Generate SchemaSpy Documentation
  run: |
    docker pull schemaspy/schemaspy
    docker run --rm -v $GITHUB_WORKSPACE:/output schemaspy/schemaspy \
      -t pgsql \
      -host ${{ secrets.DB_HOST }} \
      -db ${{ secrets.DB_NAME }} \
      -u ${{ secrets.DB_USER }} \
      -p ${{ secrets.DB_PASSWORD }}
      
- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: .
```

Ensure that you create necessary secrets, such as `DB_HOST`, `DB_NAME`, and others, in your repository's settings. These secrets are vital for configuring your database connection securely.
`GITHUB_TOKEN` secret is automatically created by a A GitHub Actions runner. It required to authenticate in a workflow run.

## Pipeline Output

Upon successful execution of this workflow, database documentation will be available on the [GitHub Pages](https://nurzhanme.github.io/DbAutoDoc/) of the repository.
