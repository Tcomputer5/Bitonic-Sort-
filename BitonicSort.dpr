(*Program for Bitonic Sort. Note that this program 
works only when size of input is a power of 2. *)

Program Bitonicsort;
uses sysutils, DateUtils;

var a :  array[0..100] of Integer;
    i: Integer;
    up : Boolean;
    t_size: Integer;
    DateTime1 ,  DateTime2 : TTime ;
    

procedure Swap(var first, second: Integer);
var tmp: Integer;
begin
  tmp:=first;
  first:= second;
  second:=tmp;
end;

(*The parameter dir indicates the sorting direction, ASCENDING 
or DESCENDING; if (a[i] > a[j]) agrees with the direction, 
then a[i] and a[j] are interchanged.*)

procedure compAndSwap(var table : array of Integer; i,j: Integer; dir: Boolean);
begin
  if dir = (a[i]>a[j]) then
		Swap(a[i],a[j]); 
end;

(*It recursively sorts a bitonic sequence in ascending order, 
  if dir = true, and in descending order otherwise (means dir=false). 
  The sequence to be sorted starts at index position low, 
  the parameter cnt is the number of elements to be sorted.*)

procedure bitonicMerge(var a :  array of Integer; low, cnt:Integer; dir:Boolean); 
    var i,k: Integer;
    begin
      if (cnt>1) then
        begin
            k := cnt div 2; 
            for  i:=low to low+k-1 do 
                begin
                    compAndSwap(a, i, i+k, dir);   
                end;    
            bitonicMerge(a, low, k, dir); 
            bitonicMerge(a, low+k, k, dir); 
        end;
      
    end;


(* This function first produces a bitonic sequence by recursively 
    sorting its two halves in opposite sorting orders, and then 
    calls bitonicMerge to make them in the same order *)

procedure bitonicSort(a :  array of Integer; low, cnt : Integer; dir: Boolean);
    var k: Integer;
    begin
      if (cnt>1) then 
        begin
           k:=0;
           k:= cnt div 2; 

            // sort in ascending order since dir here is 1 
            bitonicSort(a, low, k, True); 
             // sort in descending order since dir here is 0 
            bitonicSort(a, low+k, k, False); 

            // Will merge wole sequence in ascending order 
            // since dir=1. 
            bitonicMerge(a,low, cnt, dir); 
        end;
    end;
(* Caller of bitonicSort for sorting the entire array of 
   length N in ASCENDING order *)

procedure sort(a :  array of Integer;  N: Integer; up : Boolean);
    begin
        bitonicSort(a,0, N, up);  
    end;
    
begin
    i:=0;
    t_size :=0;
    WriteLn('Entrez la taille du tableau');
    ReadLn(t_size);
    
   //SetLength(a, t_size); 
   
    for i:=0 to  t_size - 1 do
      begin
        writeln('entrez la valeur ', i+1, ' du tableau');
        ReadLn(a[i]);
      end; 
    up := True;   // means sort in ascending order 
    DateTime1:= Now;
    sort(a, t_size, up); 
    DateTime2 :=Now; 
    WriteLn(' '); 

    WriteLn('Sorted array: '); 
     WriteLn(' '); 
    
    for i:=0 to  t_size-1 do
      begin
        write(a[i], ' | ');
       
    end; 

    WriteLn('');
     WriteLn('la valeur est ', t_size);
     writeln ('Sorting time "hh:mm:ss" ', TimeToStr(DateTime2 - DateTime1));
     
 
end.
