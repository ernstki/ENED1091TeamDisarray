/* S-Function to sort a vector using quicksort ***** Giampy **** June 2005 ****************** */

#define S_FUNCTION_NAME qsort
#define S_FUNCTION_LEVEL 2

#include "simstruc.h"
#include "stdio.h"     /* for file handling */

/* sort using the quicksort algorithm as in http://en.wikipedia.org/wiki/Quicksort            */
void swap(double *a, double *b) { double t=*a; *a=*b; *b=t; }

void sort(double arr[], int beg, int end) 
{
  if (end > beg + 1) 
  {
    double piv = arr[beg];
	int l = beg + 1, r = end;
    while (l < r) 
    {
      if (arr[l] <= piv) 
        l++;
      else 
        swap(&arr[l], &arr[--r]);
    }
    swap(&arr[--l], &arr[beg]);
    sort(arr, beg, l);
    sort(arr, r, end);
  }
}

/* mdlCheckParameters, check parameters, this routine is called later from mdlInitializeSizes */
#define MDL_CHECK_PARAMETERS
static void mdlCheckParameters(SimStruct *S)
{
}


/* mdlInitializeSizes - initialize the sizes array ********************************************/
static void mdlInitializeSizes(SimStruct *S) {

    ssSetNumSFcnParams(S,0);                          /* number of expected parameters        */

    /* Check the number of parameters and then calls mdlCheckParameters to see if they are ok */
    if (ssGetNumSFcnParams(S) == ssGetSFcnParamsCount(S))
    { 
		mdlCheckParameters(S); 
		if (ssGetErrorStatus(S) != NULL) return; 
	} 
	else return;

    ssSetNumContStates(S,0);                          /* number of continuous states          */
    ssSetNumDiscStates(S,0);                          /* number of discrete states            */

	/* input port */
    if (!ssSetNumInputPorts(S,1)) return;             /* number of input ports                */
    ssSetInputPortWidth(S,0,-1);                      /* first input port width               */
	ssSetInputPortDirectFeedThrough(S,0,1);           /* first port direct feedthrough flag   */

	/* output port */
    if (!ssSetNumOutputPorts(S,1)) return;            /* number of output ports               */

    ssSetOutputPortWidth(S,0,-1);                     /* first output port width              */

	/* sample time */
    ssSetNumSampleTimes(S,0);                         /* number of sample times               */

	/* work vectors */
	ssSetNumRWork(S,0);                               /* number real work vector elements     */
    ssSetNumIWork(S,0);                               /* number int work vector elements      */
    ssSetNumPWork(S,0);                               /* number ptr work vector elements      */
    ssSetNumModes(S,0);                               /* number mode work vector elements     */
    ssSetNumNonsampledZCs(S,0);                       /* number of nonsampled zero crossing   */
}

/* mdlInitializeSampleTimes - initialize the sample times array *******************************/
static void mdlInitializeSampleTimes(SimStruct *S) {
    ssSetSampleTime(S, 0, INHERITED_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0);
}

/* mdlStart - initialize hardware *************************************************************/
#define MDL_START
static void mdlStart(SimStruct *S) {
}

/* mdlOutputs - compute the outputs ***********************************************************/
static void mdlOutputs(SimStruct *S, int_T tid) {

	int i,N;

	/* output and input Pointers Initialization */
	real_T             *y  = ssGetOutputPortRealSignal(S,0);
	InputRealPtrsType  up  = ssGetInputPortRealSignalPtrs(S,0);

    N=ssGetInputPortWidth(S,0);                      /* first input port width               */

	for(i=0;i<N;i++)
		y[i] = *up[i];

    sort(y,0,N);

}


/* mdlTerminate - called when the simulation is terminated ***********************************/
static void mdlTerminate(SimStruct *S) {
}

/* Trailer information to set everything up for simulink usage *******************************/
#ifdef  MATLAB_MEX_FILE                      /* Is this file being compiled as a MEX-file?   */
#include "simulink.c"                        /* MEX-file interface mechanism                 */
#else
#include "cg_sfun.h"                         /* Code generation registration function        */
#endif
