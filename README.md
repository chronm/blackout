# Blackout
Blackout helps you keep track of your supplies.

[German translation](./README-DE.md)

## Videos
- [Setup] [YoutubeSetup]
- [Add product to group] [YoutubeGroupForProduct]
- [Barcode scanning] [Youtube scanning]

## What do you have to do for it?
Download the app [here][ReleaseApk] and open it. You may have to activate the setting ["Allow Apps from unknown sources"][AppsFromUnknownSources], because Blackout is not installed via the Google Play Store.

Blackout needs some information from the user:
* first the permission to access the store is requested. With this permission, the database is stored in a location accessible to the user. This allows the database to be easily backed up and restored.
* with the password in the next step the database is encrypted
* Username and household name are currently a mere formality, but will be required in the future when several participants share a household
  
## How does it work?
All your supplies are organized in groups, products and batches.

In what?

### Products
A product *may* have the following characteristics:
* Product description
* Product code (barcode)
* Warning period
* Unit
* desired minimum quantity
* [Group](#Groups)

When you add a product to a group, the product takes the warning period and unit of the group and the minimum quantity is deactivated.

### Groups
Groups are made up of:
* Name
* Plural name
* Warning period
* Unit
* Minimum quantity

### Batches
A batch is what you have physically bought, cooked or baked. It merely consists of an expiration date.

### Example?
You buy eggs at the supermarket:

+- [Group](#Groups)  
&nbsp;&nbsp;+- Name: Ei  
&nbsp;&nbsp;+- Plural name: Eggs  
&nbsp;&nbsp;+- Warning period: P1W  
&nbsp;&nbsp;+- unit: unitless  
&nbsp;&nbsp;+- Minimum quantity: 5  
&nbsp;&nbsp;+- [Product](#Products)  
&nbsp;&nbsp;&nbsp;&nbsp;+- Description: Free-range eggs 10 size M  
&nbsp;&nbsp;&nbsp;&nbsp;+- Product code: 1234567891011  
&nbsp;&nbsp;&nbsp;&nbsp;+- [Batch](#Batches)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+- Best before date: 11.11.2022  
 
So you want to have at least 5 eggs, and you will be informed of this 1 week before the best before date.

### The daily use
On the start screen you can simply scan a barcode, and you will automatically be directed to the corresponding product. There you can either add a batch or select an existing one. You can then add or remove something from the batch.

[//]: Links

[AppsFromUnknownSources]: https://www.tutonaut.de/anleitung-android-apps-unbekannten-quellen-installieren/
[ReleaseApk]: https://github.com/chronm/blackout-mobile/releases/download/v0.3.0/Blackout.apk
[YoutubeSetup]: https://youtu.be/HOT-Ulg2F5Y
[YoutubeGroupForProduct]: https://youtu.be/1XfV_ERdzXQ
[Youtube scanning]: https://youtu.be/tfTFRvXBfPA
