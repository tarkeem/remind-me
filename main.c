#include <stdio.h>
#include <string.h>
#include "mpi.h"

int main(int argc , char * argv[])
{
    int divisionNum;
	MPI_Init( &argc , &argv );
	int world_rank;
MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
int world_size;
MPI_Comm_size(MPI_COMM_WORLD, &world_size);
if (world_rank == 0) {

    printf("hello from master\n");
    printf("the array size;");
  int arrsize;
    scanf("%d", &arrsize);
    int arr[arrsize];
    divisionNum=arrsize/(world_size-1);
    for(int i=0;i<arrsize;i++)
    {
      scanf("%d", &arr[i]);
    }
    //******************************************
    int counter=0;

    for(int i=1;i<world_size;i++)
    {
        int sendedarr[5];
        for(int j=0;j<divisionNum;j++)
        {
            sendedarr[j]=arr[counter];
            counter++;
        }
         MPI_Send(&sendedarr, 5, MPI_INT, i, 0, MPI_COMM_WORLD);
}
    }



else{
    int arr[5];
    MPI_Recv(&arr, 5, MPI_INT, 0, 0, MPI_COMM_WORLD,
             MPI_STATUS_IGNORE);
//***********************************************

    int maxer=0;

    for(int i=0;i<5;i++)
    {
        if(arr[i]>maxer)
        {

            maxer=arr[i];
        }
    }



        printf("Process 1 received number %d from process 0\n",
           maxer);

}
	/* shutdown MPI */
	MPI_Finalize();
	return 0;
}
