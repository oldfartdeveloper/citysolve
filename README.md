# README

## Purpose

I have a wooden puzzle that consists of a square base and buildings that are to be arranged on it.  All of the buildings only fit on it if they are arranged precisely; the object of the puzzle is to figure out what the arrangement needs to be.

Needless to say, I suck at this puzzle, and this is my attempt to write a computer program to solve it.

## Description of Puzzle Pieces

Here are the puzzle pieces grouped by piece shape:

![piece shapes](/images/definitions/puzzelImage.jpg)

Here are the same pieces with names added:

![piece parts](/images/definitions/puzzleParts.jpeg)

## Description of Puzzle Parts

The puzzle consists of the board and **12** pieces:

### Board

The board defines a **7** x **7** cell matrix upon which the pieces must all be arranged.

### Tee

A **tee** is shaped like a flattend "T" character and occupies 4 places in the matrix as follows:

![tee](/images/definitions/tee.png)

There are **3** of these.

### Ell

An **ell** looks like an "L":

![ell](/images/definitions/ell.png)

There are **3** of these.

### LEll

A **lell** looks like a reversed "L" (i.e. the 'foot' is facing *left*):

![lell](/images/definitions/rell.png)

There is only **1** of these.

### Left

A **left** looks like it zigzags *left* then straightens out:

![left](/images/definitions/left.png)

There are **2** of these.

### Rite

A **right** looks like it zigzags *right* then straightens out:

![rite](/images/definitions/right.png)

There are **2** of these.

### Plus

A **plus** has a center and 4 spokes:

![plus](/images/definitions/plus.png)

There is only **1** of these and it is unusual in that it *only has one unique position*.

## Strategy

After thinking about this A LOT, here's my my approach:

### Rules

1. Preorder the list of pieces to try in order.

1. Find the first piece that fits in the top-left cell of the board.  If rotating the piece's orientation helps it to fit, then do so.

1. Similarly find the next piece that fits the next cell to the right without violating the board's boundary, nor overlap the previously-placed piece to its left

1. Repeat this process for the remainder of the first row so that:

    1. All the cells in the first row are filled.

    1. No pieces overlap each other.

    1. None of the pieces placements spill outside the board's boundary.

1. Repeat for the remaining rows.

1. When you cannot find a piece to play, backup to the previous piece (including the previous row) and see if any of the following work:

    1. Can the previous piece be reoriented successfully?  If so, keep it in its new orientation and solve the next piece.

    1. If not, select the next available piece type and see if you can replace the current piece with it.  If so, keep the replacement.  If not, repeat this process for the "previous previous" piece.

1. The currently played pieces are on a stack.  When you get stuck, you back up the stack to a piece orientation or type that you haven't tried yet in that stack position and try that.

1. When the stack contains all the pieces and no cells are left unoccupied, then the game is solved.

*I get the idea above, but it needs polishing.*

### Rules Implications

For each piece, it is always placed on the board in the topmost leftmost open square.  That means that, for each of a piece's orientations, the piece's top square must be the one placed in the board's current topmost leftmost open square.  This is because all other squares in the piece cannot be placed there because they will possibly:

1. Overlap a board square that has already been filled by a previous-placed piece.

1. Spill outside the board's playing area.

If the piece has more than one topmost square for a given orientation, then the only one that can be used is the leftmost top square.  This is because any other top square, by definition, would either overlap a previous piece's square or would spill outside the board's playing area.

## Each stack position defines a piece type and its orientation

So we need to define the notion of how orientation is used.

* Should we just associate and enumeration with each possible orientation for the piece type?

    1. The "T's", "L's" and "Z's" each have 4 possible orientations.  So when we need to update a type, before we do we have to step through the existing candidate through each of its candidate orientations first.

    1. Each orientation needs to have the associated topleft position to determine how to assign the piece.

Here are the orientation candidates for each of the pieces:

### Left Orientations

| **1**                                     | **2**                                     |
|-------------------------------------------|-------------------------------------------|
| ![leftPos1](/images/orientations/left/1.png) | ![leftPos2](/images/orientations/left/2.png) |

### Rite Orientations

| **1**                                      | **2**                                      |
|--------------------------------------------|--------------------------------------------|
| ![rightPos1](/images/orientations/rite/1.png) | ![rightPos2](/images/orientations/rite/2.png) |

### Tee Orientations

| **1**                                | **2**                                | **3**                                | **4**                                |
|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|
| ![tee1](/images/orientations/tee/1.png) | ![tee2](/images/orientations/tee/2.png) | ![tee3](/images/orientations/tee/3.png) | ![tee4](/images/orientations/tee/4.png) |

### Plus Orientation

Only one:

![plus](/images/orientations/plus/1.png)

### Ell Orientations

| **1**                                | **2**                                | **3**                                | **4**                                |
|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|
| ![ell1](/images/orientations/ell/1.png) | ![ell2](/images/orientations/ell/2.png) | ![ell3](/images/orientations/ell/3.png) | ![ell4](/images/orientations/ell/4.png) |

### LEll Orientations

| **1**                                  | **2**                                  | **3**                                  | **4**                                  |
|----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|
| ![lell1](/images/orientations/lell/1.png) | ![lell2](/images/orientations/lell/2.png) | ![lell3](/images/orientations/lell/3.png) | ![lell4](/images/orientations/lell/4.png) |
