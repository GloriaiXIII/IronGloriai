# READ ME!

# OPTIONAL LAB |  Matplotlib mice db and Seaborn visualization
Week_4   
Two optional labs using Jupyternotebook in order to improve the knowledge on Matplotlib and Seaborn libraries. 

## Matplot | The Power of Plots
<img src="https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week4/w4_labs/w4d3optional_lab_matplotlib_seaborn/readme_media/mouse.jpg" width="800px" height="auto">

Lab instructions [here](https://github.com/redeat17/Matplotlib-Challenge "Matplotlib  challenge")

### Project brief
The lab is based on an hypothetical situation based on a real situation.
We are in a clinical laboratory of a pharmaceutical company (Pymaceuticals Inc) specialized in anti-cancer pharmaceuticals. The laboratory is researching potential treatments for squamous cell carcinoma (SCC), a skin cancer. Mice identified with SCC tumor growth are studied and treated through a variety of drug regimens. 

### Main objective
- Compare the performance of Pymaceuticals' drug of interest, Capomulin, versus the other top treatment regimens. Generate all of the tables and figures needed for the technical report of the study.

### Provided databases:
+ data_mouse_metadata.csv
+ study_results.csv

### Tools
Database: Libre office and Jupyter Notebook  
Vizualizations: Matplotlib  
Code: Jupyter Notebook  
Language: Python  

### Process
1. Import and read the DB
2. Merge the data sets and standardize header names
4. Check for any mouse with duplicated time points (remove them and reset index)
5. Statistics: a summary statistics table with the mean, median, variance, standard deviation and SEM of the tumor volume for each drug regimen.
6. Visualization: Mice x drug treatment barplots (using pandas and matplotlib) and gender pieplots (using pandas and matplotlib)
8. Statistics: calculate the final tumor volume, quartiles and IQR across the most promising treatments and quantitatively determine outliers.
9. Visualization: Create a boxplot of the final tumor volume for all four most promising treatments.
10. Visualization: Create a line plot of tumor value vs time point for one mouse treated with Capomulin. 
11. Conclusions: calculate the correlation coefficient and linear regression model between mouse weight and average tumor volume for the Capomulin treatment. 

### Conclusions
- The correlation coefficient between mouse weight and average tumor volume is 0.84. This is a good result.
- Capomulin and Ramicane are the most successsul treatments against tumors within the mice.


***

## Seaborn visualization
<img src="https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week4/w4_labs/w4d3optional_lab_matplotlib_seaborn/readme_media/pokemon.jpg" width="800px" height="auto">

Tutorials consulted:
[Pokemon Seaborn Tutorial](https://elitedatascience.com/python-seaborn-tutorial "Pokemon seaborn tutorial")
[Seaborn Style Tutorial](https://seaborn.pydata.org/tutorial/aesthetics.html "seaborn style tutorial")

### Project brief
- Using the database pokemon, create a mini-gallery visualizing the content and relationships between attacks and defenses
- Appendix: experiment with visualization style options

### Main objective
- Create different visualizations and experiment with the possibilities

### Provided databases:
+ pokemon.csv

### Tools
Database: Libre office and Jupyter Notebook  
Vizualizations: Matplotlib and Seaborn  
Code: Jupyter Notebook  
Language: Python  

### Process / Steps done
1. Importing libraries and dataset
2. Seaborn's plotting functions
3. The role of Pandas
4. Seaborn themes
5. Color palettes
6. Overlaying plots
7. Putting it all together

Mini gallery:
9. Heatmap: visualize matrix-like data
10. Histogram: plot the distributions of numeric variables
11. Bar plot: visualize the distributions of categorical variables
12. Factor Plot: to separate plots by categorical classes
13. Density Plot: display the distribution between two variables
14. Joint Distribution Plot: combine information from scatter plots and histograms to give you detailed information for bi-variate distributions.

Appendix:
16. Style
17. Reset style
18. Background
19. Axes lines
20. Temporarily setting figure style: Visualize different options in one command
21. Overriding elements of the seaborn styles
22. Scaling plot elements: paper, notebook, talk, and poster

### Conclusions
- This lab is useful to store in an organized way different kinds of visualizations and style options.



***

Thank you for reading!  
Any suggestion or question contact me on [Glòria Ibars](https://www.linkedin.com/in/gloriaibars/ "Linkedin")
