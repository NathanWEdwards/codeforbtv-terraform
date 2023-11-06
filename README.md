## Dependencies
### gcloud
gcloud is assumed to have be installed and authenticated with application-default login enabled, on the organization one wishes to use for provisioning. New projects provisioned with the _google_project_ Terraform resource must be associated with an organization.

Additionally, when provisioning Firebase related products, the authenticated account must have accepted the Firebase Terms of Service.

The user or service account that is authenticated to gcloud when creating a _google_project_ resource must have roles/resourcemanager.projectCreator on the specified organization.

Additionally, roles/appengine.deployer privileges must be granted.

## Top-level Modules
#### Firebase
Provisions a new Google project with one or two storage buckets, Firestore, and Firebase hosting.

An 'Events' collection in Firestore is indexed.