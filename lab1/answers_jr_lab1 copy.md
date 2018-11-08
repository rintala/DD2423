#Answers to questions in Lab 1: Filtering operations

**Name:** Jonathan Rintala                                                       					**Program:** TIEMM, MAIG

**Instructions**: Complete the lab according to the instructions in the notes and respond to the questions stated below. Keep the answers short and focus on what is essential. Illustrate with figures only when explicitly requested.

Good luck!

---

**Question 1**: Repeat this exercise with the coordinates p and q set to (5, 9), (9, 5), (17, 9),

(17, 121), (5, 1) and (125, 1) respectively. What do you observe?

**Answers:**

My observations are:

- The placement of the dot determines the waves’ directions

- Distance to origin (upper left corner) from dot, determines the frequency, i.e. a dot close to the origin will yield a lower frequency, which can be observed by waves with longer wavelength, than a dot far away **(if not a multi)**

- Placing a dot on the x-axis yields vertical waves

- Placing a dot on the y-axis yields horizontal waves i.e. (125,1) or (5,1) 

- Placing a dot on other coordinates yields diagonal waves

---

**Question 2**: Explain how a position (p, q) in the Fourier domain will be projected as a sine wave in the spatial domain. Illustrate with a Matlab figure. 

**Answers:**

![../../../screenshots/Screenshot%202018-11-05%20at%2021.15.10.png](file://localhost/Users/jonathanrintala/Library/Group%20Containers/UBF8T346G9.Office/msoclip1/01/clip_image002.png)

![../../../screenshots/Screenshot%202018-11-05%20at%2021.17.10.png](file://localhost/Users/jonathanrintala/Library/Group%20Containers/UBF8T346G9.Office/msoclip1/01/clip_image004.png)



<div style="text-align:left">
<img src="img/1.png" height="200px"  />
<img src="img/q3_imag_3D.png" height="350px" />
</div>
***Figures*** - Displaying the imaginary part of the projection of the Fourier domain position (5,1) => the spatial domain. Visualizations in 2D resp. 3D.



---

**Question 3**: How large is the amplitude? Write down the expression derived from Equation (4) in the notes. Complement the code (variable amplitude) accordingly.

![2](/Users/jonathanrintala/Desktop/bildat18/labs/lab1/img/2.png)

​	![../../../screenshots/Screenshot%202018-11-05%20at%2021.15.10.png](file://localhost/Users/jonathanrintala/Library/Group%20Containers/UBF8T346G9.Office/msoclip1/01/clip_image002.png)

=> Euler's formula for conversion to sine and cosine => 

**Answers:**



---

**Question 4**: How does the direction and length of the sine wave depend on p and q? Write down the explicit expression that can be found in the lecture notes. Complement the code (variable wavelength) accordingly.

**Answers:**

(1) Wavelength from lecture 03, page 22: $\lambda = \frac{2*\pi}{||(w)||}= \frac{2*{\pi}}{\sqrt{w_1^2 +w_2^2}}$

(2) Phase (angle) of the Fourier transformation, from lecture 03, page 25:

​	$\phi(w_1,w_2) = tan^{−1} \frac{Im(w1,w2)}{Re(w1,w2)}$

(5) Def. from lab description: $w_D = \frac{2*\pi*u}{N}$

- Since we are calculating an angle, we should use the centered coordinates, i.e.
  - u = uc
  - v = vc
- With number of pixels: N = sz

- Thus, we are getting the following expression for lambda using (1) and (5):

  $\lambda = \frac{2*pi}{\sqrt{(\frac{2*pi*uc}{sz})^2} + \sqrt{(\frac{2*pi*vc}{sz})^2}}$

- In MATLAB:

  ```{matlab}
  w_1 = sqrt(2pi*uc)/sz;
  w_2 = sqrt(2pi*vc)/sz;
  wavelength = 2*pi/(w_1^2+w_2^2)
  ```



------

**Question 5**: What happens when we pass the point in the center and either p or q exceeds half the image size? Explain and illustrate graphically with Matlab!

 

**Answers:**

The Matlab fftshift works as explained by the help function:

```{matlab}
>> help fftshift
	"fftshift Shift zero-frequency component to center of spectrum. /../ 	  For matrices, fftshift(X) swaps the first and third quadrants and 	 the second and fourth quadrants."
```

This moves the default origin of the upper left corner, to instead having the center of the spectrum being the Fourier transform's center; which means we have to calculate the new position of the point **relative to** the new origin of the center. A point (p,q) that has passed the center i.e. having either $p > sz/2$ OR q > sz/2 will thus get its position according to:

- $uc = u-1-sz$

- $vc = v -1 - sz$


This can be illustrated with the figures below:

<div>
    <img src="img/q5_original_1.png" height="300px"  />
	<img src="img/q5_centered_1.png" height="300px" />
</div>


______________________________________________________________________

 

**Question 6**: What is the purpose of the instructions following the question *What is done by these instructions?* in the code?

 

Answers:

 

___________________________________________________________________________

 

**Question 7**: Why are these Fourier spectra concentrated to the borders of the images? Can you give a mathematical interpretation? Hint: think of the frequencies in the source image and consider the resulting image as a Fourier transform applied to a 2D function. It might be easier to analyze each dimension separately!

 

Answers:

 

___________________________________________________________________________

 

**Question 8**: Why is the logarithm function applied?

 

Answers:

 

___________________________________________________________________________

 

**Question 9**: What conclusions can be drawn regarding linearity? From your observations can you derive a mathematical expression in the general case?

 

Answers:

 

___________________________________________________________________________

 

**Question 10**: Are there any other ways to compute the last image? Remember what multiplication in Fourier domain equals to in the spatial domain! Perform these alternative computations in practice.

 

Answers:

 

___________________________________________________________________________

 

**Question 11**: What conclusions can be drawn from comparing the results with those in the previous exercise? See how the source images have changed and analyze the effects of scaling.

 

Answers:

 

___________________________________________________________________________

 

**Question 12**: What can be said about possible similarities and differences? Hint: think of the frequencies and how they are affected by the rotation.

 

Answers:

 

___________________________________________________________________________

 

**Question 13**: What information is contained in the phase and in the magnitude of the Fourier transform?

 

Answers:

 

___________________________________________________________________________

 

**Question 14**: Show the impulse response and variance for the above-mentioned t-values. What are the variances of your discretized Gaussian kernel for t = 0.1, 0.3, 1.0, 10.0 and

100.0?

 

Answers:

 

___________________________________________________________________________

 

**Question 15**: Are the results different from or similar to the estimated variance? How does the result correspond to the ideal continuous case? Lead: think of the relation between spatial and Fourier domains for different values of t.

 

Answers:

 

___________________________________________________________________________

 

**Question 16**: Convolve a couple of images with Gaussian functions of different variances (like t = 1.0, 4.0, 16.0, 64.0 and 256.0) and present your results. What effects can you observe?

 

Answers:

 

___________________________________________________________________________

 

**Question 17**: What are the positive and negative effects for each type of filter? Describe what you observe and name the effects that you recognize. How do the results depend on the filter parameters? Illustrate with Matlab figure(s).

 

Answers:

 

___________________________________________________________________________

 

**Question 18**: What conclusions can you draw from comparing the results of the respective methods? 

 

Answers:

 

___________________________________________________________________________

 

**Question 19**: What effects do you observe when subsampling the original image and the smoothed variants? Illustrate both filters with the best results found for iteration i = 4.

 

Answers:

 

___________________________________________________________________________

 

**Question 20**: What conclusions can you draw regarding the effects of smoothing when combined with subsampling? Hint: think in terms of frequencies and side effects.

 

Answers:

 

___________________________________________________________________________

 