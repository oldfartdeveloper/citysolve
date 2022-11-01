include "globals.mzn";

% Solve my city puzzle
int: k; % number of dimensions in a 2 D plane
int: nObjects; % number of pieces
int: nRectangles; % number of unique rectangles
                  % needed to design all shapes
int: nShapes; % number of shapes needed for all
              % possible rotations for each shape
array[OBJECTS] of set of SHAPES: valid_shapes;

set of int: DIMENSIONS = 1..k;
set of int: OBJECTS    = 1..nObjects;
set of int: RECTANGLES = 1..nRectangles;
set of int: SHAPES     = 1..nShapes;

array[DIMENSIONS] of int:             l;
array[DIMENSIONS] of int:             u;
array[RECTANGLES,DIMENSIONS] of int:  rect_size;
array[RECTANGLES,DIMENSIONS] of int:  rect_offset;
array[SHAPES] of set of RECTANGLES:   shape;
array[OBJECTS,DIMENSIONS] of var int: x;
array[OBJECTS] of var SHAPES:         kind;

constraint forall (obj in OBJECTS) (
    kind[obj] in valid_shapes[obj]
);

constraint forall (obj in OBJECTS) (geost_bb(k,
                                             rect_size,
                                             rect_offset,
                                             shape,
                                             x,
                                             kind,
                                             l,
                                             u
                                            )
                                   );

solve satisfy;