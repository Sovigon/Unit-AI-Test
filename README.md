# AI Behavior Project

The goal of this project is to explore different AI behavior structures and formulas, to create an interactive sandbox for modifying or developing new behaviors and action, and to use this understanding for future projects.

## Dependencies

**- Godot 4.x**: The current scope of this project is completely maintained within a Godot project and uses the GDScript language.

## Installing and Executing

**- Download Godot for Free Here:** https://godotengine.org/download/

**- Open Godot and Assign Project Folder**

**- Use CLI Command In Project Folder Directory:** `git clone https://github.com/Sovigon/Unit-AI-Test`

**- Refresh Godot Project List and Run `Unit AI Test`**

## Current Project Structure

The project is currently split into `Data`, `Managers`, and `Scenes`. `Data` contains the Resource scripts and the different folders containing each defined `.res` file. `Managers` contains the Manager folders that has their scenes and scripts. `Scenes` contains the parent and child scenes to be placed in the world.

### Currently Implemented

#### Data

> - **Behaviors:** Hunger can be tracked and ticks up at regular intervals, and properly reduces when the Noodle eats food.
> - **Actions:** `GetFood` is properly set up to read the current world items and direct the Noodle to the position of the nearest `Food` item.
> - **Other Data:** The proper `*Info` scripts have been made to manage the metadata of the world and its objects, allowing cross-referencing and proper signalling.

#### Managers

> - **WorldManager:** WorldManager properly places food items and attaches info from Items and Noodles to the `WorldInfo` suppository resource.

#### Scenes

> - **Food:** Hitbox and signals are properly set up to trigger an appropriate response from Noodle.
> - **Noodle:** Can properly manage the signals and calls from the world and its actions / behaviors. Movement is uniform and predictable.

### Future Features

#### Data

> - **Behaviors:** Add in and / or configure behaviors for boredom (to create deviations), fear (for threat response), energy (for sleepiness), and cooperation (for helping in group projects). Also explore behavior curves again, instead of arbitrary values.
> - **Actions:** Create multi-behavior actions, as well as different triggers and outcomes. Add in multi-destination support and chained actions.
> - **Entities:** Implement entities to avoid as threats or to interact with for resources.
> - **Items:** Most of this work will be done to support the work of other focus points; however, the three main ways of interacting with items - Store (inventory), Carry, or Consume - should have a generalized structure.
> - **Other Data:** Others files will be created as necessary and their trajectory is not fully defined. Some parts, like `WorldInfo`, can be expanded upon now, but are being put on another iteration of the roadmap. When the `MenuManager` is being created, the different menus will be placed in a new folder in `Data`.

#### Managers

> - **WorldManager:** Mostly reactive, and will have its configurations offloaded to `WorldInfo`.
> - **MenuManager(ToBeImplemented):** Normally used for a more full product later on in the cycle, its main use right now will be to help connect and cycle through the other menu-based managers.
> - **DebugManager(ToBeImplemented):** Will be used for standard debugging practices such as checking and monitoring individual or group-based entities, as well as forcefully changing states.
> - **EntityManager(ToBeImplemented):** Will be in charge of coordinating groups of entities to allow them to be more cognizant of one another and try to share and work towards common tasks. Planning on creating `Coordinator` nodes to tie Entities to so it can help direct actions. ***More literature is needed for this implementation.***
> - **Other Managers:** Scene and Network managers can be implemented for coordinating managers and allowing multiplayer testing respectively. Further details are for later roadmap iterations and their implementation is not guaranteed.

#### Scenes

> - **Item(Super of Food):** Will create a generic of the Item class so that their behavior can be more predictable to entities. Besides the currently implemented `Food`, `Wood` and `Stone` are also planned to help with resource management for entities.
> - **Entity(Super of Noodle):** A generic Entity will be created to give a more unified approach to behavior and action management.
> - **Worlds:** Mostly will be creating more interesting layouts to test navigation and present unique challenges.
> - **Other Scenes**: The only other scenes that are planned are `WorldObject` which will be objects like trees, rocks, and structures, that may provide a behavior modifier or resource generation.

#### Assets (ToBeImplemented)

Assets will generally be grouped up similarly to `Scenes` and will be addressed when the project has gotten more visually complicated as to warrant placeholder assets for clarity or vision.


## Completion Thresholds


### 🥉Alpha Foundation ✅

The Alpha Foundation implements one behavior and one action with one entity (`Noodle`) properly fulfilling its behavioral need with said action using world elements.

### 🥈Beta Features ⚒️

The Beta Features should allow multiple behaviors and actions to interact at the same time with proper prioritization; there should also be multiple `Noodle` entities present at the same time, with world interactions ironed out between them, as well as being able to be monitored and debugged manually.

### 🥇Final Implementation

The Final Implementation should allow multiple `Noodle` to have group actions and behaviors to accomplish certain goals and impact the world together; multiple worlds should be made to demonstrate different environments that these actions and behaviors intermingle with.
