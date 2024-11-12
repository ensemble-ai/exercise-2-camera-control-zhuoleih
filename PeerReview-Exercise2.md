# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Timothy Ha
* *email:* tdha@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera is correctly centered on the vessel and the cross is correctly drawn in the center of the screen when draw_logic is enabled.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera is correctly autoscrolling at a constant speed and the vessel is able to move within the box. When the vessel is lagging behind and touches the left edge, the vessel is correctly being dragged along by the edge of the autoscroll camera box. The autoscroll box is correctly drawn when draw_logic is enabled.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera correctly follows the player with an appropriate follow_speed where the player is in front of the camera. When the player stops moving, the camera correctly uses catchup_speed to move to the camera's location. The distance between the camera and player never exceeds leash distance for both normal speed and hyper speed. The cross is correctly drawn when draw_logic is enabled. I liked how they used is_equal_approx when comparing distance and leash_distance instead of exactly comparing the values to handle any potential lagging issues with the way _process updates in Godot. 

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The center of the camera correctly leads in front of the player when the player makes a direction input. When the player stops moving, the camera correctly waits the specified delay time before moving back to the player's position. The leash distance between the camera and player correctly remains within leash_distance for both normal and hyper speed. I liked how simple and easy to follow their implementation was with the use of the move_toward function, since it is something that I didn't consider in my own implementation.  

___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The player correctly moves with the push ratio when it is between the speedup zone and the pushbox border and not touching the edges of the outer box border. The implementation of the player's speed in the direction of the side of the outerbox and the push ratio enacting on the player in the opposite direction works well. The player correctly moves at regular / full speed when it is in the corner. The camera correctly does not move when the player moves within the inner box. I liked how clear and neat the implementation was, breaking it down between the horizontal movement and then the vertical movement, since it was easy for me to follow their logic even without comments. 

___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
There were only a few minor infractions that are simple fixes which were mostly related to blank lines.
* [Line length is over 100 characters long.](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/4way_speedup_push_zone.gd#L25) - A line break can be used to keep it within 100 characters.
* [Functions should be surrounded by two blank lines instead of just one](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/position_lock.gd#L5). [Same thing here](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/auto_scroll.gd#L11).
* [Only 1 blank line instead of 2 is needed between consts and export variables](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/lerp_smoothing_target_focus.gd#L5). [Same thing here](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/position_lock_with_smoothing.gd#L5).
* [Unnecessary blank line between export variables](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/4way_speedup_push_zone.gd#L6)


#### Style Guide Exemplars ####
I liked how student made use of [constant variables](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/position_lock_with_smoothing.gd#L4) and correctly placed them before the export variables. I also liked how the student correctly named the [private variables with an underscore at the beginning](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/lerp_smoothing_target_focus.gd#L12). From what I can tell, besides from the few instances of infractions related to blank lines, the student followed the rest of the style guide well. 

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

* It would be best practice to remove [unncessary or unrelated comments of code to the current implementation before submitting](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/auto_scroll.gd#L32). [Same thing here.](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/position_lock_with_smoothing.gd#L26) - They left comments of a previous implementation under their correct and current implementation.
* [It would be best practice to add comments](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/lerp_smoothing_target_focus.gd#L14), even if they are brief, simply describing generally what you are doing in your implementation. There were generally no comments describing your code. Although the logic and code was easy to follow, it would be more helpful for your reader if there were comments to quickly understand what you are doing. 

#### Best Practices Exemplars ####
I really liked how the student separated chunks of code with a blank line, making it a lot easier for me to read and follow their implentation. [For example, they separated the instantiation of variables and their implementation of the horizontal speedup with a blank line](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/4way_speedup_push_zone.gd#L21). They also used [clear variable names](https://github.com/ensemble-ai/exercise-2-camera-control-zhuoleih/blob/master/Obscura/scripts/camera_controllers/position_lock_with_smoothing.gd#18) which made it very easy for me to understand what each of the variables were for in the calculations. 
