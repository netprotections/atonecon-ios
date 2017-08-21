# RELEASE ATONECON

We will use `CocoaPods` to publish `AtoneCon` library.

## Content

- [Configuration](#configuration)
- [Publish](#publish)
- [Update](#update)

### Configuration

Once you have a release ready you will need to make the corresponding tag. First run a quick pod lib lint then create your tag and push it.

#### The release workflow is similar to the following

- Step 1: Open Terminal, access to folder Library

```bash
cd <path-to-AtoneCon-project-dir>
```

- Step 2: Check `podspec` version is correct or no

Open `AtoneCon.podspec` in project folder. Check properties and edit podspec if you want

- Step 3: Create a tag for your new Pod version and push it

```bash
git tag *version*

git push --tags
```

- Step 4: Linting the project

CocoaPods needs to verify that nothing is wrong with a project. This spans from limitations and requirements to errors and even suspicious code. CocoaPods requires you to lint your project.

Linting a project is extremely easy, but could be incredibly annoying! To lint your project run the following in your project directory:

```bash
[bundle exec] pod lib lint [AtoneCon.podspec]
```

### Publish

After configuring your pod, you need to publish it

- Step 1: Making a Trunk Account

```bash
pod trunk register examplemail@gmail.com 'Example' --description='example description'
```

- Step 2: Pushing Your Pod

###### Submitting Open Source Code

Once your tags are pushed you can use the command:

```bash
[bundle exec] pod trunk push [AtoneCon.podspec]
```

to send your library to the Specs repo.

###### Submitting Private Code

Once your tags are pushed you can use the command:

```bash
[bundle exec] pod repo push [AtoneCon.podspec]
```

to send your library to the named private specs repo.

### Update

If you want to update your Pod with new version, you will need to follow these steps

- Step 1: Update the pod version in your Podspec file. Make sure this matches the GitHub tag version you will create next.
- Step 2: Push all the new files to your master branch.
- Step 3: Create a tag for your new Pod version and push it:

```bash
git tag *version*

git push --tags
```

- Step 4: Linting the project

```bash
[bundle exec] pod lib lint [AtoneCon.podspec]
```

- Step 5: Push your new Pod version using trunk:

```bash
[bundle exec] pod trunk push [AtoneCon.podspec]
```