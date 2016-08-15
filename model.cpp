/* This piece of code served me as a model which I tried to manually convert
 * into assembly language.
 * Source: https://sk.wikipedia.org/wiki/Quick_sort#C.2B.2B
 */

void swap(int array[], int left, int right){
   int tmp = array[right];
   array[right] = array[left];
   array[left] = tmp;
}

void quicksort(int array[], int left, int right){
   if(left < right){
       int boundary = left;
       for(int i = left + 1; i < right; i++){
           if(array[i] > array[left]){
               swap(array, i, ++boundary);
           }
       }
       swap(array, left, boundary);
       quicksort(array, left, boundary);
       quicksort(array, boundary + 1, right);
   }
}
