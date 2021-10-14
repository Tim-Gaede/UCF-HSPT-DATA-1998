#include <stdio.h>


FILE *infile;


double rot,blink; 	/* Rotation and blinking rates of the sign*/


double findAngle(double);
int checkBlink(double);
int checkSign(double);

void main(void) {

   int nsigns;       	/* Number of signs */
   int sign;		/* Current sign */
   int ntests;		/* Number of tests for this sign */
   int test;		/* Current test */
   double tindex;	/* Time index for this test */

   /* Open input file */
   infile = fopen("sign.in","r");

   /* Get number of signs */
   fscanf(infile,"%d\n",&nsigns);

    for (sign=0; sign<nsigns; sign++) {

	/* Get sign parameters */
	fscanf(infile,"%lf %lf\n",&rot,&blink);

	/* Get number of tests */
	fscanf(infile,"%d\n",&ntests);


	/* Begin output set */
	printf("Sign #%d:\n",sign+1);

	 for (test=0; test<ntests; test++) {

		/* Get time index for this test */
		fscanf(infile,"%lf\n",&tindex);

		/* Check sign and print results */
		printf("   %s\n",checkSign(tindex) ?
					"Mike sees it!" :
					"Mike is blind.");
	 };

	 printf("\n");
    };
}

/*
    This function computes the current angle of incidence of
    the sign based upon the global variable rot, and the time
    index passed in
*/

double findAngle(double time) {

   double angle;  	/* Holds the current angle of the sign */
   double circles;	/* Used to find the angle in the range [0,360) */
   double incidence;	/* Angle of incidence of the sign wrt Mike */

	circles = (int)( time / rot );
	angle = ((time / rot) * 360) - (circles * 360);


	if (angle >= 270)      incidence = angle - 270;
	else if (angle >= 180) incidence = 270 - angle;
	else if (angle >= 90)  incidence = angle - 90;
	else		       incidence = 90 - angle;


	return(incidence);
}

int checkBlink(double time) {

   double interval;  	/* Used to reduce the time index to an
			   interval of 2 * blink */

   double simpletime;   /* The offset of time within the corresponding
			   interval */

	interval = (int)( time / (2*blink) );
	simpletime = time - (interval * 2*blink);


	/* The sign is on if time falls in the second half
	   of the 2*blink interval, so: */

	if (simpletime >= blink)
		return(1);	/* Return TRUE if time is in the
				   second half of the interval */
	else
		return(0);      /* Return FALSE if not */

}

int checkSign(double time) {

   double angle;	/* Angle of incidence of the sign wrt Mike */
   int on;		/* Is the sign on? */


   if (rot != 0 )
	angle = findAngle(time);  /* Get angle if the sign is rotating */
   else
	angle = 90;		  /* The sign's not rotating! */


   if (blink != 0)
	on = checkBlink(time);    /* Check if it's on only if blinking */
   else
	on = 0;		          /* The sign's always dead! */


   if ( (angle > 10) && on )

	return(1);    /* Return TRUE if angle and blink are right */
   else
	return(0);    /* Return FALSE otherwise */
};

