
## Iconica

Welcome to our github repository!

Before contributing make sure you have read the [contribution guide](./CONTRIBUTING.md)
Also when adding a repository make sure to add a README in accordance with the README_TEMPLATE

## Issues

Please file any issues, bugs or feature request as an issue on our repository. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to a package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us a pull request.

## Author

All packages are developed by [Iconica](https://iconica.app). You can contact us at <support@iconica.nl>

## List of Iconica Starter Workflows
There are multiple standardized Workflows used by the Iconica Projects. Adding this workflow to a repositories .github/workflows/ folder will add a Github Action for tasks like linting and testing code.
Each Starter Workflow calls a workflow inside this repository so Workflows can be easily improved.

| Name | Version | Link | Usage |
| ---- | ------- | ---- | ----- |
| app-ci | 2.0.0 | [app-ci.yml](../workflow-templates/app-ci.yml) | This Workflow runs the standard steps for Iconica Apps before approval can be given on a Pull Request |
| component-ci | 2.0.0 | [component-ci.yml](../workflow-templates/component-ci.yml) | This Workflow runs the standard steps for Iconica Components before approval can be given on a Pull Request |
| melos-ci | 1.0.0 | [melos-ci.yml](../workflow-templates/melos-ci.yml) | This Workflow runs the standard steps for Iconica Melos Packages before approval can be given on a Pull Request |
| django | 1.0.0 | [django.yml](../workflow-templates/django.yml) | This Workflow runs the standard steps for Iconica Django Projects before approval can be given on a Pull Request |
| flutter-cache | 2.0.0 | [flutter-cache.yml](../workflow-templates/flutter-cache.yml) | This Workflow runs a caching action on master and development branch to ensure better cache reuse |
| firebase-web-cd | 6.0.0 | [firebase-web-cd.yml](../workflow-templates/firebase-web-cd.yml) | This workflow runs a Flutter build for web and deploys it to Firebase Hosting (on pull requests and pushes to master). Configuring this action is done through ```firebase init hosting:github``` |
app-firebase-cd | 1.0.0 | [app-firebase-cd.yml](../workflow-templates/app-firebase-cd.yml) | This workflow gives the user the option to build Flutter apps for both Android and iOS (on dispatch) and distribute the builds to Firebase. Before using this workflow, the repository implementing it requires some configuration. This is necessary to sign the iOS app. The configuration steps can be found in [this manual](../.github/workflows/manuals/firebase-ios-cd.md). | 
component-documentation | 1.0.0 | [component-documentation.yml](../workflow-templates/component-documentation.yml) | This Workflow runs a action that triggers the component documentation te be updated. |
component-release | 1.0.0 | [component-release.yml](../workflow-templates/component-release.yml) | This Workflow runs a action that triggers the component to be released which includes publishing. |

## List of Flutter Packages

This list contains all the repositories that contain components. When a package is marked as having Melos it means there are multiple components inside the repository. To find out the name of the component you will have to look inside the repository.

Click [here](https://github.com/Iconica-Development/.github/actions/workflows/release.yml) to run the Github Action updating this list.

A list of all the Gifs of the packages can be found [here](./FEATURES.md)

| Package | Latest Tag | Last Updated | Melos | UserStory | Link | Example | Docs |
| ------- | ---------- | ------------ | ----- | --------- | ---- | ------- | ---- |
| flutter_address_form | 0.0.2 | 2024-2-27 | No | No | [code](https://github.com/Iconica-Development/flutter_address_form) | [example](https://api.github.com/repos/Iconica-Development/flutter_address_form/tree/master/example) |  |
| flutter_agenda | 1.1.0 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_agenda) | [example](https://api.github.com/repos/Iconica-Development/flutter_agenda/tree/master/example) |  |
| flutter_animated_toggle | 0.0.3 | 2024-2-28 | No | No | [code](https://github.com/Iconica-Development/flutter_animated_toggle) | [example](https://api.github.com/repos/Iconica-Development/flutter_animated_toggle/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_animated_toggle/index.html) |
| flutter_animated_widgets | 0.1.1 | 2024-4-30 | No | No | [code](https://github.com/Iconica-Development/flutter_animated_widgets) | [example](https://api.github.com/repos/Iconica-Development/flutter_animated_widgets/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_animated_widgets/index.html) |
| flutter_bottom_alert_dialog | 0.0.2 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_bottom_alert_dialog) | [example](https://api.github.com/repos/Iconica-Development/flutter_bottom_alert_dialog/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_bottom_alert_dialog/index.html) |
| flutter_carousel | 0.3.1 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_carousel) | [example](https://api.github.com/repos/Iconica-Development/flutter_carousel/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_carousel/index.html) |
| flutter_chart | 1.0.1 | 2024-3-6 | No | No | [code](https://github.com/Iconica-Development/flutter_chart) | [example](https://api.github.com/repos/Iconica-Development/flutter_chart/tree/master/example) |  |
| flutter_chat | 1.4.3 | 2024-4-26 | Yes | Yes | [code](https://github.com/Iconica-Development/flutter_chat) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_chat/index.html) |
| flutter_connectivity | 0.2.7 | 2024-3-25 | No | No | [code](https://github.com/Iconica-Development/flutter_connectivity) | [example](https://api.github.com/repos/Iconica-Development/flutter_connectivity/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_connectivity/index.html) |
| flutter_connectivity_hook | 0.2.8 | 2024-3-25 | No | No | [code](https://github.com/Iconica-Development/flutter_connectivity_hook) | [example](https://api.github.com/repos/Iconica-Development/flutter_connectivity_hook/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_connectivity_hook/index.html) |
| flutter_custom_html_element_web | 0.0.1 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_custom_html_element_web) | [example](https://api.github.com/repos/Iconica-Development/flutter_custom_html_element_web/tree/master/example) |  |
| flutter_data_interface | 1.0.1 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_data_interface) |  |  |
| flutter_date_time_picker | 4.0.1 | 2024-3-26 | No | No | [code](https://github.com/Iconica-Development/flutter_date_time_picker) | [example](https://api.github.com/repos/Iconica-Development/flutter_date_time_picker/tree/master/example) |  |
| flutter_dialogs | 0.0.2 | 2024-2-27 | No | No | [code](https://github.com/Iconica-Development/flutter_dialogs) | [example](https://api.github.com/repos/Iconica-Development/flutter_dialogs/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_dialogs/index.html) |
| flutter_form_wizard | 6.3.1 | 2024-2-29 | No | No | [code](https://github.com/Iconica-Development/flutter_form_wizard) | [example](https://api.github.com/repos/Iconica-Development/flutter_form_wizard/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_form_wizard/index.html) |
| flutter_google_maps |  | 2024-3-1 | No | No | [code](https://github.com/Iconica-Development/flutter_google_maps) |  |  |
| flutter_google_track_and_trace | 2.0.1 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_google_track_and_trace) | [example](https://api.github.com/repos/Iconica-Development/flutter_google_track_and_trace/tree/master/example) |  |
| flutter_grid_to_list | 0.0.3 | 2024-3-6 | No | No | [code](https://github.com/Iconica-Development/flutter_grid_to_list) | [example](https://api.github.com/repos/Iconica-Development/flutter_grid_to_list/tree/master/example) |  |
| flutter_hooks_iconica_utilities | 1.0.3 | 2024-3-4 | No | No | [code](https://github.com/Iconica-Development/flutter_hooks_iconica_utilities) | [example](https://api.github.com/repos/Iconica-Development/flutter_hooks_iconica_utilities/tree/master/example) |  |
| flutter_iconica_analysis | 7.0.0 | 2024-3-25 | No | No | [code](https://github.com/Iconica-Development/flutter_iconica_analysis) | [example](https://api.github.com/repos/Iconica-Development/flutter_iconica_analysis/tree/master/example) |  |
| flutter_iconica_utilities | 0.0.7 | 2024-3-7 | No | No | [code](https://github.com/Iconica-Development/flutter_iconica_utilities) |  |  |
| flutter_image_picker | 3.0.0 | 2024-2-28 | No | No | [code](https://github.com/Iconica-Development/flutter_image_picker) | [example](https://api.github.com/repos/Iconica-Development/flutter_image_picker/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_image_picker/index.html) |
| flutter_image_progression | 0.0.2 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_image_progression) | [example](https://api.github.com/repos/Iconica-Development/flutter_image_progression/tree/master/example) |  |
| flutter_input_library | 3.3.0 | 2024-4-30 | No | No | [code](https://github.com/Iconica-Development/flutter_input_library) | [example](https://api.github.com/repos/Iconica-Development/flutter_input_library/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_input_library/index.html) |
| flutter_introduction | 3.0.0 | 2024-4-24 | Yes | No | [code](https://github.com/Iconica-Development/flutter_introduction) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_introduction/index.html) |
| flutter_introduction_firebase | 1.1.0 | 2023-11-25 | No | No | [code](https://github.com/Iconica-Development/flutter_introduction_firebase) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_introduction_firebase/index.html) |
| flutter_introduction_interface | 1.0.0 | 2023-6-1 | No | No | [code](https://github.com/Iconica-Development/flutter_introduction_interface) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_introduction_interface/index.html) |
| flutter_introduction_service | 1.0.0 | 2023-6-1 | No | No | [code](https://github.com/Iconica-Development/flutter_introduction_service) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_introduction_service/index.html) |
| flutter_introduction_shared_preferences | 1.0.0 | 2023-6-1 | No | No | [code](https://github.com/Iconica-Development/flutter_introduction_shared_preferences) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_introduction_shared_preferences/index.html) |
| flutter_introduction_widget | 4.0.0 | 2023-11-4 | No | No | [code](https://github.com/Iconica-Development/flutter_introduction_widget) | [example](https://api.github.com/repos/Iconica-Development/flutter_introduction_widget/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_introduction_widget/index.html) |
| flutter_login_service | 3.0.0 | 2024-4-23 | Yes | No | [code](https://github.com/Iconica-Development/flutter_login_service) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_login_service/index.html) |
| flutter_login_widget | 6.0.2 | 2024-4-19 | No | No | [code](https://github.com/Iconica-Development/flutter_login_widget) | [example](https://api.github.com/repos/Iconica-Development/flutter_login_widget/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_login_widget/index.html) |
| flutter_map |  | 2024-4-11 | No | No | [code](https://github.com/Iconica-Development/flutter_map) | [example](https://api.github.com/repos/Iconica-Development/flutter_map/tree/master/example) |  |
| flutter_map_animations |  | 2024-3-22 | No | No | [code](https://github.com/Iconica-Development/flutter_map_animations) | [example](https://api.github.com/repos/Iconica-Development/flutter_map_animations/tree/master/example) |  |
| flutter_media_picker | 0.6.3 | 2024-3-4 | No | No | [code](https://github.com/Iconica-Development/flutter_media_picker) | [example](https://api.github.com/repos/Iconica-Development/flutter_media_picker/tree/master/example) |  |
| flutter_menu | 0.0.3 | 2024-3-4 | No | No | [code](https://github.com/Iconica-Development/flutter_menu) | [example](https://api.github.com/repos/Iconica-Development/flutter_menu/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_menu/index.html) |
| flutter_multi_child_animated_switcher | 0.0.2 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_multi_child_animated_switcher) | [example](https://api.github.com/repos/Iconica-Development/flutter_multi_child_animated_switcher/tree/master/example) |  |
| flutter_nested_categories | 0.0.1 | 2024-4-8 | No | No | [code](https://github.com/Iconica-Development/flutter_nested_categories) | [example](https://api.github.com/repos/Iconica-Development/flutter_nested_categories/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_nested_categories/index.html) |
| flutter_notification_center | 1.3.1 | 2024-4-30 | No | No | [code](https://github.com/Iconica-Development/flutter_notification_center) |  |  |
| flutter_profile | 1.4.0 | 2024-4-30 | No | No | [code](https://github.com/Iconica-Development/flutter_profile) | [example](https://api.github.com/repos/Iconica-Development/flutter_profile/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_profile/index.html) |
| flutter_rbac | 2.2.1 | 2024-4-2 | Yes | No | [code](https://github.com/Iconica-Development/flutter_rbac) |  |  |
| flutter_registration | 2.0.4 | 2024-4-22 | No | No | [code](https://github.com/Iconica-Development/flutter_registration) | [example](https://api.github.com/repos/Iconica-Development/flutter_registration/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_registration/index.html) |
| flutter_roadmap_component |  | 2024-2-29 | No | No | [code](https://github.com/Iconica-Development/flutter_roadmap_component) | [example](https://api.github.com/repos/Iconica-Development/flutter_roadmap_component/tree/master/example) |  |
| flutter_roles_archived | 0.0.3 | 2022-12-14 | No | No | [code](https://github.com/Iconica-Development/flutter_roles_archived) |  |  |
| flutter_roster | 2.6.0 | 2024-2-14 | No | No | [code](https://github.com/Iconica-Development/flutter_roster) | [example](https://api.github.com/repos/Iconica-Development/flutter_roster/tree/master/example) |  |
| flutter_settings | 2.0.0 | 2024-4-30 | No | No | [code](https://github.com/Iconica-Development/flutter_settings) | [example](https://api.github.com/repos/Iconica-Development/flutter_settings/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_settings/index.html) |
| flutter_shopping_cart | 1.0.0 | 2024-4-23 | No | No | [code](https://github.com/Iconica-Development/flutter_shopping_cart) | [example](https://api.github.com/repos/Iconica-Development/flutter_shopping_cart/tree/master/example) |  |
| flutter_single_character_input | 0.0.3 | 2024-3-5 | No | No | [code](https://github.com/Iconica-Development/flutter_single_character_input) | [example](https://api.github.com/repos/Iconica-Development/flutter_single_character_input/tree/master/example) |  |
| flutter_splashscreen |  | 2022-11-1 | No | No | [code](https://github.com/Iconica-Development/flutter_splashscreen) | [example](https://api.github.com/repos/Iconica-Development/flutter_splashscreen/tree/master/example) |  |
| flutter_start | 4.0.0 | 2024-4-19 | No | Yes | [code](https://github.com/Iconica-Development/flutter_start) | [example](https://api.github.com/repos/Iconica-Development/flutter_start/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_start/index.html) |
| flutter_stepper | 2.2.0 | 2024-3-5 | No | No | [code](https://github.com/Iconica-Development/flutter_stepper) | [example](https://api.github.com/repos/Iconica-Development/flutter_stepper/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_stepper/index.html) |
| flutter_thermal_printer | 0.0.1 | 2024-4-30 | No | No | [code](https://github.com/Iconica-Development/flutter_thermal_printer) | [example](https://api.github.com/repos/Iconica-Development/flutter_thermal_printer/tree/master/example) |  |
| flutter_timeline | 3.0.1 | 2024-4-30 | Yes | Yes | [code](https://github.com/Iconica-Development/flutter_timeline) |  | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_timeline/index.html) |
| flutter_timetable | 1.4.0 | 2024-3-19 | No | No | [code](https://github.com/Iconica-Development/flutter_timetable) | [example](https://api.github.com/repos/Iconica-Development/flutter_timetable/tree/master/example) |  |
| flutter_to_do_list | 0.2.1 | 2024-3-5 | No | No | [code](https://github.com/Iconica-Development/flutter_to_do_list) | [example](https://api.github.com/repos/Iconica-Development/flutter_to_do_list/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_to_do_list/index.html) |
| flutter_user | 4.0.1 | 2024-4-26 | No | Yes | [code](https://github.com/Iconica-Development/flutter_user) | [example](https://api.github.com/repos/Iconica-Development/flutter_user/tree/master/example) | [docs](https://iconica-development.github.io/iconica_component_documentation/Iconica-Development-flutter_user/index.html) |
