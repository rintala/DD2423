# Answers to questions in Lab 2: Edge detection & Hough transform

**Name:** Jonathan Rintala                                                       					**Program:** TIEMM, MAIG



**Instructions**: Complete the lab according to the instructions in the notes and respond to the questions stated below. Keep the answers short and focus on what is essential. Illustrate with figures only when explicitly requested.

Good luck!

---



## 1. Difference operators

**Question 1**: What do you expect the results to look like and why? Compare the size of *dxtools* with the size of *tools*. Why are these sizes different? 

**Answers:**

*dxtools:* Will show fluctuations in derivative on x-axis. Thus, there would be more clear edges facing horizontally here. ===

*dytools:* Will show fluctuations in derivative on y-axis. Thus, there would be more clear edges facing vertically here. | | |

Since we use the sobel operator, with the two 3x3 kernels:

![sobel_operator](img/sobel_operator.png)

These two kernels are convolved with the image, and by we will thus get one approximation of the horizontal changes in derivative and one approx. of the vertical changes in derivative.

Comparing the size of tools and dxtools:

```{matlab}
size(tools) = 256 256
size(dx_tools) = 254 254
```

Thus, we loose 2x2 pixels in size, when convolving the image with the Sobel kernels. The reason being, we cannot compute the approx of derivative at the edges. Thus, we pass in the 'valid'-parameter into the conv2.

```{matlab}
help conv2
/../
'valid' - returns only those parts of the convolution that are computed without the zero-padded edges. 
/../
```



---

**Question 2**: Is it easy to find a threshold that results in thin edges? Explain why or why not! 

 

Answers:

 

___________________________________________________________________________

 

**Question 3**: Does smoothing the image help to find edges? 

 

Answers:

 

___________________________________________________________________________

 

**Question 4**: What can you observe? Provide explanation based on the generated images. 

 

Answers:

 

___________________________________________________________________________

 

**Question 5**: Assemble the results of the experiment above into an illustrative collage with the *subplot* command. Which are your observations and conclusions? 

 

Answers:

 

___________________________________________________________________________

 

**Question 6**: How can you use the response from *Lvv* to detect edges, and how can you improve the result by using *Lvvv*? 

 

Answers:

 

___________________________________________________________________________

 

**Question 7**: Present your best results obtained with *extractedge* for *house* and *tools*. 

 

Answers:

 

___________________________________________________________________________

 

**Question 8**: Identify the correspondences between the strongest peaks in the accu-mulator and line segments in the output image. Doing so convince yourself that the implementation is correct. Summarize the results of in one or more figures. 

 

Answers:

 

___________________________________________________________________________

 

**Question 9**: How do the results and computational time depend on the number of cells in the accumulator? 

 

Answers:

 

___________________________________________________________________________

 

**Question 10**: How do you propose to do this? Try out a function that you would suggest and see if it improves the results. Does it?

 

Answers:

 

___________________________________________________________________________

 

 

 

 