
## Iconica

Welcome to our github repository!

Before contributing make sure you have read the [contribution guide](./profile/CONTRIBUTING.md)
Also when adding a repository make sure to add a README in accordance with the README_TEMPLATE

## Issues

Please file any issues, bugs or feature request as an issue on our repository. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to a package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./profile/CONTRIBUTING.md) and send us a pull request.

## Author

All packages are developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>

## List of Iconica Starter Workflows
There are multiple standardized Workflows used by the Iconica Projects. Adding this workflow to a repositories .github/workflows/ folder will add a Github Action for tasks like linting and testing code.
Each Starter Workflow calls a workflow inside this repository so Workflows can be easily improved.

| Name | Version | Link | Usage |
| ---- | ------- | ---- | ----- |
| app-ci | 2.0.0 | [app-ci.yml](./workflow-templates/app-ci.yml) | This Workflow runs the standard steps for Iconica Apps before approval can be given on a Pull Request |
| component-ci | 2.0.0 | [component-ci.yml](./workflow-templates/component-ci.yml) | This Workflow runs the standard steps for Iconica Components before approval can be given on a Pull Request |
| melos-ci | 1.0.0 | [melos-ci.yml](./workflow-templates/melos-ci.yml) | This Workflow runs the standard steps for Iconica Melos Packages before approval can be given on a Pull Request |
| flutter-cache | 2.0.0 | [flutter-cache.yml](./workflow-templates/flutter-cache.yml) | This Workflow runs a caching action on master and development branch to ensure better cache reuse |
| firebase-web-cd | 5.0.0 | [firebase-web-cd.yml](./workflow-templates/firebase-web-cd.yml) | This workflow runs a Flutter build for web and deploys it to Firebase Hosting (on pull requests and pushes to master). Configuring this action is done through ```firebase init hosting:github``` |
app-firebase-cd | 1.0.0 | [app-firebase-cd.yml](./workflow-templates/app-firebase-cd.yml) | This workflow gives the user the option to build Flutter apps for both Android and iOS (on dispatch) and distribute the builds to Firebase. Before using this workflow, the repository implementing it requires some configuration. This is necessary to sign the iOS app. The configuration steps can be found in [this manual](./.github/workflows/manuals/firebase-ios-cd.md). | 
component-documentation | 1.0.0 | [component-documentation.yml](./workflow-templates/component-documentation.yml) | This Workflow runs a action that triggers the component documentation te be updated. |

## List of Flutter Packages

This list contains all the repositories that contain components. When a package is marked as having Melos it means there are multiple components inside the repository. To find out the name of the component you will have to look inside the repository.

Click [here](https://github.com/Iconica-Development/.github/actions/workflows/release.yml) to run the Github Action updating this list.

A list of all the Gifs of the packages can be found [here](./profile/FEATURES.md)

| Package | Latest Tag | Last Updated | Melos | UserStory | Link | Example | Features |
| ------- | ---------- | ------------ | ----- | --------- | ---- | ------- | -------- |
