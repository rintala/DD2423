# Comments lab3

- Iterations

  - Many times 20-30 iterations ok

- Questions encourage exploring the areas - hard to give exact answers

- Important - how different methods work themselves, weaknesses, when use one and another

  - How do we set the different parameters?
    - If change this param => this happens
    - Some relations - but not crystal clear



- Delad apelsin är svår

- Färg som avgör superpix?

  - boundary?
  - Where do we use "seed" in kmeans_segm?


- **K-means**
  - not labeled training data - only data => split in three ex.
  - K determines how many splits we split it into
  - Number of K's dependent on situation (our image)
  - A certain K could lead to oversplitting in some situations, in others not
  - Run K-means a few times, with different starting positions => get better split
  - Sometimes instead of random - we pick to points
    - If we pick bad points => could be a problem
    - K-means ++
    - If randomization chooses point along same line, but further away, it will just take longer to converge
  - **General idea:** 
    - We have an initial guess on how to separate the data
    - We separate it 
    - Re-calculate centers of those regions
    - Repeat process - try to converge on a good separation
  - Move points into one of the two regions => recalculate the centers
  - Will tell us => which pixels belongs to what classes, but also what are the colors of those classes
  - IF we want to compress image - split into K-clusters - 16 - will pick those dominant colors