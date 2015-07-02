Funded by NSF DMS-1418911. 

Vector Field Manifold Visualization
===================================

This project contains the files necessary to compute the stable or unstable manifold of a vector field using matlab, and then create a vtk file to be read by paraview for visualization. Specifically, we consider the system du/dt=F(u(t)), where u(t)=(x(t),y(t),z(t)) with a fixed point where F(fixed point) = 0. In the case of a stable manifold, we find the set of points such that as t->infinity, u(t) -> the fixed point. In the case of the unstable manifold, we find the set of points such that as t->negative_infinity, u(t) -> the fixed point.

Instructions
------------

- Please visit http://dlithio.github.io/2DOptiMan/ for instructions on use.

"Any opinions, findings, and conclusions or recommendations
expressed in this material are those of the author(s) and do
not necessarily reflect the views of the National Science Foundation."
