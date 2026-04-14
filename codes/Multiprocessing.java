import java.util.ArrayList;
import java.util.List;

class Multiprocessing{
    public static void main(String[] args) throws Exception{
        int tasks=10000;
        List<Thread> t=new ArrayList<>();
        for (int i =0;i<tasks;i++){
            Thread thread=new Thread(()->{
                try{
                    Thread.sleep(100);

                }catch(Exception e){
                    System.out.println(e);
                }
            });
            t.add(thread);
            
        }
        for (Thread thread: t){
            thread.join();
        }
            
    }
}
