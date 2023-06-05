RTL implementation of a full-scale elevator controller that is composed of two main modules: control unit and request genertor.

![image](https://user-images.githubusercontent.com/107650627/209875974-c6ca6e6b-62c2-4923-bd0a-510305565979.png)

## Overview
The specifications of the implemented control unit are:
  1) Move the elevator up or down to reach the requested floor.
  2) Once at the requested floor, it opens the door for at least 2 seconds, depending whether there are queued requests.
  3) The door is never open while moving.
  4) Never change directions unless there are no higher requests when moving up or no lower requests when moving down.
  5) The controller is using the 50 MHz clock on DE0-CV board.
  6) The controller is designed to serve up to 10 floors (0 is the ground floor and 9 is the highest floor).
  7) The floor output is connected to a seven-segment display through a binary to SSD converter.
  
## Assumptions
  - The elevator moves from one floor to another in 2 seconds.
  - 1 sec clock enable is used to the timer for the elevator movement and the opening of the door.

## Behavioral Simulation

![image](https://user-images.githubusercontent.com/107650627/209708781-d81cd393-16ee-4bf1-93ad-f26e2d44bff2.png)

The design was loaded and verified on a DE0-CV FPGA.

## Lab Results

![image](https://user-images.githubusercontent.com/107650627/209712760-0b151a6e-f4ba-4b93-b736-72db35ec1f1d.png)
![image](https://user-images.githubusercontent.com/107650627/209712793-c912ab6f-8c36-4305-8a3d-60cbeefd9241.png)
